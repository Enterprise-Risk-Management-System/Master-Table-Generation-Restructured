
/* ============================================================================
   MASTER TABLE REPORTS CONFIGURATION
   One entry per route hash. Each route renders one or more prompt cards
   via buildMasterTableRoute() / getpromptHTML() (see routes/masterTables).
   ============================================================================ */
%macro masterTableReportsConfig;
    put 'const masterTableReportsConfig = Object.freeze({';

    put '  "#saccr-cva": [';
    put '    {';
    put '      id: "saccr-cva",';
    put '      title: "SACCR and CVA",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Weekly / Monthly",';
    put '      fields: [{ id: "asof", label: "As of Date", type: "date" }]';
    put '    }';
    put '  ],';

    put '  "#sama-q17": [';
    put '    {';
    put '      id: "sama-q17",';
    put '      title: "SAMA Q17 Uploads",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Quarterly",';
    put '      fields: [';
    put '        { id: "asof", label: "As of Date", type: "date" },';
    put '        { id: "report", label: "Report Pack", type: "select", options: ["Consolidated_Liquidity_Risk", "Consolidated_FRTB", "Consolidated_IRRBB", "Consolidated_Credit_Risk"] },';
    put '        { id: "uploadDoc", label: "Upload Sheet", type: "file" }';
    put '      ]';
    put '    },';
    put '    {';
    put '      id: "sama-q17-2",';
    put '      title: "SAMA Q17 Data Preparation",';
    put '      description: "Internal review and feedback submission for Q17 uploads.",';
    put '      frequency: "Quarterly",';
    put '      datasetSelector: true,';
    put '      fields: [';
    put '        { id: "RunType", label: "Run Type", type: "select", options: ["Weekly_Run", "Qtr_Run"] },';
    put '        { id: "asof", label: "As of Date", type: "date" },';
    put '        { id: "londonDate", label: "London Date", type: "date" }';
    put '      ]';
    put '    }';
    put '  ],';

    put '  "#sama-p3": [';
    put '    {';
    put '      id: "sama-p3",';
    put '      title: "IRRBB",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Daily",';
    put '      fields: [{ id: "asof", label: "As of Date", type: "date" }]';
    put '    }';
    put '  ],';

    put '  "#assets": [';
    put '    {';
    put '      id: "asset1",';
    put '      title: "Assets before Adjustment",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Quarterly",';
    put '      fields: [';
    put '        { id: "asof1", label: "As of Date", type: "date" },';
    put '        { id: "asof2", label: "IFRS9", type: "date" },';
    put '        { id: "asof3", label: "COMM_ADJ_DATE", type: "date" },';
    put '        { id: "asof4", label: "ANBI DATE", type: "date" },';
    put '        { id: "asof5", label: "LONDON DATE", type: "date" }';
    put '      ]';
    put '    },';
    put '    {';
    put '      id: "asset2",';
    put '      title: "Assets Reconcilation Process",';
    put '      description: "Internal review and feedback submission for Q17 uploads.",';
    put '      frequency: "Quarterly",';
    put '      fields: [';
    put '        { id: "asof6", label: "As of Date", type: "date" },';
    put '        { id: "asof7", label: "IFRS9", type: "date" },';
    put '        { id: "asof8", label: "COMM_ADJ_DATE", type: "date" },';
    put '        { id: "asof9", label: "ANBI DATE", type: "date" },';
    put '        { id: "asof10", label: "LONDON DATE", type: "date" }';
    put '      ]';
    put '    }';
    put '  ],';

    put '  "#liability": [';
    put '    {';
    put '      id: "liability",';
    put '      title: "Liabilities Reconcilation Process",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Weekly / Monthly",';
    put '      fields: [';
    put '        { id: "asof", label: "As of Date", type: "date" },';
    put '        { id: "asofLN", label: "London Date", type: "date" }';
    put '      ]';
    put '    }';
    put '  ],';

    put '  "#customer": [';
    put '    {';
    put '      id: "customer",';
    put '      title: "Customer MT",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Weekly / Monthly",';
    put '      fields: [{ id: "asof", label: "As of Date", type: "date" }]';
    put '    }';
    put '  ],';

    put '  "#offbalance": [';
    put '    {';
    put '      id: "offbalance",';
    put '      title: "Off Balance Reconcilation Process",';
    put '      description: "Quarterly regulatory report for SAMA compliance monitoring and risk assessment.",';
    put '      frequency: "Weekly / Monthly",';
    put '      fields: [';
    put '        { id: "asof1", label: "As of Date", type: "date" },';
    put '        { id: "asofLN", label: "London Date", type: "date" },';
    put '        { id: "firmDate", label: "Firm&Non Firm Date", type: "date" }';
    put '      ]';
    put '    }';
    put '  ]';

    put '});';
%mend masterTableReportsConfig;
