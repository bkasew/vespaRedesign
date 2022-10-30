#' plot_card UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS
#' @importFrom bslib card card_header card_body_fill
#' @importFrom plotly plotlyOutput
mod_plot_card_ui <- function(id, label){
  ns <- NS(id)
  card(
    card_header(label),
    card_body_fill(
      plotlyOutput(ns("plot")),
      class = "p-0"
    ),
    full_screen = FALSE
  )
}

#' plot_card Server Functions
#'
#' @noRd
#'
#' @importFrom dplyr mutate
#' @importFrom ggplot2 ggplot geom_density aes theme_minimal theme element_blank element_rect
#' @importFrom plotly renderPlotly ggplotly layout
mod_plot_card_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    ## create dataframe and plot
    df_plot <- iris %>%
      mutate(ttip = ("First thing: result 1\nSecond thing: result 2\nThird thing: result 3"))

    g <- ggplot(df_plot) +
      geom_density(aes(Sepal.Length), fill="#0062cc", alpha = .7) +
      theme_minimal() +
      theme(axis.title.y=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.y=element_blank(),
            axis.title.x=element_blank(),
            panel.background = element_rect(fill = 'white'))

    m <- list(l = 0, r = 20, b = 0, t = 10, pad = 0)
    output$plot <- renderPlotly({
      ggplotly(g) %>%
        layout(margin = m,xaxis = list(autorange = TRUE))
    })

  })
}

## To be copied in the UI
# mod_plot_card_ui("plot_card_1")

## To be copied in the server
# mod_plot_card_server("plot_card_1")
