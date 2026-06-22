
/* ============================================================================
   MT ROUTING MODULE
   Handles navigation and routing logic
   ============================================================================ */
%macro generate_javascript_routing;
    put '// MT Routing Module';
    put 'const MTRouting = {';
    put '  currentRoute: "#risk-categories",';
    put '  routes: {';
    put '    "#risk-categories": () => getRiskCategoriesHTML(),';
    put '    "#saccr-cva": () => buildMasterTableRoute("#saccr-cva"),';
    put '    "#sama-q17": () => buildMasterTableRoute("#sama-q17"),';
    put '    "#sama-p3": () => buildMasterTableRoute("#sama-p3"),';
    put '    "#assets": () => buildMasterTableRoute("#assets"),';
    put '    "#liability": () => buildMasterTableRoute("#liability"),';
    put '    "#customer": () => buildMasterTableRoute("#customer"),';
    put '    "#offbalance": () => buildMasterTableRoute("#offbalance")';
    put '  },';
    put '  showRoute(route) {';
    put '    console.log("Navigating to:", route);';
    put '    this.currentRoute = route;';
    put '    this.updateContent();';
    put '    if (window.history && window.history.pushState) {';
    put '      window.history.pushState(null, null, route);';
    put '    }';
    put '  },';
    put '  updateContent() {';
    put '    const mainPanel = document.getElementById("main-panel");';
    put '    if (!mainPanel) return;';
    put '    const routeFunction = this.routes[this.currentRoute];';
    put '    if (routeFunction && typeof routeFunction === "function") {';
    put '      mainPanel.innerHTML = routeFunction();';
    put '      const reportCards = masterTableReportsConfig[this.currentRoute];';
    put '      if (reportCards) {';
    put '        reportCards.forEach(card => setTimeout(() => MTUI.setDefaultDates(card.id), 100));';
    put '      }';
    put '    } else {';
    put '      mainPanel.innerHTML = "<div style=\"text-align: center; padding: 50px;\"><h2>Page Not Found</h2><p>The requested page could not be found.</p></div>";';
    put '    }';
    put '  },';
    put '  initialize() {';
    put '    window.addEventListener("hashchange", () => {';
    put '      this.currentRoute = window.location.hash || "#risk-categories";';
    put '      this.updateContent();';
    put '    });';
    put '    window.addEventListener("popstate", () => {';
    put '      this.currentRoute = window.location.hash || "#risk-categories";';
    put '      this.updateContent();';
    put '    });';
    put '    this.currentRoute = window.location.hash || "#risk-categories";';
    put '    this.updateContent();';
    put '  }';
    put '};';

    put '// Global functions for backward compatibility';
    put 'function showRoute(route) { MTRouting.showRoute(route); }';
    put 'function updateContent() { MTRouting.updateContent(); }';

    put '// Bootstrap UI interactions and load the initial route';
    put 'MTUI.initializeEventListeners();';
    put 'MTUI.initializeAnimations();';
    put 'MTRouting.initialize();';
    put '</script>';
%mend generate_javascript_routing;

/* ============================================================================
   ROUTE CONTAINER COMPONENT
   ============================================================================ */
%macro generate_route_container;
    put '<div class="dashboard-grid">';
    put '<div id="main-panel" class="main-panel">';
    put '<!-- Content will be loaded dynamically by JavaScript -->';
    put '</div>';
    put '</div>';
%mend generate_route_container;
