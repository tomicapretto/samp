server = function(input, output, session) {

  mixture = Mixture$new()
  rvs = reactiveValues()

  observeEvent(input$add, {
    id = mixture$add(input$distribution)
    add_distribution(input$distribution, id)

    # Listen to inputs generated here.
    # 'debounce' so we prevent very often invalidations
    rve = shiny::debounce(shiny::reactive({
      inputs = c(
        paste0("weight_", id),
        paste0("dist_", id, c("_param_1", "_param_2"))
      )
      lapply(inputs, function(x) {input[[x]]})
    }), millis = 1000)

    observer_1 = observe({
      shinyjs::html(paste0("weight_value_", id), input[[paste0("weight_", id)]])
    })

    observer_2 = observeEvent(rve(), {
      rvs$rvs = AppHandler({
        mixture$evaluate("rvs", input, 100)
      })
      rvs$pdf = AppHandler({
        mixture$evaluate("pdf", input)
      })
    }, ignoreInit = TRUE)

    observeEvent(input[[paste0("remove_", id)]], {
      removeUI(paste0("#", paste0("div_", id)))
      mixture$remove(id)
      observer_1$destroy()
      observer_2$destroy()
    }, ignoreInit = TRUE)
  })

  output$plot_rvs = shiny::renderPlot({
    req(rvs$rvs)
    hist(rvs$rvs)
  })

  output$plot_pdf = shiny::renderPlot({
    req(rvs$pdf)
    plot(rvs$pdf$x, rvs$pdf$pdf, type = "l")
  })

}


