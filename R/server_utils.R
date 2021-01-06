add_distribution = function(distribution, id) {
  insertUI(
    selector = "#distributions_div",
    ui = distribution_params(distribution, id)
  )
}

get_dist_header = function(distribution) {
  switch(distribution,
   "norm" = "Normal",
   "t" = "T-student",
   "gamma" = "Gamma",
   "beta" = "Beta",
   "lnorm" = "Log-normal",
   "unif" = "Uniform"
  )
}

distribution_params = function(distribution, id) {

  names = get_param_names(distribution)
  values = get_default_values(distribution)
  range = get_range(distribution)
  header = paste(get_dist_header(distribution), "distribution")

  tags$div(
    id = paste0("div_", id),
    class = "item",
    tags$p(class = "dist_header", header),
    tags$div(
      class = "ui grid",
      tags$div(
        class = "row",
        tags$div(
          class = "fourteen wide column",
          tags$p("Weight"),
          rangeInput(
            inputId = paste0("weight_", id),
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
      ),
      tags$div(
        class = "row",
        style = "margin-top: -20px;",
        tags$div(
          class = "eight wide column",
          shiny.semantic::numericInput(
            inputId = paste0("dist_", id, "_param_1"),
            label = katexR::katex(names[1]),
            value = values[1],
            min = range[[1]][1],
            max = range[[1]][2],
            step = 0.1,
            width = "100%"
          )
        ),
        tags$div(
          class = "eight wide column",
          shiny.semantic::numericInput(
            inputId = paste0("dist_", id, "_param_2"),
            label = katexR::katex(names[2]),
            value = values[2],
            min = range[[2]][1],
            max = range[[2]][2],
            step = 0.1,
            width = "100%"
          )
        )
      )
    )
  )
}

get_param_names = function(distribution) {
  switch(distribution,
         "norm" = c("\\mu", "\\sigma"),
         "t" = c("\\nu", "\\mu"),
         "gamma" = c("\\alpha", "\\beta"), # shape and rate
         "beta" = c("\\alpha", "\\beta"),
         "lnorm" = c("\\mu", "\\sigma"), # convert to log scale
         "unif" = c("a", "b")
  )
}

get_default_values = function(distribution) {
  switch(distribution,
         "norm" = c(0, 1),
         "t" = c(5, 0),
         "gamma" = ,
         "beta" = c(2, 2),
         "lnorm" = c(0, 1),
         "unif" = c(-1, 1)
  )
}

get_range = function(distribution) {
  # TODO: Check values passed are acceptable
  switch(distribution,
         "norm" = list(c(NA, NA), c(0, NA)),
         "t" = list(c(0, NA), c(NA, NA)),
         "gamma" = ,
         "beta" = list(c(0, NA), c(0, NA)),
         "lnorm" = list(c(NA, NA), c(0, NA)),
         "unif" = list(c(NA, NA), c(NA, NA))
  )
}
