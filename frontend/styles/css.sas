
/* ============================================================================
   CSS STYLES GENERATOR
   ============================================================================ */
%macro generate_css_styles;
    put '<style>';

    /* Base Styles */
    %generate_base_styles;

    /* Layout Components */
    %generate_navbar_styles;
    %generate_main_content_styles;

    /* UI Components */
    %generate_card_styles;
    %generate_button_styles;
    %generate_modal_styles;
    %generate_notification_styles;

    /* Risk Module Styles */
    %generate_risk_module_styles;

    /* Responsive Design */
    %generate_responsive_styles;

    /* Animations */
    %generate_animation_styles;

    /* Dashboard Table Styles */
    %generate_dashboard_table_styles;

    /* Report Results Panel (tabs, extra status badges) */
    %generate_results_panel_styles;

    /* Dataset Selector Panel (SAMA Q17 Data Preparation) */
    %generate_dataset_selector_styles;

    put '</style>';
%mend generate_css_styles;

/* ============================================================================
   BASE STYLES
   ============================================================================ */
%macro generate_base_styles;
    put '* { margin: 0; padding: 0; box-sizing: border-box; }';
    put 'body { font-family: "Inter", "Arial", sans-serif; background: #f8fafc; overflow-x: hidden; }';
    put 'a { text-decoration: none; color: inherit; }';
    put 'ul { list-style: none; }';
%mend generate_base_styles;

/* ============================================================================
   NAVBAR STYLES
   ============================================================================ */
%macro generate_navbar_styles;
    put '.navbar { background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%); padding: 0;';
    put '  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); position: fixed; top: 0; left: 0; right: 0; z-index: 1000; }';
    put '.nav-container { max-width: 1400px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; }';
    put '.nav-brand { display: flex; align-items: center; gap: 15px; color: white; }';
    put '.nav-brand h1 { font-size: 1.5rem; font-weight: 600; }';
    put '.nav-brand .logo { background: rgba(255, 255, 255, 0.2); padding: 8px 12px; border-radius: 8px; }';
    put '.nav-menu { display: flex; gap: 30px; }';
    put '.nav-menu a { color: white; padding: 20px 0; display: block; font-weight: 500; transition: all 0.3s ease; position: relative; }';
    put '.nav-menu a:hover { color: #93c5fd; }';
    put '.nav-menu a::after { content: ""; position: absolute; bottom: 0; left: 0; width: 0; height: 3px; background: #93c5fd; transition: width 0.3s ease; }';
    put '.nav-menu a:hover::after { width: 100%; }';
    put '.nav-user { display: flex; align-items: center; gap: 15px; color: white; }';
    put '.user-avatar { width: 35px; height: 35px; border-radius: 50%; background: rgba(255, 255, 255, 0.2); display: flex; align-items: center; justify-content: center; }';
    put '.user-info { display: flex; flex-direction: column; }';
    put '.user-name { font-weight: 600; font-size: 0.9rem; }';
    put '.user-role { font-size: 0.8rem; opacity: 0.8; }';
%mend generate_navbar_styles;

/* ============================================================================
   MAIN CONTENT STYLES
   ============================================================================ */
%macro generate_main_content_styles;
    put '.main-content { margin-top: 70px; padding: 30px; }';
    put '.page-header { background: white; border-radius: 12px; padding: 30px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); }';
    put '.page-title { font-size: 2rem; color: #1f2937; margin-bottom: 10px; font-weight: 600; }';
    put '.page-subtitle { color: #6b7280; font-size: 1.1rem; }';
    put '.breadcrumb { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; font-size: 0.9rem; color: #6b7280; }';
    put '.breadcrumb a { color: #3b82f6; }';
    put '.breadcrumb a:hover { text-decoration: underline; }';
    put '.dashboard-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 30px; margin-bottom: 30px; }';
    put '.main-panel, .side-panel { background: white; border-radius: 12px; padding: 30px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); }';
%mend generate_main_content_styles;

/* ============================================================================
   CARD STYLES
   ============================================================================ */
