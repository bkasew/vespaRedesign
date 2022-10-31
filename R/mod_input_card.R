#' input_card UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS br
#' @importFrom shinyWidgets useSweetAlert pickerInput prettyRadioButtons actionBttn
#' @importFrom htmltools css
#' @importFrom bslib card card_body_fill
#' @importFrom dplyr filter distinct pull
mod_input_card_ui <- function(id){
  ns <- NS(id)
  useSweetAlert()
  card(
    card_body_fill(
      pickerInput(
        inputId = ns("report_month"),
        label = "Report Month",
        choices = c("a", "b", "c", "d")
      ),
      br(),
      prettyRadioButtons(
        inputId = ns("filter_by"),
        label = "Filter By",
        choices = c("Variance" = "Variance", "Special Feature Code" = "SFC", "Segment" = "Segment"),
        icon = icon("check"),
        bigger = FALSE
      ),
      pickerInput(
        inputId = ns("select_exec"),
        label = "Variance",
        choices = df %>% filter(Variance != "NONE") %>% distinct(Variance) %>% pull(Variance)
      ),
      pickerInput(
        inputId = ns("select_seller"),
        label = "Seller",
        choices = NULL
      ),
      pickerInput(
        inputId = ns("review_status"),
        label = "Review Status",
        choices = c("All", "Needs Review", "No Review")
      ),
      br(),
      br(),
      actionBttn(
        inputId = ns("help"),
        label = "Help",
        style = "jelly",
        size = "sm",
        color = "primary"
      ),
      style = css(background_color = "#dbe6f4")
    )
  )
}

#' input_card Server Functions
#'
#' @noRd
#'
#' @importFrom shiny observe bindEvent
#' @importFrom shinyWidgets updatePickerInput sendSweetAlert
#' @importFrom dplyr filter distinct pull
#' @importFrom rlang parse_expr
mod_input_card_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    ## update exec choices based on selection
    observe({
      exec_choices <- df %>%
        filter(!!parse_expr(input$filter_by) != "NONE") %>%
        distinct(!!parse_expr(input$filter_by)) %>%
        pull(!!parse_expr(input$filter_by))
      updatePickerInput(
        inputId = "select_exec",
        label = input$filter_by,
        choices = exec_choices,
        selected = exec_choices[1],
        session = session
      )
    }) %>% bindEvent(input$filter_by)

    ## change seller choices based on selection
    observe({
      seller_choices <- df %>%
        filter(!!parse_expr(input$filter_by) == input$select_exec) %>%
        pull(Lender)

      updatePickerInput(
        inputId = "select_seller",
        choices = seller_choices,
        selected = seller_choices[1],
        session = session
      )
    }) %>% bindEvent(input$select_exec)

    ## update result of `Help` button
    observe({
      sendSweetAlert(
        session = session,
        title = "Using VESPA",
        text = "Here is some imformation on VESPA",
        type = "info"
      )
    }) %>% bindEvent(input$help)
  })
}

## To be copied in the UI
# mod_input_card_ui("input_card_1")

## To be copied in the server
# mod_input_card_server("input_card_1")
