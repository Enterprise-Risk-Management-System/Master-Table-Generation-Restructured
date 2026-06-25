
/* ============================================================================
   MASTER TABLE REPORT ROUTE BUILDER
   Generic prompt-card renderer shared by every report route (SACCR/CVA,
   SAMA Q17, IRRBB, Assets, Liabilities, Off Balance, Customer MT).
   Driven entirely by masterTableReportsConfig - no per-route markup.
   Cards with datasetSelector:true get the dataset selection panel and
   a gated Run button instead of the standard immediate Run button.
   ============================================================================ */
%macro buildMasterTableReport;
    put '// Renders all prompt cards plus a hidden results container for a report route';
    put 'function buildMasterTableRoute(routeKey) {';
    put '  var cards = (masterTableReportsConfig[routeKey] || []).map(getpromptHTML).join("");';
    put '  var promptCardsId = routeKey.replace("#", "") + "-prompt-cards";';
    put '  var resultsContainerId = routeKey.replace("#", "") + "-results";';
    put '  return "<div style=\"max-width: 1200px; margin: 0 auto; padding: 20px;\">" +';
    put '    "<div id=\"" + promptCardsId + "\" style=\"display: block;\">" +';
    put '    "<div style=\"margin-bottom: 20px;\">" +';
    put '    "<button onclick=\"showRoute(&apos;#risk-categories&apos;)\" style=\"padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; font-size: 0.9rem; background: #6b7280; color: white; transition: all 0.3s ease;\" " +';
    put '    "onmouseover=\"this.style.background=&apos;#4b5563&apos;\" onmouseout=\"this.style.background=&apos;#6b7280&apos;\"><i class=\"fas fa-arrow-left\"></i> Back</button>" +';
    put '    "</div>" +';
    put '    "<div style=\"display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 25px; margin-bottom: 30px;\">" +';
    put '    cards + "</div>" +';
    put '    "</div>" +';
    put '    "<div id=\"" + resultsContainerId + "\" class=\"results-panel\" style=\"display:none;\"></div>" +';
    put '    "</div>";';
    put '}';

    put '// Renders a single report card (title, frequency, fields, Run/History buttons).';
    put '// Cards with datasetSelector:true receive a dataset selection panel and a gated Run button.';
    put 'function getpromptHTML(report) {';
    put '  var reportId = report.id;';
    put '  var title = report.title;';
    put '  var description = report.description;';
    put '  var frequency = report.frequency;';
    put '  var fields = report.fields;';

    put '  var html = "<div style=\"background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); border: 2px solid transparent; transition: all 0.3s ease; cursor: pointer; position: relative;\" ";';
    put '  html += "onmouseover=\"this.style.transform=&apos;translateY(-3px)&apos;; this.style.boxShadow=&apos;0 8px 25px rgba(0, 0, 0, 0.15)&apos;; this.style.borderColor=&apos;#3b82f6&apos;;\" ";';
    put '  html += "onmouseout=\"this.style.transform=&apos;translateY(0)&apos;; this.style.boxShadow=&apos;0 4px 15px rgba(0, 0, 0, 0.08)&apos;; this.style.borderColor=&apos;transparent&apos;;\" ";';
    put '  html += "data-report=\"" + reportId + "\">";';

    put '  html += "<div style=\"display: flex; align-items: flex-start; gap: 15px; margin-bottom: 20px;\">";';
    put '  html += "<div style=\"width: 50px; height: 50px; background: linear-gradient(135deg, #3b82f6, #1d4ed8); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: white; flex-shrink: 0;\">";';
    put '  html += "<i class=\"fas fa-chart-bar\"></i>";';
    put '  html += "</div>";';
    put '  html += "<div style=\"flex: 1;\">";';
    put '  html += "<h3 style=\"font-size: 1.3rem; font-weight: 600; color: #1f2937; margin-bottom: 8px;\">" + title + "</h3>";';
    put '  html += "<p style=\"color: #6b7280; font-size: 0.9rem; line-height: 1.5;\">" + description + "</p>";';
    put '  html += "</div>";';
    put '  html += "</div>";';

    put '  html += "<div style=\"margin-bottom: 20px; padding: 15px; background: #f9fafb; border-radius: 8px;\">";';
    put '  html += "<div style=\"display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #e5e7eb;\">";';
    put '  html += "<span style=\"font-weight: 500; color: #374151;\">Frequency:</span>";';
    put '  html += "<span style=\"color: #6b7280;\">" + frequency + "</span>";';
    put '  html += "</div>";';

    put '  (fields || []).forEach(function (field) {';
    put '    html += "<div style=\"display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #e5e7eb;\">";';
    put '    html += "<span style=\"font-weight: 500; color: #374151;\">" + field.label + ":</span>";';
    put '    if (field.type === "select") {';
    put '      html += "<select id=\"" + reportId + "-" + field.id + "\" style=\"color: #6b7280; font-size: 14px; border: none; background: transparent;\">";';
    put '      (field.options || []).forEach(function (opt) {';
    put '        html += "<option value=\"" + opt + "\">" + opt + "</option>";';
    put '      });';
    put '      html += "</select>";';
    put '    } else {';
    put '      html += "<input type=\"" + field.type + "\" id=\"" + reportId + "-" + field.id + "\" style=\"color: #6b7280; font-size: 14px; border: none; background: transparent;\" />";';
    put '    }';
    put '    html += "</div>";';
    put '  });';
    put '  html += "</div>";';

    /* ── Dataset selector block — only injected for datasetSelector cards ── */
    put '  if (report.datasetSelector) {';

    /* Selection display strip (hidden until user makes a choice) */
    put '    html += "<div id=\"" + reportId + "-ds-display\" class=\"ds-display\" style=\"display:none;\">";';
    put '    html += "<span class=\"ds-display-label\">Selected:</span>";';
    put '    html += "<div id=\"" + reportId + "-ds-tags\" class=\"ds-tags\"></div>";';
    put '    html += "</div>";';

    /* Selector panel (hidden until Select Datasets is clicked) */
    put '    html += "<div id=\"" + reportId + "-ds-panel\" class=\"ds-panel\" style=\"display:none;\">";';
    put '    html += "<div class=\"ds-panel-header\">Select Datasets to Process</div>";';
    put '    html += "<div class=\"ds-options\">";';

    /* Individual option — Credit Risk */
    put '    html += "<div class=\"ds-option-row\" id=\"" + reportId + "-row-credit-risk\" onclick=\"toggleDataset(&apos;" + reportId + "&apos;, &apos;credit-risk&apos;)\">";';
    put '    html += "<div class=\"ds-cb\" id=\"" + reportId + "-cb-credit-risk\"></div>";';
    put '    html += "<span class=\"ds-option-label\">Credit Risk</span></div>";';

    /* Individual option — Liquidity Risk */
    put '    html += "<div class=\"ds-option-row\" id=\"" + reportId + "-row-liquidity-risk\" onclick=\"toggleDataset(&apos;" + reportId + "&apos;, &apos;liquidity-risk&apos;)\">";';
    put '    html += "<div class=\"ds-cb\" id=\"" + reportId + "-cb-liquidity-risk\"></div>";';
    put '    html += "<span class=\"ds-option-label\">Liquidity Risk</span></div>";';

    /* Individual option — SACCR-CVA */
    put '    html += "<div class=\"ds-option-row\" id=\"" + reportId + "-row-saccr-cva\" onclick=\"toggleDataset(&apos;" + reportId + "&apos;, &apos;saccr-cva&apos;)\">";';
    put '    html += "<div class=\"ds-cb\" id=\"" + reportId + "-cb-saccr-cva\"></div>";';
    put '    html += "<span class=\"ds-option-label\">SACCR-CVA</span></div>";';

    /* Individual option — Operational Risk */
    put '    html += "<div class=\"ds-option-row\" id=\"" + reportId + "-row-operational-risk\" onclick=\"toggleDataset(&apos;" + reportId + "&apos;, &apos;operational-risk&apos;)\">";';
    put '    html += "<div class=\"ds-cb\" id=\"" + reportId + "-cb-operational-risk\"></div>";';
    put '    html += "<span class=\"ds-option-label\">Operational Risk</span></div>";';

    /* Individual option — Others */
    put '    html += "<div class=\"ds-option-row\" id=\"" + reportId + "-row-others\" onclick=\"toggleDataset(&apos;" + reportId + "&apos;, &apos;others&apos;)\">";';
    put '    html += "<div class=\"ds-cb\" id=\"" + reportId + "-cb-others\"></div>";';
    put '    html += "<span class=\"ds-option-label\">Others</span></div>";';

    put '    html += "</div>";';

    /* ALL row — separated by a divider, visually distinct */
    put '    html += "<div class=\"ds-all-divider\"></div>";';
    put '    html += "<div class=\"ds-all-row\" id=\"" + reportId + "-row-all\" onclick=\"toggleAllDatasets(&apos;" + reportId + "&apos;)\">";';
    put '    html += "<div class=\"ds-cb ds-all-cb\" id=\"" + reportId + "-cb-all\"></div>";';
    put '    html += "<span class=\"ds-all-label\">ALL</span>";';
    put '    html += "<span class=\"ds-all-desc\">Select all datasets</span>";';
    put '    html += "</div>";';

    /* Panel footer */
    put '    html += "<div class=\"ds-panel-footer\">";';
    put '    html += "<button class=\"ds-done-btn\" onclick=\"closeDatasetPanel(&apos;" + reportId + "&apos;)\">Done</button>";';
    put '    html += "</div>";';
    put '    html += "</div>";';
    put '  }';

    /* ── Button row ── */
    put '  html += "<div style=\"display: flex; gap: 10px; flex-wrap: wrap;\">";';
    put '  if (report.datasetSelector) {';
    put '    html += "<button id=\"" + reportId + "-select-btn\" class=\"ds-select-btn\"";';
    put '    html += " onclick=\"toggleDatasetPanel(&apos;" + reportId + "&apos;)\">&#9660; Select Datasets</button>";';
    put '    html += "<button id=\"" + reportId + "-run-btn\" class=\"ds-run-btn ds-run-disabled\"";';
    put '    html += " onclick=\"generateRegulatoryReport(&apos;" + reportId + "&apos;)\" disabled>Run</button>";';
    put '  } else {';
    put '    html += "<button onclick=\"generateRegulatoryReport(&apos;" + reportId + "&apos;)\" style=\"padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; font-size: 0.9rem; background: #3b82f6; color: white;\" ";';
    put '    html += "onmouseover=\"this.style.background=&apos;#2563eb&apos;\" onmouseout=\"this.style.background=&apos;#3b82f6&apos;\">Run</button>";';
    put '  }';
    put '  html += "<button onclick=\"viewReportHistory(&apos;" + reportId + "&apos;)\" style=\"padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; font-size: 0.9rem; background: #6b7280; color: white;\" ";';
    put '  html += "onmouseover=\"this.style.background=&apos;#4b5563&apos;\" onmouseout=\"this.style.background=&apos;#6b7280&apos;\">View History</button>";';
    put '  html += "</div>";';

    put '  html += "</div>";';
    put '  return html;';
    put '}';

    /* ── Dataset selector JavaScript module ── */
    %buildDatasetSelectorJS;

