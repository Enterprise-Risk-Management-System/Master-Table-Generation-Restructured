
/* ============================================================================
   SACCR / CVA RESULTS VIEW MODULE
   Consumes the JSON the SACCR_CVA_2 stored process writes to _webout
   (built via PROC JSON: write open object / write values "<name>" / export
   <dataset> / write close - one named member per table) and renders it as
   a styled, tabbed results panel: SACCR Summary / Comparison Report /
   Exception Report.

   
   Expected top-level JSON members: saccr_header, cva_header, summary_table,
   comparison_report, exception_report - each an array of row objects.

   COLUMN_MAPS below controls which dataset variables are displayed and
   their labels - update the "key" values here if the underlying SAS
   datasets use different variable names than assumed.
   ============================================================================ */
%macro generate_saccr_results_view;

    put '// MT SACCR/CVA Results View Module';
    put 'const MTSaccrResults = {';
    put '  COLUMN_MAPS: {';
    put '    summary: [';
    put '      { key: "netting_set_id", label: "Netting Set ID" },';
    put '      { key: "as_of_date", label: "Agreement Date" },';
    put '      { key: "number_of_trades", label: "Number of Trades" },';
    put '      { key: "replacement_cost", label: "RC" },';
    put '      { key: "pfe", label: "PFE" },';
    put '      { key: "ead", label: "EAD" },';
    put '      { key: "rwa", label: "RWA" },';
    put '      { key: "saccr_capital_charge", label: "Capital Charge" },';
    put '      { key: "asset_class", label: "Asset Class" }';
    put '    ],';
    put '    comparison: [';
    put '      { key: "netting_set_id", label: "Netting Set ID" },';
    put '      { key: "ead_current", label: "Current EAD" },';
    put '      { key: "ead_previous", label: "Previous EAD" },';
    put '      { key: "ead_diff", label: "Variance" },';
    put '      { key: "ead_pct_change", label: "Variance %" },';
    put '      { key: "saccr_rwa_current", label: "Current RWA" },';
    put '      { key: "saccr_rwa_previous", label: "Previous RWA" },';
    put '      { key: "capital_charge", label: "Capital Charge" }';
    put '    ],';
    put '    exception: [';
    put '      { key: "error_id", label: "Error ID" },';
    put '      { key: "netting_set_id", label: "Netting Set ID" },';
    put '      { key: "field", label: "Field" },';
    put '      { key: "error_type", label: "Error Type" },';
    put '      { key: "description", label: "Description" }';
    put '    ]';
    put '  },';


    put '  // Turns a column header/variable name into a lowercase_underscore key';
    put '  normalizeKey(text) {';
    put '    return (text || "").toString().trim().toLowerCase()';
    put '      .replace(/[^a-z0-9]+/g, "_").replace(/^_+|_+$/g, "");';
    put '  },';


    put '  // Normalizes every row''s keys in a PROC JSON array to match COLUMN_MAPS';
    put '  normalizeRows(rows) {';
    put '    if (!Array.isArray(rows)) return [];';
    put '    return rows.map(row => {';
    put '      const record = {};';
    put '      Object.keys(row || {}).forEach(rawKey => {';
    put '        const key = this.normalizeKey(rawKey);';
    put '        if (key === "obs" || !key) return;';
    put '        record[key] = row[rawKey];';
    put '      });';
    put '      return record;';
    put '    });';
    put '  },';

    put '  // Coerces a JSON number or comma-formatted string to a plain number';
    put '  toNumber(value) {';
    put '    if (value === null || value === undefined || value === "") return null;';
    put '    if (typeof value === "number") return isNaN(value) ? null : value;';
    put '    const n = Number(String(value).replace(/,/g, ""));';
    put '    return isNaN(n) ? null : n;';
    put '  },';


    put '  // Builds the compact Total Variance summary card shown above the Comparison Report table';
    put '  renderVarianceCard(totalVariance, reviewCount, totalRecords) {';
    put '    const absVal = Math.abs(totalVariance);';
    put '    const sign = totalVariance >= 0 ? "+" : "";';
    put '    const formatted = absVal >= 1000000';
    put '      ? sign + (totalVariance / 1000000).toFixed(2) + "M"';
    put '      : sign + totalVariance.toLocaleString(undefined, { maximumFractionDigits: 2 });';
    put '    let html = "<div class=\"comparison-variance-card\">";';
    put '    html += "<div class=\"comparison-variance-icon\"><i class=\"fas fa-balance-scale\"></i></div>";';
    put '    html += "<div class=\"comparison-variance-label\">Total Variance</div>";';
    put '    html += "<div class=\"comparison-variance-stats\">";';
    put '    html += "<div class=\"comparison-variance-stat\">";';
    put '    html += "<div class=\"comparison-variance-stat-value\">" + escapeHtml(formatted) + "</div>";';
    put '    html += "<div class=\"comparison-variance-stat-label\">EAD Variance</div></div>";';
    put '    html += "<div class=\"comparison-variance-stat\">";';
    put '    html += "<div class=\"comparison-variance-stat-value\">" + escapeHtml(String(reviewCount)) + "</div>";';
    put '    html += "<div class=\"comparison-variance-stat-label\">For Review</div></div>";';
    put '    html += "<div class=\"comparison-variance-stat\">";';
    put '    html += "<div class=\"comparison-variance-stat-value\">" + escapeHtml(String(totalRecords)) + "</div>";';
    put '    html += "<div class=\"comparison-variance-stat-label\">Records</div></div>";';
    put '    html += "</div></div>";';
    put '    return html;';
    put '  },';
    put '';
    put '  // Classifies a comparison row as New/Matched/Minor Diff/Review by EAD variance';
    put '  computeComparisonStatus(row) {';
    put '    const prev = this.toNumber(row.ead_previous);';
    put '    if (prev === null || prev === 0) return "New";';
    put '    let pct = this.toNumber(row.ead_pct_change);';
    put '    if (pct === null) {';
    put '      const curr = this.toNumber(row.ead_current);';
    put '      if (curr === null) return "New";';
    put '      pct = ((curr - prev) / Math.abs(prev)) * 100;';
    put '    }';
    put '    const absPct = Math.abs(pct);';
    put '    if (absPct <= 1) return "Matched";';
    put '    if (absPct <= 5) return "Minor Diff";';
    put '    return "Review";';
    put '  },';


    put '  // Keyword-scans an exception row''s error text to assign a severity level';
    put '  classifyExceptionSeverity(row) {';
    put '    const text = ((row.error_type || "") + " " + (row.description || "")).toLowerCase();';
    put '    if (/missing|invalid|null|reject/.test(text)) return "High";';
    put '    if (/warning|review/.test(text)) return "Medium";';
    put '    return "Low";';
    put '  },';


    put '  // Converts a badge label into a CSS modifier class (e.g. "Minor Diff" -> "minor-diff")';
    put '  badgeClass(text) {';
    put '    return (text || "").toString().toLowerCase().replace(/\s+/g, "-");';
    put '  },';


    put '  // Wraps a label in a styled .status-badge span';
    put '  renderBadge(text) {';
    put '    return "<span class=\"status-badge " + this.badgeClass(text) + "\">" + escapeHtml(text) + "</span>";';
    put '  },';


    put '  // Builds a .dashboard-table from mapped columns plus optional badge columns';
    put '  renderTable(columns, rows, extraColumns) {';
    put '    if (!rows || rows.length === 0) {';
    put '      return "<div class=\"results-empty-state\"><i class=\"fas fa-inbox\"></i>No records found.</div>";';
    put '    }';
    put '    let html = "<div class=\"dashboard-table-container\"><table class=\"dashboard-table\"><thead><tr>";';
    put '    columns.forEach(col => { html += "<th>" + escapeHtml(col.label) + "</th>"; });';
    put '    (extraColumns || []).forEach(col => { html += "<th>" + escapeHtml(col.label) + "</th>"; });';
    put '    html += "</tr></thead><tbody>";';
    put '    rows.forEach(row => {';
    put '      html += "<tr>";';
    put '      columns.forEach(col => { html += "<td>" + escapeHtml(row[col.key] !== undefined ? row[col.key] : "") + "</td>"; });';
    put '      (extraColumns || []).forEach(col => { html += "<td>" + (row.__badges && row.__badges[col.key] ? row.__badges[col.key] : "") + "</td>"; });';
    put '      html += "</tr>";';
    put '    });';
    put '    html += "</tbody></table></div>";';
    put '    return html;';
    put '  },';


    put '  // Renders a row of .stat-card KPIs from a single aggregate header row';
    put '  renderStatCards(headerRow, statFields) {';
    put '    if (!headerRow) return "";';
    put '    let html = "<div class=\"results-stats\">";';
    put '    statFields.forEach(field => {';
    put '      const value = headerRow[field.key] !== undefined ? headerRow[field.key] : "--";';
    put '      html += "<div class=\"stat-card\"><div class=\"stat-number\">" + escapeHtml(value) + "</div><div class=\"stat-text\">" + escapeHtml(field.label) + "</div></div>";';
    put '    });';
    put '    html += "</div>";';
    put '    return html;';
    put '  },';


    put '  // Builds the SACCR Summary tab: header KPI cards plus the netting-set table';
    put '  buildTab1(data) {';
    put '    const summaryRows = this.normalizeRows(data.summary_table);';
    put '    const saccrHeaderRows = this.normalizeRows(data.saccr_header);';
    put '    const cvaHeaderRows = this.normalizeRows(data.cva_header);';
    put '    let html = "";';
    put '    if (saccrHeaderRows.length) {';
    put '      html += this.renderStatCards(saccrHeaderRows[0], [';
    put '        { key: "number_of_netting_sets", label: "Netting Sets" },';
    put '        { key: "number_of_trades", label: "Trades" },';
    put '        { key: "rc_net_margined_yl", label: "RC" },';
    put '        { key: "pfe", label: "PFE" },';
    put '        { key: "saccr_charge", label: "SACCR Charge" }';
    put '      ]);';
    put '    }';
    put '    if (cvaHeaderRows.length) {';
    put '      html += this.renderStatCards(cvaHeaderRows[0], [';
    put '        { key: "r_amount", label: "CVA R Amount" },';
    put '        { key: "capital_charge", label: "CVA Capital Charge" },';
    put '        { key: "rwa", label: "CVA RWA" }';
    put '      ]);';
    put '    }';
    put '    html += this.renderTable(this.COLUMN_MAPS.summary, summaryRows);';
    put '    return html;';
    put '  },';


    put '  // Builds the Comparison Report tab: variance summary card then the full table';
    put '  buildTab2(data) {';
    put '    const rows = this.normalizeRows(data.comparison_report);';
    put '    rows.forEach(row => {';
    put '      row.__badges = { status: this.renderBadge(this.computeComparisonStatus(row)) };';
    put '    });';
    put '    const totalVariance = rows.reduce((sum, r) => sum + (this.toNumber(r.ead_diff) || 0), 0);';
    put '    const reviewCount = rows.filter(r => this.computeComparisonStatus(r) === "Review").length;';
    put '    const varianceCard = rows.length ? this.renderVarianceCard(totalVariance, reviewCount, rows.length) : "";';
    put '    return varianceCard + this.renderTable(this.COLUMN_MAPS.comparison, rows, [{ key: "status", label: "Status" }]);';
    put '  },';


    put '  // Builds the Exception Report tab with derived severity and status badges';
    put '  buildTab3(data) {';
    put '    const rows = this.normalizeRows(data.exception_report);';
    put '    rows.forEach(row => {';
    put '      row.status = row.status || "Open";';
    put '      row.__badges = {';
    put '        severity: this.renderBadge(this.classifyExceptionSeverity(row)),';
    put '        status: this.renderBadge(row.status)';
    put '      };';
    put '    });';
    put '    return this.renderTable(this.COLUMN_MAPS.exception, rows, [';
    put '      { key: "severity", label: "Severity" },';
    put '      { key: "status", label: "Status" }';
    put '    ]);';
    put '  },';


    put '  // Assembles the 3-tab nav and panels for SACCR Summary/Comparison/Exception';
    put '  renderTabs(data, reportId) {';
    put '    const tab1 = this.buildTab1(data);';
    put '    const tab2 = this.buildTab2(data);';
    put '    const tab3 = this.buildTab3(data);';
    put '    let html = "<div class=\"results-panel-header\">";';
    put '    html += "<div class=\"results-panel-title\">Results</div>";';
    put '    html += "<button class=\"btn btn-secondary results-back-btn\" onclick=\"MTSaccrResults.goBack(&apos;" + reportId + "&apos;)\"><i class=\"fas fa-arrow-left\"></i> Back</button>";';
    put '    html += "</div>";';
    put '    html += "<div class=\"report-tabs\">";';
    put '    html += "<button class=\"report-tab active\" onclick=\"MTSaccrResults.switchTab(this, &apos;saccr-summary&apos;)\">SACCR Summary</button>";';
    put '    html += "<button class=\"report-tab\" onclick=\"MTSaccrResults.switchTab(this, &apos;saccr-comparison&apos;)\">Comparison Report</button>";';
    put '    html += "<button class=\"report-tab\" onclick=\"MTSaccrResults.switchTab(this, &apos;saccr-exception&apos;)\">Exception Report</button>";';
    put '    html += "</div>";';
    put '    html += "<div class=\"report-tab-panel active\" id=\"saccr-summary\">" + tab1 + "</div>";';
    put '    html += "<div class=\"report-tab-panel\" id=\"saccr-comparison\">" + tab2 + "</div>";';
    put '    html += "<div class=\"report-tab-panel\" id=\"saccr-exception\">" + tab3 + "</div>";';
    put '    return html;';
    put '  },';


    put '  // Toggles which tab button/panel is active within the results panel';
    put '  switchTab(buttonEl, panelId) {';
    put '    const tabsContainer = buttonEl.closest(".report-tabs");';
    put '    if (tabsContainer) {';
    put '      tabsContainer.querySelectorAll(".report-tab").forEach(btn => btn.classList.remove("active"));';
    put '    }';
    put '    buttonEl.classList.add("active");';
    put '    const resultsPanel = buttonEl.closest(".results-panel");';
    put '    if (resultsPanel) {';
    put '      resultsPanel.querySelectorAll(".report-tab-panel").forEach(panel => panel.classList.remove("active"));';
    put '      const target = resultsPanel.querySelector("#" + panelId);';
    put '      if (target) target.classList.add("active");';
    put '    }';
    put '  },';
    

    put '  // Hides the results panel and restores the prompt-card grid so the user can re-run';
    put '  goBack(reportId) {';
    put '    const container = document.getElementById(reportId + "-results");';
    put '    if (container) container.style.display = "none";';
    put '    const promptCards = document.getElementById(reportId + "-prompt-cards");';
    put '    if (promptCards) promptCards.style.display = "block";';
    put '  },';
    put '';
    put '  // Entry point: parses the SP response, hides prompt cards, and shows the results panel';
    put '  render(reportId, data) {';
    put '    const container = document.getElementById(reportId + "-results");';
    put '    if (!container) {';
    put '      console.error("Results container not found for", reportId);';
    put '      return;';
    put '    }';
    put '    let parsed = data;';
    put '    if (typeof parsed === "string") {';
    put '      try {';
    put '        parsed = JSON.parse(parsed);';
    put '      } catch (e) {';
    put '        console.error("Failed to parse SACCR/CVA response as JSON", e);';
    put '        container.innerHTML = "<div class=\"results-empty-state\">Unable to parse report results.</div>";';
    put '        container.style.display = "block";';
    put '        return;';
    put '      }';
    put '    }';
    put '    container.innerHTML = this.renderTabs(parsed || {}, reportId);';
    put '    const promptCards = document.getElementById(reportId + "-prompt-cards");';
    put '    if (promptCards) promptCards.style.display = "none";';
    put '    container.style.display = "block";';
    put '    container.scrollIntoView({ behavior: "smooth", block: "nearest" });';
    put '  }';
    put '};';
    
%mend generate_saccr_results_view;
