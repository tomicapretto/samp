server = function(input, output, session) {

  mixture = Mixture$new()
  store = reactiveValues()

  reactive_inputs = shiny::debounce(
    shiny::reactive(
      list(input$size, input$repetitions, input$statistic, input$percentile)
    ),
    millis = 500
  )

  observe({
    if (input$statistic == "Percentile") {
      shinyjs::show("percentile_div")
    } else {
      shinyjs::hide("percentile_div")
    }
  })

  observeEvent(input$add, {

    id = mixture$add(input$distribution)
    add_distribution(input$distribution, id)

    reactive_params = shiny::debounce(
      shiny::reactive({
        ids = c(paste0("weight_", id), paste0("dist_", id, c("_param_1", "_param_2")))
        lapply(ids, function(x) input[[x]])
      }),
      millis = 500
    )

    # Update weight label
    observer_1 = observe({
      shinyjs::html(paste0("weight_value_", id), input[[paste0("weight_", id)]])
    })

    observer_2 = observeEvent(
      c(reactive_params(),
        reactive_inputs()), {
      appHandler({
        wts = appHandler(mixture$get_weights(input))
        req(wts)
        store$rvs_list = mixture$mixture_rvs(input, wts, input$size, input$repetitions)
        store$pdf = mixture$mixture_pdf(input, wts)
      })
    }, ignoreInit = TRUE)

    observeEvent(input[[paste0("remove_", id)]], {
      removeUI(paste0("#", paste0("div_", id)))
      mixture$remove(id)
      observer_1$destroy()
      observer_2$destroy()
    }, ignoreInit = TRUE)
  })

  output$plot_rvs = echarts4r::renderEcharts4r({
    req(store$rvs_list)
    fun = switch(
      shiny::isolate(input$statistic),
      "Mean" = mean,
      "Median" = stats::median,
      "Minimum" = min,
      "Maximum" = max,
      "Percentile" = function(x) {
        stats::quantile(x, probs = shiny::isolate(input$percentile) / 100)
      }
    )
    histogram(vapply(store$rvs_list, fun, numeric(1)))
  })

  output$plot_pdf = echarts4r::renderEcharts4r({
    req(store$pdf)
    density_plot(store$pdf$x, store$pdf$pdf)
  })

}


# TODO: When value is manually placed outside boundaries, move it back to boundary.
