selectorInput = function(inputId, choices) {
  form = tags$div(
    class = "selector-input",
    id = inputId,
    tags$div(
      class = "data",
      selectorOptions(choices)
    ),
    tags$div(
      class = "select-input-controls",
      tags$div(
        class = "selection",
        choices[1]
      ),
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
    name = "selectorInput",
    version = "1.0.0",
    src = c(file = samp_file("www", "selector-input")),
    script = "binding.js",
    stylesheet = "styles.css"
  )

  htmltools::attachDependencies(form, deps)
}


selectorOptions = function(choices) {
  first = paste0('<option class = "animate-bottom" value = "', choices[1], '" selected>', choices[1], '</option>')
  html = vapply(choices[-1], function(x) {
    paste0('<option class = "animate-bottom" value = "', x, '">', x, '</option>')
  },
  character(1)
  )
  shiny::HTML(paste(c(first, html), collapse = "\n"))
}
