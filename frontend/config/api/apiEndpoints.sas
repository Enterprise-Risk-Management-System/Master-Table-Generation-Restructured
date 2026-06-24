
/* ============================================================================
   STORED PROCEDURE ENDPOINTS
   Keyed by report id (matches the "id" used in masterTableReportsConfig).
   Only saccr-cva and sama-p3 are wired to a live stored process today.
   ============================================================================ */

%macro apiEndpoints;

    put 'const masterTableReportEndpoints = Object.freeze({';

    put '  "saccr-cva": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/Master Tables Preparation/SACCR and CVA/SACCR_CVA_2",';

    put '  "sama-p3": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/IRRBB/IRRBB Execution"';

    put '  /* TODO: wire up stored procedure endpoints for sama-q17, sama-q17-2, asset1, asset2, liability, customer, offbalance */';

    put '});';

%mend apiEndpoints;
