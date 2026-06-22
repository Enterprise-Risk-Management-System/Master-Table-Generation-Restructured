
/* ============================================================================
   NAVBAR COMPONENT
   ============================================================================ */
%macro generate_navbar;
    put '<nav class="navbar">';
    put '<div class="nav-container">';
    put '<a href="#" class="nav-brand">';
    put '<div class="logo"><i class="fas fa-shield-alt"></i></div>';
    put '</a>';
    put '<ul class="nav-menu">';
    put "<li><a href='#risk-categories' onclick='showRoute(""#risk-categories""); return false;'>Risk Category</a></li>";
    put '</ul>';
    put '<div class="nav-user">';
    put '<div class="user-avatar"><i class="fas fa-user"></i></div>';
    put '<div class="user-info">';
    put "<div class='user-name'>&sysuserid</div>";
    put '</div>';
    put '</div>';
    put '</div>';
    put '</nav>';
%mend generate_navbar;

/* ============================================================================
   SIDEBAR COMPONENT
   ============================================================================ */
%macro generate_sidebar;
    put '<aside class="sidebar" id="sidebar">';
    put '<ul class="sidebar-menu">';
    put '<li><a href="#risk-categories" class="active"><i class="fas fa-layer-group"></i>Risk Categories</a></li>';
    put '</ul>';
    put '</aside>';
%mend generate_sidebar;

/* ============================================================================
   PAGE HEADER COMPONENT
   ============================================================================ */
%macro generate_page_header;
    put '<div class="page-header">';
    put '<div class="breadcrumb">';
    put '<a href="#risk-categories">Dashboard</a>';
    put '<i class="fas fa-chevron-right"></i>';
    put '<span>Risk Management</span>';
    put '</div>';
    put '<h1 class="page-title">Risk Management Data Preparation</h1>';
    put '<p class="page-subtitle">Comprehensive overview of enterprise risk metrics and compliance status</p>';
    put '</div>';
%mend generate_page_header;

/* ============================================================================
   RISK MODULE COMPONENT
   ============================================================================ */
%macro generate_risk_module(module_type, title, description, icon, color_class, stat1_value, stat1_label, stat2_value, stat2_label);
    put '<div class="risk-module" data-module="&module_type">';
    put '<div class="module-header">';
    put '<div class="module-icon &color_class"><i class="&icon"></i></div>';
    put '<h3 class="module-title">&title</h3>';
    put '</div>';
    put '<p class="module-description">&description</p>';
    put '<div class="module-stats">';
    put '<div class="stat-item"><div class="stat-value">&stat1_value</div><div class="stat-label">&stat1_label</div></div>';
    put '<div class="stat-item"><div class="stat-value">&stat2_value</div><div class="stat-label">&stat2_label</div></div>';
    put '</div>';
    put '</div>';
%mend generate_risk_module;

/* ============================================================================
   MODAL COMPONENT
   ============================================================================ */
%macro generate_modal;
    put '<div class="modal" id="reportModal">';
    put '<div class="modal-content">';
    put '<div class="modal-header">';
    put '<h3 class="modal-title" id="modalTitle">Report Details</h3>';
    put '<button class="modal-close" onclick="closeModal()">&times;</button>';
    put '</div>';
    put '<div id="modalBody"></div>';
    put '</div>';
    put '</div>';
%mend generate_modal;

/* ============================================================================
   LOADING COMPONENT
   ============================================================================ */
%macro generate_loading;
    put '<div class="loading" id="loading"><div class="spinner"></div></div>';
%mend generate_loading;

/* ============================================================================
   NOTIFICATION COMPONENT
   ============================================================================ */
%macro generate_notification;
    put '<div class="notification" id="notification"><i class="fas fa-check-circle"></i><span id="notification-text">Report generated successfully!</span></div>';
%mend generate_notification;
