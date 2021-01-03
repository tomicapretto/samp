server = function(input, output, session) {

  mixture = Mixture$new()

  observeEvent(input$add, {

    id = mixture$add(input$distribution)
    add_distribution(input$distribution, id)

    observeEvent(input[[paste0("remove_", id)]], {
      removeUI(paste0("#", paste0("div_", id)))
      mixture$remove(id)
    }, ignoreInit = TRUE)

    observe({
      shinyjs::html(paste0("weight_value_", id), input[[paste0("weight_", id)]])
    })

  })
}