%macro generate_card_styles;
    put '.quick-stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-bottom: 30px; }';
    put '.stat-card { background: white; border-radius: 10px; padding: 20px; text-align: center; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); border-left: 4px solid #3b82f6; }';
    put '.stat-card.positive { border-left-color: #10b981; }';
    put '.stat-card.warning { border-left-color: #f59e0b; }';
    put '.stat-card.danger { border-left-color: #ef4444; }';
    put '.stat-number { font-size: 2rem; font-weight: 700; color: #1f2937; margin-bottom: 5px; }';
    put '.stat-text { color: #6b7280; font-size: 0.9rem; }';
%mend generate_card_styles;

/* ============================================================================
   RISK MODULE STYLES
   ============================================================================ */
%macro generate_risk_module_styles;
    put '.risk-modules { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }';
    put '.risk-module { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);';
    put '  border: 2px solid transparent; transition: all 0.3s ease; cursor: pointer; position: relative; overflow: hidden; }';
    put '.risk-module:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15); border-color: #3b82f6; }';
    put '.module-header { display: flex; align-items: center; gap: 15px; margin-bottom: 15px; }';
    put '.module-icon { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: white; }';
    put '.module-title { font-size: 1.2rem; font-weight: 600; color: #1f2937; }';
    put '.module-description { color: #6b7280; font-size: 0.9rem; line-height: 1.5; margin-bottom: 20px; }';
    put '.module-stats { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }';
    put '.stat-item { text-align: center; padding: 15px; background: #f9fafb; border-radius: 8px; }';
    put '.stat-value { font-size: 1.3rem; font-weight: 700; color: #1f2937; margin-bottom: 5px; }';
    put '.stat-label { font-size: 0.8rem; color: #6b7280; text-transform: uppercase; letter-spacing: 0.5px; }';

    /* Module Color Themes */
    put '.regulatory { background: linear-gradient(135deg, #dc2626, #ef4444); }';
    put '.credit { background: linear-gradient(135deg, #059669, #10b981); }';
    put '.operational { background: linear-gradient(135deg, #0891b2, #06b6d4); }';
    put '.market { background: linear-gradient(135deg, #7c3aed, #8b5cf6); }';
    put '.liquidity { background: linear-gradient(135deg, #3b82f6, #60a5fa); }';
    put '.icaap { background: linear-gradient(135deg, #059669, #34d399); }';
    put '.ilaap { background: linear-gradient(135deg, #ec4899, #f472b6); }';
    put '.saibor { background: linear-gradient(135deg, #3b82f6, #60a5fa); }';
%mend generate_risk_module_styles;

/* ============================================================================
   MODAL STYLES
   ============================================================================ */
%macro generate_modal_styles;
    put '.modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); z-index: 2000; justify-content: center; align-items: center; }';
    put '.modal.show { display: flex; }';
    put '.modal-content { background: white; border-radius: 20px; padding: 30px; max-width: 800px; width: 90%; max-height: 80vh; overflow-y: auto; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3); }';
    put '.modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb; }';
    put '.modal-title { font-size: 1.5rem; font-weight: 600; color: #1f2937; }';
    put '.modal-close { background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #6b7280; transition: color 0.3s ease; }';
    put '.modal-close:hover { color: #1f2937; }';
%mend generate_modal_styles;

/* ============================================================================
   NOTIFICATION STYLES
   ============================================================================ */
%macro generate_notification_styles;
    put '.notification { position: fixed; top: 20px; right: 20px; color: white; padding: 15px 20px; border-radius: 10px;';
    put '  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); transform: translateX(400px); transition: transform 0.3s ease; z-index: 2001; display: flex; align-items: center; gap: 10px; }';
    put '.notification.success { background: linear-gradient(135deg, #059669, #10b981); }';
    put '.notification.error { background: linear-gradient(135deg, #dc2626, #ef4444); }';
    put '.notification.warning { background: linear-gradient(135deg, #d97706, #f59e0b); }';
    put '.notification.show { transform: translateX(0); }';
%mend generate_notification_styles;

/* ============================================================================
   BUTTON STYLES
   ============================================================================ */
%macro generate_button_styles;
    put '.btn { padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; }';
    put '.btn-primary { background: #3b82f6; color: white; }';
    put '.btn-primary:hover { background: #2563eb; }';
    put '.btn-secondary { background: #6b7280; color: white; }';
    put '.btn-secondary:hover { background: #4b5563; }';
%mend generate_button_styles;

/* ============================================================================
   RESPONSIVE STYLES
   ============================================================================ */
