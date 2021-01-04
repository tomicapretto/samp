server = function(input, output, session) {

  mixture = Mixture$new()
  store = reactiveValues()

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
      wts = AppHandler({
        mixture$get_weights(input)
      })
      store$rvs = AppHandler({
        mixture$mixture_rvs(input, 500, wts)
      })
      store$pdf = AppHandler({
        mixture$mixture_pdf(input, wts)
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
    req(store$rvs)
    hist(store$rvs)
  })

  output$plot_pdf = shiny::renderPlot({
    req(store$pdf)
    plot(store$pdf$x, store$pdf$pdf, type = "l")
  })

}


