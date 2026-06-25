

/* Emits the shared modal helper functions: showModalMessage, getModalTheme, escapeHtml */
%macro generate_javascript_modal;

    put '// Populates and opens #reportModal with a themed title/message';
    put 'function showModalMessage(payload) {';
    put '  var modal = document.getElementById("reportModal");';
    put '  var modalTitle = document.getElementById("modalTitle");';
    put '  var modalBody = document.getElementById("modalBody");';
    put '  if (!modal || !modalTitle || !modalBody) {';
    put '    console.error("Modal elements not found in DOM");';
    put '    return;';
    put '  };';

    put '  var title = payload && payload.title ? payload.title : "Notification";';
    put '  var message = payload && payload.message ? payload.message : "No message provided.";';
    put '  var type = payload && payload.type ? payload.type : "info";';

    put '  modalTitle.textContent = title;';
    put '  var theme = getModalTheme(type);';
    put '  var html = "<div style=\"background:" + theme.bg + "; color:" + theme.text + "; padding:15px; border-radius:8px; text-align:left;\">";';
    put '  html += "<div style=\"font-size:1rem; font-weight:600; margin-bottom:8px;\">" + escapeHtml(message) + "</div>";';
    put '  html += "</div>";';
    put '  modalBody.innerHTML = html;';
    put '  modal.classList.add("show");';
    put '}';

    put '// Maps a notification type to its modal background/text colors';
    put 'function getModalTheme(type) {';
    put '  var themes = {';
    put '    error: { bg: "#fee2e2", text: "#b91c1c" },';
    put '    warning: { bg: "#fef3c7", text: "#92400e" },';
    put '    success: { bg: "#d1fae5", text: "#065f46" },';
    put '    info: { bg: "#e0f2fe", text: "#0369a1" }';
    put '  };';
    put '  return themes[type] || { bg: "#f9fafb", text: "#1f2937" };';
    put '}';

    put '// Escapes HTML-special characters before inserting untrusted text into the DOM';
    put 'function escapeHtml(str) {';
    put '  if (str === null || str === undefined) return "";';
    put '  return String(str)';
    put '    .replace(/&/g, "&amp;")';
    put '    .replace(/</g, "&lt;")';
    put '    .replace(/>/g, "&gt;")';
    put '    .replace(/"/g, "&quot;")';
    put '    .replace(/''/g, "&#39;");';
    put '}';

    put 'var modalEl = document.getElementById("reportModal");';
    put 'if (modalEl) {';
    put '  modalEl.addEventListener("click", function(e) {';
    put '    if (e.target === this) {';
    put '      closeModal();';
    put '    }';
    put '  });';
    put '}';

    /* ── Dataset availability summary modal ── */
    put '// Shows the Dataset Availability Summary modal for the SAMA Q17 Data Preparation run.';
    put '// available: array of dataset keys that are ready; pending: array that are not yet available.';
    put 'function showDatasetStatusModal(available, pending) {';
    put '  var modal = document.getElementById("reportModal");';
    put '  var modalTitle = document.getElementById("modalTitle");';
    put '  var modalBody = document.getElementById("modalBody");';
    put '  if (!modal || !modalTitle || !modalBody) return;';
    put '  modalTitle.textContent = "Dataset Availability Summary";';
    put '  var html = "";';

    put '  if (available.length > 0) {';
    put '    html += "<div style=\"margin-bottom: 16px;\">";';
    put '    html += "<div class=\"ds-modal-section-title\">Ready for Processing</div>";';
    put '    available.forEach(function (k) {';
    put '      html += "<div class=\"ds-modal-row-ready\">";';
    put '      html += "<div class=\"ds-modal-icon-ready\">&#10003;</div>";';
    put '      html += "<span>" + escapeHtml(DS_LABELS[k] || k) + "</span>";';
    put '      html += "</div>";';
    put '    });';
    put '    html += "</div>";';
    put '  }';

    put '  if (pending.length > 0) {';
    put '    html += "<div>";';
    put '    html += "<div class=\"ds-modal-section-title\">Pending Data Availability</div>";';
    put '    pending.forEach(function (k) {';
    put '      html += "<div class=\"ds-modal-row-pending\">";';
    put '      html += "<div class=\"ds-modal-icon-pending\">!</div>";';
    put '      html += "<span>" + escapeHtml(DS_LABELS[k] || k) + "</span>";';
    put '      html += "</div>";';
    put '    });';
    put '    html += "<div class=\"ds-modal-notice\">";';
    put '    html += "The process cannot be executed until all selected datasets are available. ";';
    put '    html += "Please verify the data preparation status and try again once the datasets are ready.";';
    put '    html += "</div>";';
    put '    html += "</div>";';
    put '  }';

    put '  modalBody.innerHTML = html;';
    put '  modal.classList.add("show");';
    put '}';

%mend generate_javascript_modal;
