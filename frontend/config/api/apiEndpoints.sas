
/* ============================================================================
   STORED PROCEDURE ENDPOINTS
   Keyed by report id (matches the "id" used in masterTableReportsConfig).
   Only saccr-cva and sama-p3 are wired to a live stored process today.
   ============================================================================ */

/* ----------------------------------------------------------------------------
   Macro: apiEndpoints

   Purpose:
     Emits (via PUT) the JavaScript object "masterTableReportEndpoints" into
     the generated front-end config file. This object maps each report's
     "id" (as defined in masterTableReportsConfig.sas) to the URL of the SAS
     Stored Process that actually runs/generates that report.

     The front end reads this map at runtime (see
     masterTableReportGeneration.sas, which looks up
     masterTableReportEndpoints[reportType]) to know which Stored Process
     endpoint to call for the report the user selected.

   Notes:
     - Object.freeze(...) is used so the resulting JS object cannot be
       mutated at runtime (read-only config, by design).
     - Each PUT call below writes exactly one line of generated JavaScript;
       keep the JS syntax (commas, quotes, braces) correct across PUT calls,
       since SAS itself does not validate the JS being emitted.
     - Not every report id has a live Stored Process yet -- see the TODO
       list below for the ones still pending.
   ---------------------------------------------------------------------------- */
%macro apiEndpoints;

    /* Open the JS object literal. Object.freeze() makes it immutable in JS. */
    put 'const masterTableReportEndpoints = Object.freeze({';

    /* --- Live / wired-up endpoints ----------------------------------------- */

    /* SACCR & CVA report -> Stored Process URL (trailing comma: more keys follow) */
    put '  "saccr-cva": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/Master Tables Preparation/SACCR and CVA/SACCR_CVA_2",';

    /* SAMA Pillar 3 (IRRBB) report -> Stored Process URL (last key: no trailing comma) */
    put '  "sama-p3": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/IRRBB/IRRBB Execution"';

    /* --- Pending endpoints --------------------------------------------------
       These report ids exist in masterTableReportsConfig.sas but do not yet
       have a Stored Process wired up. This comment is emitted as a literal
       JS comment inside the generated file as a visible reminder/TODO.
       ------------------------------------------------------------------------ */
    put '  /* TODO: wire up stored procedure endpoints for sama-q17, sama-q17-2, asset1, asset2, liability, customer, offbalance */';

    /* Close the JS object literal / statement. */
    put '});';

%mend apiEndpoints;
