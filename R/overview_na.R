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
                        add = FALSE
                        ) {
  # Start with the data
  dat <- dat

  # Set theme ---------------------------------------------------------------
  # Create a theme for the plot
  theme_plot <- ggplot2::theme(
    # get rid of panel grids
    axis.line = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    axis.ticks.x = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    # Change plot and panel background
    plot.background = ggplot2::element_rect(fill = "white"),
    panel.background = ggplot2::element_rect(fill = "white"),
    # Change legend
    legend.direction = "horizontal",
    legend.background = ggplot2::element_rect(fill = "black", color = NA),
    legend.key = ggplot2::element_rect(color = "black", fill = "black"),
    legend.title = ggplot2::element_blank(),
    # Change text
    plot.caption = ggplot2::element_text(size = 5),
    axis.text = ggplot2::element_text(
      face = "plain",
      color = "black",
      size = 8
    ),
    text = ggplot2::element_text(size = 10,
                                 face = "plain")
  )
  if (row_wise == FALSE) {
  # Generate necessary variables --------------------------------------------
  # Inspired by:
  # https://bit.ly/3fqhH7l
  na_count <- vapply(dat, function(y)
    sum(length(which(is.na(
      y
    )))), FUN.VALUE = numeric(1))
  total <- vapply(dat, function(y)
    length(y), FUN.VALUE = numeric(1))

  dat_frame <- data.frame(na_count, total)
  # Add rownames as variable
  dat_frame <-
    tibble::rownames_to_column(dat_frame, var = "variable")
  # Get percentage
  dat_frame <- dat_frame %>%
    dplyr::mutate(percentage = na_count / (total / 100))



  # Absolute numbers --------------------------------------------------------
  if (perc == FALSE) {
    plot_absolute <- ggplot2::ggplot(data = dat_frame) +
      ggplot2::geom_col(ggplot2::aes(y = reorder(variable, -na_count),
                                     x = na_count)) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab("Number of NA (total)") +
      theme_plot

    return(plot_absolute)
  }

  # Percentage --------------------------------------------------------------
  if (perc == TRUE) {
    plot_perc <- ggplot2::ggplot(data = dat_frame) +
      ggplot2::geom_col(ggplot2::aes(y = reorder(variable, -percentage),
                                     x = percentage)) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab("Number of NA (in %)") +
      theme_plot

    return(plot_perc)
  }
  }

  if (row_wise == TRUE) {
    dat_frame <- dat %>%
      dplyr::rowwise() %>%
      dplyr::summarise(dplyr::across(dplyr::everything(), dplyr::funs(sum(is.na(.))))) %>%
      dplyr::mutate(na_count = rowSums(.),
                    total = length(colnames(.))) %>%
      dplyr::select(na_count, total)

    # Add rownames as variable
    dat_frame$variable = 1:nrow(dat_frame)

    # Get percentage
    dat_frame <- dat_frame %>%
      dplyr::mutate(percentage = na_count / (total / 100))


    # Absolute numbers --------------------------------------------------------
    if (add == FALSE && perc == FALSE) {
      plot_absolute <- ggplot2::ggplot(data = dat_frame) +
        ggplot2::geom_col(ggplot2::aes(y = reorder(variable, -na_count),
                                       x = na_count)) +
        ggplot2::ylab(yaxis) +
        ggplot2::xlab("Number of NA (total)") +
        theme_plot

      return(plot_absolute)
    }

    # Percentage --------------------------------------------------------------
    if (add == FALSE && perc == TRUE) {
      plot_perc <- ggplot2::ggplot(data = dat_frame) +
        ggplot2::geom_col(ggplot2::aes(y = reorder(variable, -percentage),
                                       x = percentage)) +
        ggplot2::ylab(yaxis) +
        ggplot2::xlab("Number of NA (in %)") +
        theme_plot

      return(plot_perc)
    }

    if (add == TRUE) {
      dat_frame <- dat_frame %>%
        dplyr::select(na_count, percentage)
      dat_with_na <- cbind(dat, dat_frame)
      return(dat_with_na)
    }
  }

}
