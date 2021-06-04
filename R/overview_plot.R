#' @title overview_plot
#'
#' @description This function plots a ggplot to visualize the distribution of
#'     scope objects across the time frame.
#'
#' @param dat Your data set
#' @param id Your scope (e.g., country codes or individual IDs). If the id
#'     variable contains NAs, they will not be included in the plot.
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @param xaxis Label of the x axis ("Time frame" is default)
#' @param yaxis Label of the y axis ("Sample" is default)
#' @param asc Sorting the y axis in ascending order ("TRUE" is default)
#' @param color Optional argument that defines the color
#' @param dot_size Option argument that defines the dot size (default is 2)
#' @return A ggplot figure that presents the sample information visually
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
           yaxis = "Sample",
           asc = TRUE,
           color,
           dot_size = 2) {
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
      legend.position = "bottom",
      legend.background = ggplot2::element_rect(fill = "white", color = NA),
      legend.key = ggplot2::element_rect(color = "white", fill = "white"),
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

    # First: Evaluate whether we have a color argument given or not
    if (missing(color) == TRUE) {
      # Start with the data
      dat <- dat
      id <- dplyr::enquo(id)
      time <- dplyr::enquo(time)

      # Reduce data frame to distinct values and drop if observations with NA
      # in the time variable and id variable
      # We further ungroup any grouping before continuing
      dat_red <- dat %>%
        dplyr::ungroup() %>%
        dplyr::distinct(!!id, !!time) %>%
        dplyr::filter(!is.na(!!id)) %>%
        dplyr::filter(!is.na(!!time)) %>%
        dplyr::arrange(!!id, !!time)
      # The following code is inspired by: https://bit.ly/2CpS3B7
      dat_red <- dat_red
      dat_red <- dat_red %>%
        dplyr::mutate(idx = c(1, diff(!!time)))
      i2 <- c(1, which(dat_red$idx != 1), nrow(dat_red) + 1)
      dat_red$grp <- rep(seq_len(length(diff(i2))), diff(i2))

      # Adjust the plot where needed (trailing NA and leading NAs for instance)
      dat_red <-
        dat_red %>% dplyr::mutate(
          grp = ifelse(dplyr::lead(!!id) !=
                         !!id &
                         dplyr::lead(idx) == 1, idx + 1, grp),
          grp = ifelse(
            is.na(grp) &
              dplyr::lag(!!id) == !!id & idx == 1,
            dplyr::lag(grp),
            grp
          ),
          grp = ifelse(
            is.na(grp) &
              !!id == dplyr::lead(!!id),
            dplyr::lag(grp),
            grp
          )
        )

      dat_red <- dat_red

      # Plot it
      if (asc == TRUE) {
        plot <- dat_red %>%
          dplyr::group_by(!!id) %>%
          ggplot2::ggplot(ggplot2::aes(x = factor(!!time), y = !!id)) +
          ggplot2::geom_line(size = 1.5, ggplot2::aes(group = grp)) +
          ggplot2::geom_point(pch = 15, size = dot_size) +
          # ggplot2::scale_color_manual(factor(!!color)) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          ggplot2::scale_y_discrete(limits = rev) +
          theme_plot

        return(plot)
      }
      else {
        plot <- dat_red %>%
          dplyr::group_by(!!id) %>%
          ggplot2::ggplot(ggplot2::aes(x = factor(!!time), y = !!id)) +
          ggplot2::geom_line(size = 1.5, ggplot2::aes(group = grp)) +
          ggplot2::geom_point(pch = 15, size = 2) +
          #ggplot2::scale_color_manual() +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot

        return(plot)
      }
    }
    else {
      # Start with the data
      dat <- dat
      id <- dplyr::enquo(id)
      time <- dplyr::enquo(time)
      color <- dplyr::enquo(color)

      # Reduce data frame to distinct values and drop if observations with NA
      # in the time variable and id variable
      # We further ungroup any grouping before continuing
      dat_red <- dat %>%
        dplyr::ungroup() %>%
        dplyr::distinct(!!id, !!time, !!color) %>%
        dplyr::filter(!is.na(!!id)) %>%
        dplyr::filter(!is.na(!!time)) %>%
        dplyr::arrange(!!id, !!time, !!color)
      # The following code is inspired by: https://bit.ly/2CpS3B7
      dat_red <- dat_red
      dat_red <- dat_red %>%
        dplyr::mutate(idx = c(1, diff(!!time)))
      i2 <- c(1, which(dat_red$idx != 1), nrow(dat_red) + 1)
      dat_red$grp <- rep(seq_len(length(diff(i2))), diff(i2))

      # Adjust the plot where needed (trailing NA and leading NAs for instance)
      dat_red <-
        dat_red %>% dplyr::mutate(
          grp = ifelse(dplyr::lead(!!id) !=
                         !!id &
                         dplyr::lead(idx) == 1, idx + 1, grp),
          grp = ifelse(
            is.na(grp) &
              dplyr::lag(!!id) == !!id & idx == 1,
            dplyr::lag(grp),
            grp
          ),
          grp = ifelse(
            is.na(grp) &
              !!id == dplyr::lead(!!id),
            dplyr::lag(grp),
            grp
          )
        )

      dat_red <- dat_red

      # Plot it
      if (asc == TRUE) {
        plot <- dat_red %>%
          dplyr::group_by(!!id) %>%
          ggplot2::ggplot(ggplot2::aes(
            x = factor(!!time),
            y = !!id,
            col = factor(!!color)
          )) +
          ggplot2::geom_line(size = 1.5, ggplot2::aes(group = grp)) +
          ggplot2::geom_point(pch = 15, size = dot_size) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          ggplot2::scale_y_discrete(limits = rev) +
          theme_plot

        return(plot)
      }
      else {
        plot <- dat_red %>%
          dplyr::group_by(!!id) %>%
          ggplot2::ggplot(ggplot2::aes(
            x = factor(!!time),
            y = !!id,
            col = factor(!!color)
          )) +
          ggplot2::geom_line(size = 1.5, ggplot2::aes(group = grp)) +
          ggplot2::geom_point(pch = 15, size = 2) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot

        return(plot)
      }
    }
  }
