numberInput = function(inputId, value = 0, min = NULL, max = NULL, step = 1) {
  form = tags$div(
    class = "number-input",
    id = inputId,
    tags$div(
      class = "number-input-controls",
      tags$input(type = "number", min = min, max = max, value = value, step = step),
      tags$div(
        tags$a(
          id = "step-up",
          href = "#",
          `data-val` = 0,
          list(shiny::icon("angle-up"), "")
        ),
        tags$br(),
        tags$a(
          id = "step-down",
          href = "#",
          `data-val` = 0,
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
