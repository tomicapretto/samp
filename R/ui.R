# https://appsilon.github.io/shiny.semantic/articles/intro.html

css <- "
#examples > div > .header {
  margin-top: 1em;
}
.theme.form {
  position: fixed !important;
  right: 5px;
  top: 3px;
  width: 15em !important;
}"

sidebar = function() {
  tags$div(
    class = "ui sidebar inverted vertical visible menu",
    id = "sidebar",

    tags$div(
      class = "item",
      tags$p(
        class = "sidebar_header",
        "Sampling Distributions"
      )
    ),

    tags$div(
      class = "item",
      tags$div(
        class = "ui grid",
        tags$div(
          class = "row",
          tags$div(
            class = "fourteen wide column",
            shiny.semantic::selectInput(
              inputId = "distribution",
              label = "Select a distribution",
              choices = c(
                "Normal" = "norm",
                "Gamma" = "gamma"
              )
            )
          ),
          tags$div(
            class = "two wide column",
            style = "top:50%",
            link_add("add")
          )
        )
      )
    ),

    tags$div(
      class = "item",
      tags$div(
        class = "ui grid",
        tags$div(
          class = "row",
          tags$div(
            class = "fourteen wide column",
            shiny.semantic::selectInput(
              inputId = "distribution2",
              label = "Select a distribution",
              choices = c(
                "Normal" = "norm",
                "Gamma" = "gamma"
              )
            )
          ),
          tags$div(
            class = "two wide column",
            style = "top:50%",
            link_remove("remove")
          )
        )
      )
    )
  )
}

body = function() {
  tags$div(
    style="margin-left: 260px",
    tags$div(
      id = "examples",
      class="ui container",
      tags$h1(class = "ui header", "First header")
    )
  )
}


ui = function() {
  shiny.semantic::semanticPage(
    tags$head(
      tags$style(shiny::HTML(css)),
      shiny::includeCSS(samp_file("www", "style.css"))
    ),
    sidebar(),
    body()
  )
}
