#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @importFrom bslib page_navbar nav_spacer nav layout_column_wrap nav_menu
#' @importFrom bslib navs_tab_card card_header card_body_fill
#' @importFrom htmltools css
#' @importFrom DT DTOutput
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    page_navbar(
      title = "Variance, SFC, Segment, and Product Analytics (VESPA)",
      bg = "#0062cc",
      nav_spacer(),

      nav("Executive Summary",
          layout_column_wrap(
            width = NULL, height = "90vh", gap = ".4vh",
            style = css(grid_template_columns = "minmax(0, 1fr) minmax(0, 5fr)"),
            mod_input_card_ui("input1"),
            layout_column_wrap(
              width = 1, height = "90vh",
              navs_tab_card(
                nav("Risk Color Summary",
                    card_body_fill(DTOutput("risk_color_summary"))
                ),
                nav("Profile Risk Metrics",
                    card_body_fill("This is a table")
                ),
                nav("Perfomance Risk Metrics",
                    card_body_fill("This is a table")
                ),
              )
            )
          )
      ),

      nav("Plots",
          layout_column_wrap(
            width = NULL, height = "90vh", gap = ".4vh",
            style = css(grid_template_columns = "minmax(0, 1fr) minmax(0, 5fr)"),
            mod_input_card_ui("input2"),
            layout_column_wrap(
              width = 1, height = "90vh", gap = ".4vh",
              layout_column_wrap(
                width = 1/3, height = "29.73333vh", gap = ".4vh",
                heights_equal = "all",
                mod_plot_card_ui("rocet_plt", "ROCET"), mod_plot_card_ui("ercf_plt", "ERCF"),
                mod_plot_card_ui("ercf_t_plt", "ERCF Tail")
              ),
              layout_column_wrap(
                width = 1/3, height = "29.73333vh", gap = ".4vh",
                heights_equal = "all",
                mod_plot_card_ui("acip_plt", "ACIp"),
                mod_plot_card_ui("acip_t_plt", "ACIp Tail"), mod_plot_card_ui("plot6", "Volume")
              ),
              layout_column_wrap(
                width = 1, height = "29.73333vh", gap = "0vh",
                mod_plot_card_ui("perf_plt", "Performanace")
              )
            )
          )
      ),

      nav_menu("Variance Recommendation Engine",
               nav("Summary",
                   layout_column_wrap(
                     width = NULL, height = "90vh", gap = ".4vh",
                     style = css(grid_template_columns = "minmax(0, 1fr) 5fr"),
                     mod_input_card_ui("input3"),
                     layout_column_wrap(
                       width = 1, height = "90vh",
                       card(
                         card_header("Summary"),
                         card_body_fill("This is a table")
                       )
                     )
                   )
               ),
               nav("Plots",
                   layout_column_wrap(
                     width = NULL, height = "90vh", gap = ".4vh",
                     style = css(grid_template_columns = "minmax(0, 1fr) 5fr"),
                     mod_input_card_ui("input4"),
                     layout_column_wrap(
                       width = 1/3, height = "90vh", gap = ".4vh",
                       mod_plot_card_ui("rocet_vre_plt", "ROCET"), mod_plot_card_ui("ercf_vre_plt", "ERCF"),
                       mod_plot_card_ui("ocr_vre_plt", "OCR"), mod_plot_card_ui("ercf_t_vre_plt", "ERCF Tail"),
                       mod_plot_card_ui("acip_vre_plt", "ACIp"), mod_plot_card_ui("acip_t_vre_plt", "ACIp Tail"),
                       mod_plot_card_ui("60in6_vre_plt", "60-in-6"), mod_plot_card_ui("90in12_vre_plt", "90-in-12"),
                       mod_plot_card_ui("90in24_vre_plt", "90-in-24")
                     )
                   )
               )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "vespaRedesign"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