%macro generate_responsive_styles;
    put '@media (max-width: 1024px) {';
    put '  .dashboard-grid { grid-template-columns: 1fr; }';
    put '}';
    put '@media (max-width: 768px) {';
    put '  .nav-menu { display: none; }';
    put '  .risk-modules { grid-template-columns: 1fr; }';
    put '  .quick-stats { grid-template-columns: repeat(2, 1fr); }';
    put '}';
%mend generate_responsive_styles;

/* ============================================================================
   ANIMATION STYLES
   ============================================================================ */
%macro generate_animation_styles;
    put '.loading { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); z-index: 2000; justify-content: center; align-items: center; }';
    put '.spinner { width: 50px; height: 50px; border: 4px solid rgba(255, 255, 255, 0.3); border-top: 4px solid #3b82f6; border-radius: 50%; animation: spin 1s linear infinite; }';
    put '@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }';
%mend generate_animation_styles;

/* ============================================================================
   DASHBOARD TABLE STYLES
   ============================================================================ */
%macro generate_dashboard_table_styles;
    put '.dashboard-table-container {';
    put '  overflow-x: auto;';
    put '  overflow-y: auto;';
    put '  max-height: 300px;';
    put '  border-radius: 12px;';
    put '  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);';
    put '}';
    put '.dashboard-table {';
    put '  min-width: 100%;';
    put '  border-collapse: collapse;';
    put '  background: white;';
    put '  font-size: 0.9rem;';
    put '}';
    put '.dashboard-table th {';
    put '  background: #f8fafc;';
    put '  padding: 15px 12px;';
    put '  text-align: left;';
    put '  font-weight: 600;';
    put '  color: #374151;';
    put '  border-bottom: 2px solid #e5e7eb;';
    put '  position: sticky;';
    put '  top: 0;';
    put '  z-index: 2;';
    put '  white-space: nowrap;';
    put '  box-shadow: 0 2px 0 #e5e7eb;';
    put '}';
    put '.dashboard-table td {';
    put '  padding: 12px;';
    put '  border-bottom: 1px solid #f3f4f6;';
    put '  color: #374151;';
    put '  white-space: nowrap;';
    put '}';
    put '.dashboard-table tr:hover { background: #f9fafb; }';
    put '.status-badge {';
    put '  padding: 4px 8px;';
    put '  border-radius: 6px;';
    put '  font-size: 0.8rem;';
    put '  font-weight: 500;';
    put '  text-transform: uppercase;';
    put '  letter-spacing: 0.5px;';
    put '}';
    put '.status-badge.compliant { background: #dcfce7; color: #166534; }';
    put '.status-badge.warning   { background: #fef3c7; color: #92400e; }';
    put '.status-badge.danger    { background: #fee2e2; color: #991b1b; }';
    put '.btn-sm { padding: 6px 12px; font-size: 0.8rem; }';
%mend generate_dashboard_table_styles;

/* ============================================================================
   REPORT RESULTS PANEL STYLES
   Tabbed results panel (SACCR/CVA and future report outputs) plus the
   extra status-badge variants used by the comparison/exception tabs.
   ============================================================================ */
