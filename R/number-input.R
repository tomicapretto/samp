numberInput = function(inputId, value = 0, min = NULL, max = NULL, step = 1) {
  form = tags$div(
    class = "number-input",
    id = inputId,
    tags$div(
      class = "number-input-controls",
      tags$input(type = "number", min = min, max = max, value = value, step = step),
      tags$div(
        style = "line-height: 25px; margin-left: auto;",
        tags$div(
          id = "step-up",
          list(shiny::icon("angle-up"), "")
        ),
        tags$div(
          id = "step-down",
          list(shiny::icon("angle-down"), "")
        )
      )
    )
  )

  deps = htmltools::htmlDependency(
    name = "numberInput",
    version = "1.0.0",
    src = c(file = samp_file("www", "number-input")),
    script = "binding.js",
    stylesheet = "styles.css"
  )

  htmltools::attachDependencies(form, deps)
}
