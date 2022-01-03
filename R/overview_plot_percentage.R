overview_plot_percentage <-
  function(dat_result = NULL,
           theme_plot = NULL,
           yaxis = NULL,
           xaxis = NULL) {
    plot <- ggplot2::ggplot(data = dat_result) +
      ggplot2::geom_col(ggplot2::aes(y = reorder(variable,-percentage),
                                     x = percentage)) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab(xaxis) +
      theme_plot

    return(plot)
  }