%macro generate_results_panel_styles;
    put '.results-panel { background: white; border-radius: 12px; padding: 25px; margin-top: 30px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); }';
    put '.results-panel-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }';
    put '.results-panel-title { font-size: 1.2rem; font-weight: 600; color: #1f2937; }';
    put '.results-panel-meta { color: #6b7280; font-size: 0.85rem; }';

    put '.report-tabs { display: flex; gap: 5px; border-bottom: 2px solid #e5e7eb; margin-bottom: 20px; }';
    put '.report-tab { padding: 10px 18px; border: none; background: transparent; cursor: pointer; font-weight: 500; font-size: 0.9rem; color: #6b7280; border-bottom: 3px solid transparent; transition: all 0.2s ease; margin-bottom: -2px; }';
    put '.report-tab:hover { color: #1f2937; }';
    put '.report-tab.active { color: #1d4ed8; border-bottom-color: #3b82f6; font-weight: 600; }';
    put '.report-tab-panel { display: none; }';
    put '.report-tab-panel.active { display: block; }';

    put '.results-stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-bottom: 20px; }';

    put '.status-badge.matched { background: #dcfce7; color: #166534; }';
    put '.status-badge.minor-diff { background: #fef3c7; color: #92400e; }';
    put '.status-badge.review { background: #fee2e2; color: #991b1b; }';
    put '.status-badge.new { background: #dbeafe; color: #1e40af; }';

    put '.status-badge.high { background: #fee2e2; color: #991b1b; }';
    put '.status-badge.medium { background: #fef3c7; color: #92400e; }';
    put '.status-badge.low { background: #f3f4f6; color: #374151; }';

    put '.status-badge.open { background: #fee2e2; color: #991b1b; }';
    put '.status-badge.pending { background: #fef3c7; color: #92400e; }';
    put '.status-badge.resolved { background: #dcfce7; color: #166534; }';

    put '.results-empty-state { text-align: center; padding: 40px 20px; color: #6b7280; }';
    put '.results-empty-state i { font-size: 2rem; margin-bottom: 10px; display: block; color: #d1d5db; }';

    /* Back button in the results panel header */
    put '.results-back-btn { font-size: 0.85rem; padding: 7px 14px; border-radius: 6px; }';

    /* Comparison tab: compact Total Variance summary card */
    put '.comparison-variance-card { display: flex; align-items: stretch; background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%); border-radius: 10px; margin-bottom: 16px; overflow: hidden; box-shadow: 0 3px 10px rgba(59, 130, 246, 0.3); }';
    put '.comparison-variance-icon { padding: 14px 16px; font-size: 1.3rem; color: rgba(255, 255, 255, 0.9); display: flex; align-items: center; border-right: 1px solid rgba(255, 255, 255, 0.2); }';
    put '.comparison-variance-label { padding: 14px 16px; font-weight: 700; font-size: 0.8rem; color: white; text-transform: uppercase; letter-spacing: 0.8px; display: flex; align-items: center; border-right: 1px solid rgba(255, 255, 255, 0.2); white-space: nowrap; }';
    put '.comparison-variance-stats { display: flex; flex: 1; background: white; }';
    put '.comparison-variance-stat { flex: 1; padding: 10px 14px; text-align: center; border-right: 1px solid #f3f4f6; }';
    put '.comparison-variance-stat:last-child { border-right: none; }';
    put '.comparison-variance-stat-value { font-size: 1.05rem; font-weight: 700; color: #1f2937; line-height: 1.2; }';
    put '.comparison-variance-stat-label { font-size: 0.7rem; color: #6b7280; text-transform: uppercase; letter-spacing: 0.4px; margin-top: 2px; }';
%mend generate_results_panel_styles;

/* ============================================================================
   DATASET SELECTOR STYLES
   Used exclusively by the SAMA Q17 Data Preparation card.
   All custom — no external icon libraries.
   ============================================================================ */
