#' @title overview_plot
#'
#' @description This function plots a ggplot to visualize the distribution of
#'     scope objects across the time frame.
#'
#' @param dat Your dataset
#' @param id Your scope (e.g., country codes or individual IDs)
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @param xaxis Label of your x axis ("Time frame" is default)
#' @param yaxis Label of your y axis ("Sample" is default)
#' @return A ggplot figure that presents your sample information visually
#' @examples
#' data(toydata)
#' overview_plot(dat = toydata, id = ccode, time = year)
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom ggplot2 ggplot
overview_plot <-
  function(dat,
           id,
           time,
           xaxis = "Time frame",
           yaxis = "Sample") {
    # Start with the data
    dat <- dat
    id <- dplyr::enquo(id)
    time <- dplyr::enquo(time)

    # Create a theme for the plot
    theme_plot <- ggplot2::theme(
      # get rid of panel grids
      axis.line = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(color = "grey90",
                                                 linetype = "dashed"),
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
      text = ggplot2::element_text(
        size = 10,
        face = "plain"
      )
    )

    # Reduce data frame to distinct values and drop if observations with NA
    # in the time variable
    dat_red <- dat %>%
      dplyr::distinct(!!id, !!time) %>%
      dplyr::filter(!is.na(!!time))

    # The following code is inspired by: https://bit.ly/2CpS3B7
    dat_red <- dat_red
    dat_red <- dat_red %>%
      dplyr::mutate(idx = c(1, diff(!!time)))
    i2 <- c(1, which(dat_red$idx != 1), nrow(dat_red) + 1)
    dat_red$grp <- rep(1:length(diff(i2)), diff(i2))
    dat_red <- dat_red

    # Plot it
    plot <- dat_red %>%
      dplyr::group_by(!!id) %>%
      ggplot2::ggplot(ggplot2::aes(x = factor(!!time), y = !!id)) +
      ggplot2::geom_line(size = 1.5, ggplot2::aes(group = grp)) +
      ggplot2::geom_point(pch = 15, size = 2) +
      ggplot2::ylab(yaxis) +
      ggplot2::xlab(xaxis) +
      theme_plot

    return(plot)

  }
