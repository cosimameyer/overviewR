#' @title overview_heat
#'
#' @description This function plots a heat map to visualize the
#'     coverage of the time-scope-units of the data. Options include total
#'     number of cases per time-scope-unit or relative number in percentage.
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
#' @return A ggplot figure that presents sample coverage visually
#' @examples
#' data(toydata)
#' overview_heat(toydata, ccode, year, perc = TRUE, exp_total = 12)
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom ggplot2 ggplot

overview_heat <-
  function(dat,
           id,
           time,
           perc = FALSE,
           exp_total = NULL,
           xaxis = "Time frame",
           yaxis = "Sample",
           col_low = "#dceaf2",
           col_high = "#2A5773",
           label = TRUE) {
    dat <- dat
    id <- dplyr::enquo(id)
    time <- dplyr::enquo(time)

    # Set theme ---------------------------------------------------------------
    theme_plot <- theme_heat_plot()

    # Plot
    plot <-
      .overview_heat(
        dat = dat,
        id = id,
        time = time,
        label = label,
        perc = perc,
        col_low = col_low,
        col_high = col_high,
        xaxis = xaxis,
        yaxis = yaxis,
        theme_plot = theme_plot,
        exp_total = exp_total
      )

    return(plot)
  }
