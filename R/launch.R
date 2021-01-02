#' Launch app
#'
#' @importFrom shiny tags
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
