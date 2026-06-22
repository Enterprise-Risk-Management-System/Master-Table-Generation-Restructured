
/* ============================================================================
   MASTER TABLE REPORT GENERATION MODULE
   Executes the stored procedure backing a report prompt card and reports
   back to the user via the shared notification banner.
   ============================================================================ */
%macro masterTableReportGeneration;
    put '// MT Report Generation Module';
    put 'const MTReports = {';
    put '  resolveReportDate(reportType) {';
    put '    let dateInput = document.getElementById(reportType + "-asof");';
    put '    if (!dateInput) dateInput = document.getElementById(reportType + "-date");';
    put '    if (!dateInput) dateInput = document.getElementById(reportType + "-asof1");';
    put '    return dateInput ? dateInput.value : null;';
    put '  },';
    put '  generateRegulatoryReport(reportType) {';
    put '    const selectedDate = this.resolveReportDate(reportType);';
    put '    console.log("Generating " + reportType + " report for date: " + selectedDate);';
    put '    if (!selectedDate || selectedDate.trim() === "") {';
    put '      MTUtils.showNotification("Please select a valid date for the report", "error");';
    put '      return;';
    put '    }';
    put '    const storedProcedureUrl = masterTableReportEndpoints[reportType];';
    put '    if (!storedProcedureUrl) {';
    put '      MTUtils.showNotification("No stored procedure endpoint configured for " + reportType + " yet", "error");';
    put '      return;';
    put '    }';
    put '    MTUtils.showLoading();';
    put '    const formData = new URLSearchParams();';
    put '    formData.append("reporting_date", selectedDate);';
    put '    if (reportType === "sama-q17-2" || reportType === "sama-p3") {';
    put '      const londonDateInput = document.getElementById(reportType + "-londonDate");';
    put '      if (londonDateInput && londonDateInput.value) {';
    put '        formData.append("london_date", londonDateInput.value);';
    put '      }';
    put '    }';
    put '    fetch(storedProcedureUrl, {';
    put '      method: "POST",';
    put '      headers: {';
    put '        "Content-Type": "application/x-www-form-urlencoded",';
    put '        "Accept": "text/html"';
    put '      },';
    put '      body: formData.toString()';
    put '    })';
    put '    .then(response => {';
    put '      if (!response.ok) {';
    put '        throw new Error("Network response was not ok: " + response.status);';
    put '      }';
    put '      return response.text();';
    put '    })';
    put '    .then(() => {';
    put '      MTUtils.showNotification("Master Table Prepared Successfully", "success");';
    put '      MTUtils.hideLoading();';
    put '    })';
    put '    .catch(error => {';
    put '      MTUtils.hideLoading();';
    put '      MTUtils.showNotification("Error generating Master Tables: " + error.message, "error");';
    put '    });';
    put '  },';
    put '  viewReportHistory(reportType) {';
    put '    console.log("Viewing report history for:", reportType);';
    put '    MTUtils.showNotification("Report history feature coming soon", "info");';
    put '  }';
    put '};';
    put '// Global functions for backward compatibility';
    put 'function generateRegulatoryReport(reportType) { MTReports.generateRegulatoryReport(reportType); }';
    put 'function viewReportHistory(reportType) { MTReports.viewReportHistory(reportType); }';
%mend masterTableReportGeneration;
