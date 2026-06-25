
/* ============================================================================
   STORED PROCEDURE ENDPOINTS
   Keyed by report id (matches the "id" used in masterTableReportsConfig).
   Only saccr-cva and sama-p3 are wired to a live stored process today.
   ============================================================================ */

%macro apiEndpoints;

    put 'const masterTableReportEndpoints = Object.freeze({';

    put '  "saccr-cva": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/Master Tables Preparation/SACCR and CVA/SACCR_CVA_2",';

    put '  "sama-p3": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/IRRBB/IRRBB Execution"';

    put '  /* TODO: wire up stored procedure endpoints for sama-q17, asset1, asset2, liability, customer, offbalance */';
    put '  /* sama-q17-2 run endpoint placeholder — replace with real stored process path */';
    put '  /* "sama-q17-2": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/SAMA Q17/Q17_Data_Preparation" */';

    put '});';

    /* Availability pre-check endpoints — keyed by report id.
       Each endpoint receives reporting_date + datasets (comma-separated keys)
       and must return JSON: { "credit-risk": true/false, "liquidity-risk": true/false, ... } */
    put 'const masterTableAvailabilityEndpoints = Object.freeze({';
    put '  /* TODO: wire up availability check endpoint for sama-q17-2 — replace placeholder path */';
    put '  /* "sama-q17-2": "https://enterprisebsl.anb.com.sa/SASStoredProcess/do?&_program=/User Folders/62917/My Folder/SAMA Q17/Q17_Dataset_Availability_Check" */';
    put '});';

%mend apiEndpoints;
