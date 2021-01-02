link_add = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "link_add",
    `data-val` = NULL,
    list(shiny::icon("plus"), "")
  )
}

link_remove = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "link_remove",
    `data-val` = NULL,
    list(shiny::icon("times"), "")
  )
}
