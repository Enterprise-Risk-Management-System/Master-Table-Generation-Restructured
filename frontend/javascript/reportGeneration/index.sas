
/* ============================================================================
   Module: javascript/reportGeneration/index.sas
   Description: Includes all report-generation modules and bundles them
                into %Report_Generation
   ============================================================================ */
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\javascript\reportGeneration\masterTableReports\masterTableReportGeneration.sas";

%macro Report_Generation;

    %masterTableReportGeneration;

%mend Report_Generation;
