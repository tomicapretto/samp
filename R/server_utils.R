add_distribution = function(distribution, id) {
  insertUI(
    selector = "#distributions_div",
    ui = weight_slider(id)
  )
}

weight_slider = function(id) {
  tags$div(
    id = paste0("div_", id),
    class = "item",
    tags$div(
      class = "ui grid",
      tags$div(
        class = "row",
        tags$div(
          class = "fourteen wide column",
          tags$p(
            style = "margin-bottom:-5px",
            "Weight: ",
            tags$span(id = paste0("weight_value_", id), style = "font-weight: bold;")
          ),
          shiny.semantic::sliderInput(
            inputId = paste0("weight_", id),
            label = NULL,
            min = 0,
            max = 1,
            value = 0.5,
            step = 0.01
          )
        ),
        tags$div(
          class = "two wide column",
          style = "top:50%",
          link_remove(paste0("remove_", id))
        )
      )
    )
  )
}
