
/* ============================================================================
   SACCR SUMMARY STORED PROCESS BACKEND
   SAS Stored Process entry point: SACCR_CVA_2

   Input parameter (POST body):
     reporting_date — date string sent by the frontend (ISO "YYYY-MM-DD" or
                      SAS date9. "DDMONYYYY").  Normalised to date9. in Step 0.

   Output:
     JSON written to _webout — consumed by MTSaccrResults.render() in the
     Master Table Generation dashboard.

   JSON structure (keys must match saccrResultsView.sas COLUMN_MAPS):
     {
       saccr_header      : [ one aggregate row — KPI stat cards ],
       cva_header        : [],
       summary_table     : [ one row per netting set ],
       comparison_report : [ one row per netting set — current vs previous period ],
       exception_report  : []
     }
   ============================================================================ */


/* Set HTTP response content type to JSON */
data _null_;
    rc = stpsrv_header('Content-type', 'application/json;charset=utf-8');
run;


/* ── Step 0: Normalise reporting_date to SAS date9. format (DDMONYYYY) ──────
   Accepts both ISO "YYYY-MM-DD" and date9. "DDMONYYYY" from the frontend.    */
data _null_;
    d = input("&reporting_date.", yymmdd10.);
    if missing(d) then d = input("&reporting_date.", date9.);
    call symputx('reporting_date', put(d, date9.));
run;


/* ── Step 1: Filter source table by reporting date ── */
data SACCR_SUMMARY(
    keep = As_of_date
           Netting_set_id
           NUMBER_OF_TRADES
           NOTIONAL_AMOUNT_LCY_ABS
           REPLACEMENT_COST
           PFE
           EAD
           RWA
           SACCR_CAPITAL_CHARGE
);
    set orc_lib.SACCR_SUMMARY_AGG_NS(
        where=(datepart(As_of_date) = "&reporting_date."d)
    );
run;


/* ── Step 2: Aggregate header KPIs (one summary row) ── */
proc summary data=SACCR_SUMMARY;
    var NUMBER_OF_TRADES REPLACEMENT_COST PFE EAD SACCR_CAPITAL_CHARGE;
    output out=SACCR_HEADER(
        drop   = _TYPE_
        rename = (_FREQ_ = number_of_netting_sets)
    )
        sum(NUMBER_OF_TRADES)      = number_of_trades
        sum(REPLACEMENT_COST)      = rc_net_margined_yl
        sum(PFE)                   = pfe
        sum(EAD)                   = ead
        sum(SACCR_CAPITAL_CHARGE)  = saccr_charge;
run;


/* ── Step 3: Comparison Report ──────────────────────────────────────────────
   Compares the user-supplied reporting_date against the nearest prior month-end
   that has data in ORC_LIB.SACCR_CVA.  Skipped entirely when reporting_date
   is already the earliest available date in the table.

   Output dataset: COMPARISON_REPORT with fixed column names that match the
   frontend COLUMN_MAPS.comparison keys:
     netting_set_id, ead_current, ead_previous, ead_diff, ead_pct_change,
     saccr_rwa_current, saccr_rwa_previous, capital_charge
   (DEAL_INDICATOR is also included for sorting / tooltip context.)            */

/* Find the earliest as-of-date in the CVA source table */
proc sql noprint;
    select min(datepart(as_of_date)) format=date9.
        into: min_as_of_date
        from ORC_LIB.SACCR_CVA;
quit;

/* Initialise Prev_date so the symbol always exists */
%let Prev_date = ;

/* Walk backwards from reporting_date to find a previous month-end with data  */
%macro calculate_prev_date;

    /* Compute the last day of the month preceding <date> */
    %macro Previous_date(date=);
        %global Prev_date;
        data _null_;
            format as_of_date date_wanted date9.;
            as_of_date  = input(symget('date'), date9.);
            month       = put(as_of_date, monname3.);
            year        = strip(put(year(as_of_date), 4.));
            date_wanted = input(cats(month, year), monyy7.) - 1;
            call symputx('Prev_date', put(date_wanted, date9.));
        run;
    %mend;

    %Previous_date(date=&reporting_date.);

    /* No prior period when we are already at the earliest date */
    %if %sysfunc(upcase(&reporting_date.)) = %sysfunc(upcase(&min_as_of_date.)) %then %goto skip;

    /* Scan earlier months until one with actual data is found */
    %macro check_prev_date_exists;
        %let should_continue = 1;
        %do %while(&should_continue.);
            %let dsid    = %sysfunc(open(ORC_LIB.SACCR_CVA(where=(datepart(as_of_date)="&Prev_date."d))));
            %let numobs  = %sysfunc(attrn(&dsid., nlobsf));
            %let rc_cl   = %sysfunc(close(&dsid.));
            %if &numobs. > 0 %then %let should_continue = 0;
            %else %Previous_date(date=&Prev_date.);
        %end;
    %mend;
    %check_prev_date_exists;

    %skip:
