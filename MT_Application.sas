

%macro generate_mt_application;
    /* Initialize configuration */
    %mt_config;

    /* Start HTML output */
    data _null_;
        file _webout;

        /* Generate HTML Structure */
        %generate_html_header;

        /* Generate UI Components */
        %generate_loading;
        %generate_notification;
        %generate_navbar;
        %generate_sidebar;

        /* Generate Main Content */
        put '<main class="main-content">';
        %generate_page_header;
        %generate_modal;

        /* Generate Route Content Container */
        %generate_route_container;

        put '<script>';

        /* Generate Modal */
        %generate_javascript_modal;

        /* Generate JS-side configuration (riskModulesConfig, masterTableReportsConfig, apiEndpoints) */
        %mt_config_new;

        /* Generate JavaScript */
        %generate_javascript_utils;

        %generate_javascript_ui;

        %Routes;

        %Report_Generation;

        %generate_javascript_routing;

        put '</body>';
        put '</html>';
    run;
%mend generate_mt_application;


%generate_mt_application;
