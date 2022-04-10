overview_plot_absolute <-
  function(dat_result = NULL,
           theme_plot = NULL,
           yaxis = NULL,
           xaxis = NULL) {
    plot <- ggplot2::ggplot(data = dat_result) +
      ggplot2::geom_col(ggplot2::aes(y = reorder(variable, -na_count),
                                     x = na_count)) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab(xaxis) +
      theme_plot
    return(plot)
  }
