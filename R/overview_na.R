#' @title overview_na
#'
#' @description This function plots a ggplot to visualize the distribution of
#'     NAs across all variables in the data set.
#'
#' @param dat Your data set
#' @param yaxis Label of your y axis ("Variables" is default)
#' @param perc If TRUE (default) plot returns the number of NAs in percentage
#' @param row_wise If TRUE (FALSE is default) plot return the number of NAs
#'     per row
#' @param add If TRUE (FALSE is default) it generates a new data frame with
#'     na_count and percentage share of NAs for each row
#' @return Depending on the selection, the function returns a ggplot figure that
#'     presents the distribution of NAs in the data set or adds the information
#'     on the row-wise NA share
#' @examples
#' data(toydata)
#' overview_na(toydata, perc = FALSE)
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom tibble "rownames_to_column"
#' @importFrom ggplot2 ggplot
#' @importFrom stats reorder

overview_na <- function(dat,
                        yaxis = "Variables",
                        perc = TRUE,
                        row_wise = FALSE,
                        add = FALSE) {
  # Set theme ---------------------------------------------------------------
  # Create a theme for the plot
  theme_plot <- theme_na_plot()

  # Perform calculations ----------------------------------------------------

  # Start with the data
  dat <- dat

  if (row_wise == FALSE) {
    # Calculate the share non_row_wise
    dat_result <- calculate_share_non_row_wise(dat = dat)

    # Percentage --------------------------------------------------------------
    if (perc == TRUE) {
      plot_perc <-
        overview_plot_percentage(
          dat_result = dat_result,
          theme_plot = theme_plot,
          yaxis = yaxis,
          xaxis = "Number of NA (in %)"
        )

      return(plot_perc)
    } else if (perc == FALSE) {
      # Absolute numbers --------------------------------------------------------
      plot_absolute <-
        overview_plot_absolute(
          dat_result = dat_result,
          theme_plot = theme_plot,
          yaxis = yaxis,
          xaxis = "Number of NA (total)"
        )

      return(plot_absolute)
    }

  }

  if (row_wise == TRUE) {
    # Calculate the share row_wise
    dat_result <- calculate_share_row_wise(dat = dat)

    # Absolute numbers --------------------------------------------------------
    if (add == FALSE && perc == FALSE) {
      plot_absolute <-  overview_plot_absolute(
        dat_result = dat_result,
        theme_plot = theme_plot,
        yaxis = yaxis,
        xaxis = "Number of NA (total)"
      )

      return(plot_absolute)
    }

    # Percentage --------------------------------------------------------------
    if (add == FALSE && perc == TRUE) {
      plot_perc <-  overview_plot_percentage(
        dat_result = dat_result,
        theme_plot = theme_plot,
        yaxis = yaxis,
        xaxis = "Number of NA (in %)"
      )
      return(plot_perc)
    }

    if (add == TRUE) {
      dat_with_na <-
        overview_add_na_output(dat_result = dat_result, dat = dat)
      return(dat_with_na)
    }
  }
}
