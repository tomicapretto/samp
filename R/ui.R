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
                "T" = "t",
                "Gamma" = "gamma",
                "Beta" = "beta",
                "Log-normal" = "lnorm",
                "Weibull" = "weibull",
                "Uniform" = "unif"
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
      id = "distributions_div"
    )
  )
}

body = function() {
  tags$div(
    style="margin-left: 260px",
    tags$div(
      class="ui container",
      tags$h1(class = "ui header", "First header")
    )
  )
}


ui = function() {
  shiny.semantic::semanticPage(
    shinyjs::useShinyjs(),
    tags$head(shiny::includeCSS(samp_file("www", "style.css"))),
    sidebar(),
    body()
  )
}