%mend buildMasterTableReport;


/* ============================================================================
   DATASET SELECTOR JAVASCRIPT
   Emits all client-side functions that drive the dataset selection panel.
   ============================================================================ */
%macro buildDatasetSelectorJS;

    put 'var DS_KEYS = ["credit-risk", "liquidity-risk", "saccr-cva", "operational-risk", "others"];';
    put 'var DS_LABELS = {';
    put '  "credit-risk": "Credit Risk",';
    put '  "liquidity-risk": "Liquidity Risk",';
    put '  "saccr-cva": "SACCR-CVA",';
    put '  "operational-risk": "Operational Risk",';
    put '  "others": "Others"';
    put '};';

    /* Toggle the panel open/closed */
    put 'function toggleDatasetPanel(reportId) {';
    put '  var panel = document.getElementById(reportId + "-ds-panel");';
    put '  if (!panel) return;';
    put '  var isOpen = panel.style.display !== "none";';
    put '  panel.style.display = isOpen ? "none" : "block";';
    put '  var btn = document.getElementById(reportId + "-select-btn");';
    put '  if (btn) {';
    put '    if (!isOpen) {';
    put '      btn.classList.add("ds-select-btn-active");';
    put '      btn.innerHTML = "&#9650; Select Datasets";';
    put '    } else {';
    put '      btn.classList.remove("ds-select-btn-active");';
    put '      btn.innerHTML = "&#9660; Select Datasets";';
    put '    }';
    put '  }';
    put '}';

    /* Close panel on Done — also refreshes the selection display strip */
    put 'function closeDatasetPanel(reportId) {';
    put '  var panel = document.getElementById(reportId + "-ds-panel");';
    put '  if (panel) panel.style.display = "none";';
    put '  var btn = document.getElementById(reportId + "-select-btn");';
    put '  if (btn) {';
    put '    btn.classList.remove("ds-select-btn-active");';
    put '    btn.innerHTML = "&#9660; Select Datasets";';
    put '  }';
    put '  updateDatasetDisplay(reportId);';
    put '}';

    /* Toggle an individual dataset checkbox */
    put 'function toggleDataset(reportId, key) {';
    put '  var cb = document.getElementById(reportId + "-cb-" + key);';
    put '  if (!cb) return;';
    put '  var isChecked = cb.classList.contains("ds-cb-checked");';
    put '  if (!isChecked) {';
    put '    var checkedCount = 0;';
    put '    DS_KEYS.forEach(function (k) {';
    put '      var c = document.getElementById(reportId + "-cb-" + k);';
    put '      if (c && c.classList.contains("ds-cb-checked")) checkedCount++;';
    put '    });';
    put '    if (checkedCount >= 4) return;';
    put '    cb.classList.add("ds-cb-checked");';
    put '    cb.innerHTML = "&#10003;";';
    put '  } else {';
    put '    cb.classList.remove("ds-cb-checked");';
    put '    cb.innerHTML = "";';
    put '  }';
    put '  syncAllCheckbox(reportId);';
    put '  updateDatasetRunButton(reportId);';
    put '}';

    /* Toggle ALL — checks/unchecks every individual option */
    put 'function toggleAllDatasets(reportId) {';
    put '  var allCb = document.getElementById(reportId + "-cb-all");';
    put '  if (!allCb) return;';
    put '  var isAllChecked = allCb.classList.contains("ds-cb-checked");';
    put '  if (isAllChecked) {';
    put '    allCb.classList.remove("ds-cb-checked");';
    put '    allCb.innerHTML = "";';
    put '    DS_KEYS.forEach(function (k) {';
    put '      var c = document.getElementById(reportId + "-cb-" + k);';
    put '      if (c) { c.classList.remove("ds-cb-checked"); c.innerHTML = ""; }';
    put '    });';
    put '  } else {';
    put '    allCb.classList.add("ds-cb-checked");';
    put '    allCb.innerHTML = "&#10003;";';
    put '    DS_KEYS.forEach(function (k) {';
    put '      var c = document.getElementById(reportId + "-cb-" + k);';
    put '      if (c) { c.classList.add("ds-cb-checked"); c.innerHTML = "&#10003;"; }';
    put '    });';
    put '  }';
    put '  updateDatasetRunButton(reportId);';
    put '}';

    /* Keep the ALL checkbox in sync when individual boxes are ticked manually */
    put 'function syncAllCheckbox(reportId) {';
    put '  var allChecked = true;';
    put '  DS_KEYS.forEach(function (k) {';
    put '    var c = document.getElementById(reportId + "-cb-" + k);';
    put '    if (!c || !c.classList.contains("ds-cb-checked")) allChecked = false;';
    put '  });';
    put '  var allCb = document.getElementById(reportId + "-cb-all");';
    put '  if (allCb) {';
    put '    if (allChecked) { allCb.classList.add("ds-cb-checked"); allCb.innerHTML = "&#10003;"; }';
    put '    else { allCb.classList.remove("ds-cb-checked"); allCb.innerHTML = ""; }';
    put '  }';
    put '}';

    /* Enable or disable the Run button based on whether any box is checked */
    put 'function updateDatasetRunButton(reportId) {';
    put '  var hasSelection = false;';
    put '  DS_KEYS.forEach(function (k) {';
    put '    var c = document.getElementById(reportId + "-cb-" + k);';
    put '    if (c && c.classList.contains("ds-cb-checked")) hasSelection = true;';
    put '  });';
    put '  var runBtn = document.getElementById(reportId + "-run-btn");';
    put '  if (!runBtn) return;';
    put '  if (hasSelection) {';
    put '    runBtn.disabled = false;';
    put '    runBtn.classList.remove("ds-run-disabled");';
    put '    runBtn.classList.add("ds-run-active");';
    put '  } else {';
    put '    runBtn.disabled = true;';
    put '    runBtn.classList.add("ds-run-disabled");';
    put '    runBtn.classList.remove("ds-run-active");';
    put '  }';
    put '}';

    /* Refresh the selection-display tag strip below the fields */
    put 'function updateDatasetDisplay(reportId) {';
    put '  var selected = getSelectedDatasets(reportId);';
    put '  var display = document.getElementById(reportId + "-ds-display");';
    put '  var tagsDiv = document.getElementById(reportId + "-ds-tags");';
    put '  if (!display || !tagsDiv) return;';
    put '  if (selected.length === 0) {';
    put '    display.style.display = "none";';
    put '    tagsDiv.innerHTML = "";';
    put '    return;';
    put '  }';
    put '  var tagsHtml = "";';
    put '  selected.forEach(function (k) {';
    put '    tagsHtml += "<span class=\"ds-tag\">" + (DS_LABELS[k] || k) + "</span>";';
    put '  });';
    put '  tagsDiv.innerHTML = tagsHtml;';
    put '  display.style.display = "flex";';
    put '}';

    /* Returns an array of keys for all currently checked individual options */
    put 'function getSelectedDatasets(reportId) {';
    put '  var selected = [];';
    put '  DS_KEYS.forEach(function (k) {';
    put '    var c = document.getElementById(reportId + "-cb-" + k);';
    put '    if (c && c.classList.contains("ds-cb-checked")) selected.push(k);';
    put '  });';
    put '  return selected;';
    put '}';

%mend buildDatasetSelectorJS;
