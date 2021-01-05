histogram = function(x) {
  echarts4r::e_charts(data.frame(x = x)) %>%
    echarts4r::e_histogram(
      x, name = "histogram", breaks = 30, legend = FALSE
    ) %>%
    echarts4r::e_x_axis(axisLine = list(show = FALSE)) %>%
    echarts4r::e_y_axis(axisLine = list(show = FALSE)) %>%
    echarts4r::e_color(color = "#34495e") %>%
    echarts4r::e_title("Empirical sampling distribution", left = "center")
}

density_plot = function(x, pdf) {
  echarts4r::e_charts(data.frame(x = x, pdf = pdf), x, dispose = FALSE) %>%
    echarts4r::e_line(pdf, symbol = "none", clip = TRUE, legend = FALSE) %>%
    echarts4r::e_x_axis(axisLine = list(show = FALSE)) %>%
    echarts4r::e_y_axis(axisLine = list(show = FALSE)) %>%
    echarts4r::e_color(color = "#34495e") %>%
    echarts4r::e_title("Theoretical distribution", left = "center")
}
