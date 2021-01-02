link_add = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "action-button link_add",
    `data-val` = 0,
    list(shiny::icon("plus"), "")
  )
}

link_remove = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "action-button link_remove",
    `data-val` = 0,
    list(shiny::icon("times"), "")
  )
}
