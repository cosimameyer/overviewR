#' @title .overview_tab
#'
#' @description Internal function that calculates the `overview_tab` for data.table objects
#'
#' @param dat The data set
#' @param id The scope (e.g., country codes or individual IDs). The axis is
#'     ordered in ascending order by default.
#' @param time The time (e.g., time periods given by years, months, ...)
#' @param perc If FALSE (default) plot returns the total number of observations
#'     per time-scope-unit. If TRUE, it returns the number of observations per
#'     time-scope-unit in percentage
#' @param exp_total Expected total number of observations (i.e. maximum)
#'     for time unit.
#' @param xaxis Label of your x axis ("Time frame" is default)
#' @param yaxis Label of your y axis ("Sample" is default)
#' @param col_low Hex color code for the lowest value (default is "#dceaf2")
#' @param col_high Hex color code for the lowest value (default is "#2A5773")
#' @param label If TRUE (default), the total number of observations/percentages
#'     of observations are displayed. If FALSE, it returns no labels.
#' @param theme_plot Previously generated theme
#' @param col_names The column names (containing id and time)
#' @return A ggplot

.overview_heat <-
  function(dat = NULL,
           id = NULL,
           time = NULL,
           label = FALSE,
           perc = FALSE,
           col_low = NULL,
           col_high = NULL,
           xaxis = NULL,
           yaxis = NULL,
           theme_plot = NULL,
           exp_total = NULL,
           col_names = NULL) {
    if (perc) {
      dat_agg <- dat %>%
        dplyr::group_by(!!id, !!time) %>%
        dplyr::mutate(
          count = dplyr::n(),
          total = count / exp_total
        )
    } else {
      dat_agg <- dat %>%
        dplyr::group_by(!!id, !!time) %>%
        dplyr::mutate(count = dplyr::n())
    }
    # Plot the result
    plot <- dat_agg %>%
      dplyr::ungroup() %>%
      dplyr::group_by(!!id) %>%
      ggplot2::ggplot(ggplot2::aes(factor(!!time), !!id)) +
      ggplot2::geom_tile(ggplot2::aes(fill = count), colour = "white") +
      ggplot2::scale_fill_gradient(low = col_low, high = col_high) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab(xaxis) +
      ggplot2::scale_y_discrete(limits = rev) +
      theme_plot

    # If there is a label, add it
    if (label & !perc) {
      plot <- plot +
        ggplot2::geom_text(ggplot2::aes(label = round(count, 1)), size = 3.3)
    }
    if (perc) {
      plot <- plot +
        ggplot2::geom_text(ggplot2::aes(label = paste(round(100 * total, 2),
          "%",
          sep = ""
        )),
        size = 3.3
        )
    }
    return(plot)
  }
