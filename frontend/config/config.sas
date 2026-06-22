
/* ============================================================================
   GLOBAL CONFIGURATION
   ============================================================================ */
%macro mt_config;
    /* Global variables for configuration */
    %global MT_TITLE MT_VERSION MT_COMPANY;
    %let MT_TITLE = Master Table Generation;
    %let MT_VERSION = 1.0.0;
    %let MT_COMPANY = ANB;

    /* External resource URLs - Replace with your company web server URLs */
    %global FONT_AWESOME_URL GOOGLE_FONTS_URL;
/*    %let FONT_AWESOME_URL = https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css;*/
/*    %let GOOGLE_FONTS_URL = https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap;*/
%mend mt_config;

/* ============================================================================
   HTML HEADER GENERATOR
   ============================================================================ */
%macro generate_html_header;
    put '<!DOCTYPE html>';
    put '<html lang="en">';
    put '<head>';
    put '<meta charset="UTF-8" />';
    put '<meta name="viewport" content="width=device-width, initial-scale=1.0" />';
    put '<title>Master Table Generation</title>';

    /* External CSS Resources */
/*    put '<link href="&FONT_AWESOME_URL" rel="stylesheet" />';*/
/*    put '<link href="&GOOGLE_FONTS_URL" rel="stylesheet" />';*/

    /* Generate CSS */
    %generate_css_styles;

    put '</head>';
    put '<body>';
%mend generate_html_header;
