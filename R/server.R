server = function(input, output, session) {

  observeEvent(input$add, {

    id = paste0(sample(letters, 5, replace = TRUE), collapse = "")
    add_distribution(input$distribution, id)

    observeEvent(input[[paste0("remove_", id)]], {
      removeUI(paste0("#", paste0("div_", id)))
    }, ignoreInit = TRUE)

    observe({
      shinyjs::html(paste0("weight_value_", id), input[[paste0("weight_", id)]])
    })

  })
}


