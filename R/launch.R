#' Launch app
#'
#' @importFrom shiny tags req observe observeEvent insertUI removeUI reactiveValues
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
