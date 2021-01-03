#' Launch app
#'
#' @importFrom shiny tags observeEvent insertUI removeUI reactiveValues
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
