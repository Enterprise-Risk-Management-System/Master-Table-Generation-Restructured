
/* ============================================================================
   Module: javascript/routes/index.sas
   Description: Includes all route builders and bundles them into %Routes
   ============================================================================ */
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\javascript\routes\riskCategories\buildRiskCategory.sas";
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\javascript\routes\masterTables\buildMasterTableReport.sas";

%macro Routes;

    %buildRiskCategory;

    %buildMasterTableReport;

%mend Routes;
