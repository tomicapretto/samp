rangeInput = function(inputId, value = 20, min = 0, max = 100, step = 1) {
  form = tags$div(
    class = "range-input",
    id = inputId,
    tags$div(
      tags$div(
        class = "range-input-controls",
        tags$div(class = "range-value"),
        tags$input(type = "range", min = min, max = max, value = value, step = step)
      )
    )
  )
  deps = htmltools::htmlDependency(
    name = "rangeInput",
    version = "1.0.0",
    src = c(file = samp_file("www", "range-input")),
    script = "binding.js",
    stylesheet = "styles.css"
  )
  htmltools::attachDependencies(form, deps)
}