%mend;
%calculate_prev_date;


/* Build the comparison dataset (or an empty placeholder at the earliest date) */
%macro build_comparison_report;

    /* At the earliest available date there is no prior period to compare */
    %if %sysfunc(upcase(&reporting_date.)) = %sysfunc(upcase(&min_as_of_date.)) %then %do;
        data COMPARISON_REPORT;
            length NETTING_SET_ID $50 DEAL_INDICATOR $10;
            format EAD_CURRENT EAD_PREVIOUS EAD_DIFF EAD_PCT_CHANGE
                   SACCR_RWA_CURRENT SACCR_RWA_PREVIOUS CAPITAL_CHARGE comma32.;
            stop;
        run;
        %return;
    %end;

    /* ── 3a: Netting sets that existed in Prev_date but not in reporting_date */
    proc sql;
        create table Expired_Netting_set as
            select distinct netting_set_id
            from ORC_LIB.SACCR_CVA
            where datepart(as_of_date) = "&Prev_date."d
              and netting_set_id not in (
                  select netting_set_id from ORC_LIB.SACCR_CVA
                  where datepart(as_of_date) = "&reporting_date."d
              );
    quit;

    /* ── 3b: Netting sets that are new in reporting_date (absent in Prev_date) */
    proc sql;
        create table New_Netting_set as
            select distinct netting_set_id
            from ORC_LIB.SACCR_CVA
            where datepart(as_of_date) = "&reporting_date."d
              and netting_set_id not in (
                  select netting_set_id from ORC_LIB.SACCR_CVA
                  where datepart(as_of_date) = "&Prev_date."d
              );
    quit;

    /* ── 3c: Full-outer join — current vs previous period aggregates ── */
    proc sql;
        create table comparison_summary_1 as
            select
                coalescec(a.netting_set_id, b.netting_set_id) as NETTING_SET_ID,
                a.EAD_CURRENT        format=comma32.,
                b.EAD_PREVIOUS       format=comma32.,
                a.SACCR_RWA_CURRENT  format=comma32.,
                b.SACCR_RWA_PREVIOUS format=comma32.,
                a.CVA_RWA_CURRENT    format=comma32.,
                b.CVA_RWA_PREVIOUS   format=comma32.
            from
                (
                    select
                        netting_set_id,
                        avg(EAD_NS)       as EAD_CURRENT,
                        avg(SACCR_RWA_NS) as SACCR_RWA_CURRENT,
                        avg(CVA_RWA_TOT)  as CVA_RWA_CURRENT
                    from ORC_LIB.SACCR_CVA
                    where datepart(as_of_date) = "&reporting_date."d
                      and EXTL_INTL_TRADE = "E"
                    group by netting_set_id
                ) a
                full outer join
                (
                    select
                        netting_set_id,
                        avg(EAD_NS)       as EAD_PREVIOUS,
                        avg(SACCR_RWA_NS) as SACCR_RWA_PREVIOUS,
                        avg(CVA_RWA_TOT)  as CVA_RWA_PREVIOUS
                    from ORC_LIB.SACCR_CVA
                    where datepart(as_of_date) = "&Prev_date."d
                      and EXTL_INTL_TRADE = "E"
                    group by netting_set_id
                ) b on a.netting_set_id = b.netting_set_id
        ;
    quit;

    /* ── 3d: Compute variances; replace missing with 0 for arithmetic ── */
    data comparison_summary_2(drop=i);
        retain NETTING_SET_ID
               EAD_CURRENT EAD_PREVIOUS EAD_DIFF EAD_PCT_CHANGE
               SACCR_RWA_CURRENT SACCR_RWA_PREVIOUS SACCR_RWA_DIFF
               CVA_RWA_CURRENT   CVA_RWA_PREVIOUS   CVA_RWA_DIFF;
        set comparison_summary_1;
        format EAD_DIFF EAD_PCT_CHANGE SACCR_RWA_DIFF CVA_RWA_DIFF comma32.;
        array num(*) _numeric_;
        do i = 1 to dim(num);
            if missing(num{i}) then num{i} = 0;
        end;
        EAD_DIFF         = EAD_CURRENT - EAD_PREVIOUS;
        EAD_PCT_CHANGE   = ifn(EAD_PREVIOUS ne 0,
                               (EAD_DIFF / abs(EAD_PREVIOUS)) * 100, .);
        SACCR_RWA_DIFF   = SACCR_RWA_CURRENT - SACCR_RWA_PREVIOUS;
        CVA_RWA_DIFF     = CVA_RWA_CURRENT    - CVA_RWA_PREVIOUS;
    run;

    /* ── 3e: Total RWA aggregates across all netting sets ── */
    proc sql noprint;
        select
            sum(SACCR_RWA_CURRENT)  format=best50.,
            sum(SACCR_RWA_PREVIOUS) format=best50.,
            sum(CVA_RWA_CURRENT)    format=best50.,
            sum(CVA_RWA_PREVIOUS)   format=best50.
            into: SACCR_RWA_TOT_CURRENT,  :SACCR_RWA_TOT_PREVIOUS,
                  :CVA_RWA_TOT_CURRENT,   :CVA_RWA_TOT_PREVIOUS
        from comparison_summary_2;
    quit;

    data comparison_summary;
        set comparison_summary_2;
        format RWA_TOT_CURRENT RWA_TOT_PREVIOUS RWA_TOT_DIFF comma32.;
        RWA_TOT_CURRENT  = sum(&SACCR_RWA_TOT_CURRENT.,  &CVA_RWA_TOT_CURRENT.);
        RWA_TOT_PREVIOUS = sum(&SACCR_RWA_TOT_PREVIOUS., &CVA_RWA_TOT_PREVIOUS.);
        RWA_TOT_DIFF     = RWA_TOT_CURRENT - RWA_TOT_PREVIOUS;
    run;

    /* ── 3f: Ordering format for Deal Indicator sort ── */
    proc format;
        value $ind
            'ACTIVE'  = 1
            'NEW'     = 2
            'MATURED' = 3
        ;
    run;

    /* ── 3g: Final output — fixed column names that match COLUMN_MAPS ── */
    proc sql;
        create table COMPARISON_REPORT as
            select
                a.NETTING_SET_ID,
                a.EAD_CURRENT,
                a.EAD_PREVIOUS,
                a.EAD_DIFF,
                a.EAD_PCT_CHANGE,
                a.SACCR_RWA_CURRENT,
                a.SACCR_RWA_PREVIOUS,
                a.RWA_TOT_DIFF      as CAPITAL_CHARGE,
                (case
                    when b.netting_set_id is not null then 'MATURED'
                    when c.netting_set_id is not null then 'NEW'
                    else 'ACTIVE'
                 end)               as DEAL_INDICATOR
            from
                comparison_summary       a
                left join Expired_Netting_set b on a.netting_set_id = b.netting_set_id
                left join New_Netting_set     c on a.netting_set_id = c.netting_set_id
            order by put(calculated DEAL_INDICATOR, $ind.), a.netting_set_id
        ;
    quit;

%mend build_comparison_report;
%build_comparison_report;


/* ── Step 4: Write JSON to _webout ── */
proc json out=_webout pretty nosastags;
    write open object;

    /* Aggregate KPI row — rendered as stat cards in the dashboard */
    write values "saccr_header";
    export SACCR_HEADER / nosastags;

    /* CVA data not available from this dataset — return empty array */
    write values "cva_header";
    write open array;
    write close;

    /* One row per netting set — rendered in the SACCR Summary tab table */
    write values "summary_table";
    export SACCR_SUMMARY / nosastags;

    /* Current vs previous period comparison — rendered in Comparison Report tab */
    write values "comparison_report";
    export COMPARISON_REPORT / nosastags;

    /* Exception report not generated by this process */
    write values "exception_report";
    write open array;
    write close;

    write close;
run;
