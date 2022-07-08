pacman::p_load(htmltools, fresh, DHSCcolours)



my_theme <- fresh::create_theme(
   theme = "default",
   
   bs_vars_button(default_color = dhsc_white(),
                  default_bg = dhsc_primary()),
   
   
   bs_vars_color(
      brand_primary = dhsc_primary(),
      brand_success = dhsc_primary(),
      brand_info = dhsc_primary(),
      brand_warning = dhsc_primary(),
      brand_danger = dhsc_primary()
   ),
   
   bs_vars_dropdown(
      bg = dhsc_primary(),
      link_color = dhsc_white(),
      link_hover_bg = dhsc_primary(),
      link_active_bg = dhsc_primary(),
      link_hover_color = dhsc_white()
   ),
   
   bs_vars_font(
      family_sans_serif = "helvetica",
      size_base = "21px",
      size_small = "17.85px",
      size_h1 = "38.5px",
      size_h2 = "31.5px",
      size_h3 = "24.5px",
      size_h4 = "17.5px",
      size_h5 = "14px",
      size_h6 = "11.9px"
   ),
   
   
   bs_vars_global(
      body_bg = dhsc_white(),
      text_color = dhsc_black(),
      link_color = dhsc_black(),
      link_hover_color = dhsc_white()
   ),
   

   bs_vars_nav(link_hover_bg = dhsc_primary()),
   
   bs_vars_navbar(
      height = "15px",
      default_bg = dhsc_white(),
      padding_vertical = "25px",
      default_link_color = dhsc_black(),
      default_link_active_color = dhsc_white(),
      default_link_active_bg = dhsc_primary(),
      default_link_hover_color = dhsc_white(),
      default_link_hover_bg = dhsc_primary(),
   ),
   
   bs_vars_tabs(
      border_color = dhsc_primary(),
      link_hover_border_color = dhsc_primary(),
      active_link_hover_bg = dhsc_primary(),
      active_link_hover_color = dhsc_white(),
      active_link_hover_border_color = dhsc_white()
   ),
   
   
   output_file = "www\\my_theme.css"
   
   
)
