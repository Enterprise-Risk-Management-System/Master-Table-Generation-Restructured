
/* ============================================================================
   Module: config/index.sas
   Description: Main configuration assembler - includes all domain configurations
   Includes: riskModule/riskModulesConfig.sas, masterTableReports/masterTableReportsConfig.sas,
             api/apiEndpoints.sas
   ============================================================================ */

/* Include all domain configuration modules */
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\config\riskModule\riskModulesConfig.sas";
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\config\masterTableReports\masterTableReportsConfig.sas";
%include "C:\Users\62917\Master_Table_Generation_Restructured\frontend\config\api\apiEndpoints.sas";

/* ============================================================================
   Main Macro: Generate All Configurations
   Generates all domain configurations in the correct order
   ============================================================================ */
%macro mt_config_new;

    /* Risk category landing cards */
    %riskModulesConfig;

    /* Master table report prompt definitions */
    %masterTableReportsConfig;

    /* Stored procedure endpoints */
    %apiEndpoints;

%mend mt_config_new;
