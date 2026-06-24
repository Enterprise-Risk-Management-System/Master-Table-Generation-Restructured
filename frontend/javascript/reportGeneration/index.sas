
/* ============================================================================
   Module: javascript/reportGeneration/index.sas
   Description: Includes all report-generation modules and bundles them
                into %Report_Generation
   ============================================================================ */
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\javascript\reportGeneration\masterTableReports\masterTableReportGeneration.sas";
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\javascript\reportGeneration\masterTableReports\saccrResultsView.sas";

/* Bundles the SACCR/CVA results renderer and the generic report-run handler */
%macro Report_Generation;

    %generate_saccr_results_view;

    %masterTableReportGeneration;

%mend Report_Generation;
