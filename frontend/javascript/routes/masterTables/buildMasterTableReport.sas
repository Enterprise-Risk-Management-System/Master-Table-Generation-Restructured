
/* ============================================================================
   MASTER TABLE REPORT ROUTE BUILDER
   Generic prompt-card renderer shared by every report route (SACCR/CVA,
   SAMA Q17, IRRBB, Assets, Liabilities, Off Balance, Customer MT).
   Driven entirely by masterTableReportsConfig - no per-route markup.
   ============================================================================ */
%macro buildMasterTableReport;
    put 'function buildMasterTableRoute(routeKey) {';
    put '  const cards = (masterTableReportsConfig[routeKey] || []).map(getpromptHTML).join("");';
    put '  return "<div style=\"max-width: 1200px; margin: 0 auto; padding: 20px;\">" +';
    put '    "<div style=\"display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 25px; margin-bottom: 30px;\">" +';
    put '    cards + "</div></div>";';
    put '}';

    put 'function getpromptHTML(report) {';
    put '  const { id: reportId, title, description, frequency, fields } = report;';
    put '  let html = "<div style=\"background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); border: 2px solid transparent; transition: all 0.3s ease; cursor: pointer;\" ";';
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

    put '  html += "<div style=\"display: flex; gap: 10px;\">";';
    put '  html += "<button onclick=\"generateRegulatoryReport(&apos;" + reportId + "&apos;)\" style=\"padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; font-size: 0.9rem; background: #3b82f6; color: white;\" ";';
    put '  html += "onmouseover=\"this.style.background=&apos;#2563eb&apos;\" onmouseout=\"this.style.background=&apos;#3b82f6&apos;\">Run</button>";';
    put '  html += "<button onclick=\"viewReportHistory(&apos;" + reportId + "&apos;)\" style=\"padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; font-size: 0.9rem; background: #6b7280; color: white;\" ";';
    put '  html += "onmouseover=\"this.style.background=&apos;#4b5563&apos;\" onmouseout=\"this.style.background=&apos;#6b7280&apos;\">View History</button>";';
    put '  html += "</div>";';

    put '  html += "</div>";';
    put '  return html;';
    put '}';
%mend buildMasterTableReport;
