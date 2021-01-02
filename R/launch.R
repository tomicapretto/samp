#' Launch app
#'
#' @importFrom shiny tags observeEvent insertUI removeUI
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