%macro generate_dataset_selector_styles;

    /* Selector panel container */
    put '.ds-panel { background: #ffffff; border: 1px solid #e5e7eb; border-radius: 10px; padding: 16px; margin-bottom: 14px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }';
    put '.ds-panel-header { font-size: 0.8rem; font-weight: 700; color: #374151; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 12px; padding-bottom: 8px; border-bottom: 1px solid #e5e7eb; }';

    /* Individual option rows */
    put '.ds-options { display: flex; flex-direction: column; gap: 3px; }';
    put '.ds-option-row { display: flex; align-items: center; gap: 10px; padding: 8px 10px; border-radius: 6px; cursor: pointer; transition: background 0.15s ease; user-select: none; }';
    put '.ds-option-row:hover { background: #f3f4f6; }';
    put '.ds-option-row.ds-option-disabled { opacity: 0.45; cursor: not-allowed; pointer-events: none; }';
    put '.ds-option-label { font-size: 0.9rem; color: #374151; font-weight: 500; }';

    /* Custom checkbox square */
    put '.ds-cb { width: 18px; height: 18px; border: 2px solid #d1d5db; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: 700; color: #ffffff; flex-shrink: 0; transition: background 0.15s ease, border-color 0.15s ease; }';
    put '.ds-cb.ds-cb-checked { background: #3b82f6; border-color: #3b82f6; }';

    /* Divider between options and ALL row */
    put '.ds-all-divider { height: 1px; background: #e5e7eb; margin: 10px 0; }';

    /* ALL row — visually distinct */
    put '.ds-all-row { display: flex; align-items: center; gap: 10px; padding: 10px 12px; background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; cursor: pointer; transition: background 0.15s ease; user-select: none; }';
    put '.ds-all-row:hover { background: #dbeafe; }';
    put '.ds-all-cb { border-color: #93c5fd; }';
    put '.ds-all-cb.ds-cb-checked { background: #1d4ed8; border-color: #1d4ed8; }';
    put '.ds-all-label { font-size: 0.9rem; font-weight: 700; color: #1d4ed8; letter-spacing: 0.5px; }';
    put '.ds-all-desc { font-size: 0.78rem; color: #6b7280; margin-left: auto; }';

    /* Panel footer with Done button */
    put '.ds-panel-footer { display: flex; justify-content: flex-end; margin-top: 12px; padding-top: 10px; border-top: 1px solid #e5e7eb; }';
    put '.ds-done-btn { padding: 7px 20px; background: #3b82f6; color: #ffffff; border: none; border-radius: 6px; cursor: pointer; font-size: 0.85rem; font-weight: 600; transition: background 0.2s ease; }';
    put '.ds-done-btn:hover { background: #2563eb; }';

    /* Select Datasets toggle button */
    put '.ds-select-btn { padding: 10px 18px; border: 2px solid #3b82f6; border-radius: 8px; cursor: pointer; font-weight: 500; font-size: 0.9rem; background: #ffffff; color: #3b82f6; transition: all 0.2s ease; }';
    put '.ds-select-btn:hover { background: #eff6ff; }';
    put '.ds-select-btn.ds-select-btn-active { background: #3b82f6; color: #ffffff; }';

    /* Run button states */
    put '.ds-run-btn { padding: 10px 20px; border: none; border-radius: 8px; font-weight: 500; font-size: 0.9rem; transition: all 0.2s ease; }';
    put '.ds-run-disabled { background: #e5e7eb; color: #9ca3af; cursor: not-allowed; }';
    put '.ds-run-active { background: #3b82f6; color: #ffffff; cursor: pointer; }';
    put '.ds-run-active:hover { background: #2563eb; }';

    /* Selection display — tag strip shown after Done */
    put '.ds-display { display: flex; align-items: center; flex-wrap: wrap; gap: 6px; margin-bottom: 12px; padding: 8px 10px; background: #f9fafb; border-radius: 6px; border: 1px solid #e5e7eb; }';
    put '.ds-display-label { font-size: 0.75rem; font-weight: 700; color: #6b7280; text-transform: uppercase; letter-spacing: 0.5px; white-space: nowrap; }';
    put '.ds-tags { display: flex; flex-wrap: wrap; gap: 5px; }';
    put '.ds-tag { padding: 3px 10px; background: #dbeafe; color: #1d4ed8; border-radius: 12px; font-size: 0.78rem; font-weight: 600; }';

    /* Availability modal rows */
    put '.ds-modal-section-title { font-size: 0.78rem; font-weight: 700; color: #374151; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 8px; }';
    put '.ds-modal-row-ready { display: flex; align-items: center; gap: 10px; padding: 8px 12px; background: #d1fae5; border-radius: 6px; margin-bottom: 5px; }';
    put '.ds-modal-row-ready span { color: #065f46; font-weight: 500; font-size: 0.9rem; }';
    put '.ds-modal-icon-ready { width: 20px; height: 20px; border-radius: 50%; background: #059669; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: 700; color: #ffffff; flex-shrink: 0; }';
    put '.ds-modal-row-pending { display: flex; align-items: center; gap: 10px; padding: 8px 12px; background: #fef3c7; border-radius: 6px; margin-bottom: 5px; }';
    put '.ds-modal-row-pending span { color: #92400e; font-weight: 500; font-size: 0.9rem; }';
    put '.ds-modal-icon-pending { width: 20px; height: 20px; border-radius: 50%; background: #d97706; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: 700; color: #ffffff; flex-shrink: 0; }';
    put '.ds-modal-notice { margin-top: 12px; padding: 12px 14px; background: #fef3c7; border-left: 4px solid #f59e0b; border-radius: 4px; font-size: 0.84rem; color: #92400e; line-height: 1.5; }';

%mend generate_dataset_selector_styles;
