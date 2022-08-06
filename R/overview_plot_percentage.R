#' @title overview_plot_percentage
#'
#' @description Function used in `overview_na` to plot the percentage share of NA values
#'
#' @param dat_result Data frame
#' @param theme_plot Theme for the plot (pre-defined)
#' @param yaxis Name for yaxis
#' @param xaxis Name for xaxix
#' @return The function returns a ggplot
#'
overview_plot_percentage <-
  function(dat_result = NULL,
           theme_plot = NULL,
           yaxis = NULL,
           xaxis = NULL) {
    plot <- ggplot2::ggplot(data = dat_result) +
      ggplot2::geom_col(ggplot2::aes(
        y = reorder(variable, -percentage),
        x = percentage
      )) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab(xaxis) +
      theme_plot

    return(plot)
  }
