
/* ============================================================================
   SACCR / CVA SAMPLE DATA
   Provides a static JS constant (SACCR_SAMPLE_DATA) that mirrors the shape
   the SACCR_CVA_2 stored process returns, for offline / demo use.

   Keys match the COLUMN_MAPS defined in saccrResultsView.sas.
   ============================================================================ */
%macro saccrSampleData;

    put 'const SACCR_SAMPLE_DATA = {';

    /* ── saccr_header: one aggregate row shown as KPI stat cards ── */
    put '  "saccr_header": [{';
    put '    "number_of_netting_sets": 12,';
    put '    "number_of_trades": 48,';
    put '    "rc_net_margined_yl": "2,450,000",';
    put '    "pfe": "1,820,000",';
    put '    "saccr_charge": "875,000"';
    put '  }],';

    /* ── cva_header: one aggregate row shown as KPI stat cards ── */
    put '  "cva_header": [{';
    put '    "r_amount": "320,000",';
    put '    "capital_charge": "128,000",';
    put '    "rwa": "1,600,000"';
    put '  }],';

    /* ── summary_table: one row per netting set ── */
    put '  "summary_table": [';
    put '    {';
    put '      "netting_set_id": "NS001", "as_of_date": "2025-12-31", "number_of_trades": 8,';
    put '      "replacement_cost": "450,000", "pfe": "320,000", "ead": "770,000",';
    put '      "rwa": "1,925,000", "saccr_capital_charge": "154,000", "asset_class": "Interest Rate"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS002", "as_of_date": "2025-12-31", "number_of_trades": 6,';
    put '      "replacement_cost": "280,000", "pfe": "195,000", "ead": "475,000",';
    put '      "rwa": "1,187,500", "saccr_capital_charge": "95,000", "asset_class": "FX"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS003", "as_of_date": "2025-12-31", "number_of_trades": 12,';
    put '      "replacement_cost": "620,000", "pfe": "480,000", "ead": "1,100,000",';
    put '      "rwa": "2,750,000", "saccr_capital_charge": "220,000", "asset_class": "Credit"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS004", "as_of_date": "2025-12-31", "number_of_trades": 4,';
    put '      "replacement_cost": "180,000", "pfe": "130,000", "ead": "310,000",';
    put '      "rwa": "775,000", "saccr_capital_charge": "62,000", "asset_class": "Equity"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS005", "as_of_date": "2025-12-31", "number_of_trades": 18,';
    put '      "replacement_cost": "920,000", "pfe": "695,000", "ead": "1,615,000",';
    put '      "rwa": "4,037,500", "saccr_capital_charge": "323,000", "asset_class": "Commodity"';
    put '    }';
    put '  ],';

    /* ── comparison_report: current vs previous period EAD / RWA ── */
    put '  "comparison_report": [';
    put '    {';
    put '      "netting_set_id": "NS001", "ead_current": 770000, "ead_previous": 730000,';
    put '      "ead_diff": 40000, "ead_pct_change": 5.48,';
    put '      "saccr_rwa_current": "1,925,000", "saccr_rwa_previous": "1,825,000", "capital_charge": "154,000"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS002", "ead_current": 475000, "ead_previous": 490000,';
    put '      "ead_diff": -15000, "ead_pct_change": -3.06,';
    put '      "saccr_rwa_current": "1,187,500", "saccr_rwa_previous": "1,225,000", "capital_charge": "95,000"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS003", "ead_current": 1100000, "ead_previous": 980000,';
    put '      "ead_diff": 120000, "ead_pct_change": 12.24,';
    put '      "saccr_rwa_current": "2,750,000", "saccr_rwa_previous": "2,450,000", "capital_charge": "220,000"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS004", "ead_current": 310000, "ead_previous": 310000,';
    put '      "ead_diff": 0, "ead_pct_change": 0,';
    put '      "saccr_rwa_current": "775,000", "saccr_rwa_previous": "775,000", "capital_charge": "62,000"';
    put '    },';
    put '    {';
    put '      "netting_set_id": "NS005", "ead_current": 1615000, "ead_previous": 1420000,';
    put '      "ead_diff": 195000, "ead_pct_change": 13.73,';
    put '      "saccr_rwa_current": "4,037,500", "saccr_rwa_previous": "3,550,000", "capital_charge": "323,000"';
    put '    }';
    put '  ],';

    /* ── exception_report: data quality issues flagged during processing ── */
    put '  "exception_report": [';
    put '    {';
    put '      "error_id": "ERR001", "netting_set_id": "NS003", "field": "collateral_amount",';
    put '      "error_type": "Missing Value", "description": "Collateral amount is null for this netting set"';
    put '    },';
    put '    {';
    put '      "error_id": "ERR002", "netting_set_id": "NS005", "field": "trade_type",';
    put '      "error_type": "Invalid Entry", "description": "Trade type code not recognized in reference table"';
    put '    },';
    put '    {';
    put '      "error_id": "ERR003", "netting_set_id": "NS002", "field": "margin_agreement",';
    put '      "error_type": "Warning", "description": "Margin agreement expiry date is within 30 days"';
    put '    }';
    put '  ]';

    put '};';

%mend saccrSampleData;
