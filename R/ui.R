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
    style = "margin-left: 260px",
    tags$div(
      class = "ui container",
      tags$h1(class = "ui header", "Sampling distributions playground"),
      ui_row(
        ui_col(
          width = 4,
          tags$p("Sample size", class = "card-header"),
          tags$div(
            numberInput("size", value = 20, min = 2, max = 1000)
          )
        ),
        ui_col(
          width = 4,
          tags$p("Repetitions", class = "card-header"),
          numberInput("repetitions", value = 50, min = 10, max = 1000, step = 10)
        ),
        ui_col(
          width = 4,
          tags$p("Statistic", class = "card-header"),
          selectorInput("statistic", c("Mean", "Median", "Minimum", "Maximum", "Percentile"))
        ),
        ui_col(
          width = 4,
          shinyjs::hidden(
            tags$div(
              id = "percentile_div",
              tags$p("Percentile", class = "card-header"),
              numberInput("percentile", value = 25, min = 1, max = 99, step = 1)
            )
          )
        )
      ),
      verbatimTextOutput("text"),
      tags$div(
        shiny::plotOutput("plot_rvs", height = "340px", width = "85%"),
        shiny::plotOutput("plot_pdf", height = "340px", width = "85%"),
        align = "center"
      )
    )
  )
}

ui = function() {
  shiny.semantic::semanticPage(
    tags$head(
      shiny::includeCSS(samp_file("www", "style.css"))
    ),
    shinyjs::useShinyjs(),
    shinypop::use_notiflix_notify(
      position = "right-bottom",
      timeout = 5000
    ),
    sidebar(),
    body()
  )
}

ui_row = function(...) {
  tags$div(
    class = "ui grid",
    tags$div(
      class = "row",
      ...
    )
  )
}

ui_col = function(width, ...) {
  opts = c("one", "two", "three", "four", "five", "six", "seven", "eight",
           "nine", "ten", "eleven", "twelve", "thirtheen", "fourteen",
           "fifteen", "sixteen")
  width = opts[width]
  tags$div(
    class = paste(width, "wide column"),
    ...
  )
}
