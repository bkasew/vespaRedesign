#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DT renderDT
#' @importFrom tibble tibble
#' @noRd
app_server <- function(input, output, session) {

  # Your application server logic
  output$risk_color_summary <- renderDT(
    tibble(Variance = rep("This is a pretty long name", 50),
           Seller = 1:50,
           `Review Status` = 1:50,
           `ACIp Risk Color` = 1:50,
           `ACIp Tail Risk Color` = 1:50,
           `ERCF Risk Color` = 1:50,
           `ERCF Tail Risk Color` = 1:50,
           `ROCET Risk Color` = 1:50,
           `Volume Risk Color` = 1:50,
           `60-in-6 Risk Color` = 1:50,
           `90-in-12 Risk Color` = 1:50,
           `90-in-24 Risk Color` = 1:50)
  )


  mod_input_card_server("input1")
  mod_input_card_server("input2")
  mod_input_card_server("input3")
  mod_input_card_server("input4")

  mod_plot_card_server("rocet_plt")
}
