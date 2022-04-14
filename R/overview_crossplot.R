#' @title overview_crossplot
#'
#' @description This function plots a ggplot to visualize a cross table plot.
#'
#' @param dat Your data set
#' @param cond1 Variable that describes the first condition
#' @param cond2 Variable that describes the second condition
#' @param threshold1 A threshold for \code{cond1}
#' @param threshold2 A threshold for \code{cond2}
#' @param id Your scope (e.g., country codes or individual IDs). If the id
#'     variable contains NAs, they will not be included in the plot.
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @param xaxis Label of the x axis ("Condition 1" is default)
#' @param yaxis Label of the y axis ("Condition 2" is default)
#' @param label Label of the observations. Overlapping labels are
#'     avoided by using 'ggrepel'
#' @param color Color of the different observation groups
#' @return A ggplot figure that presents the sample information visually
#'     in a cross table
#' @examples
#' data(toydata)
#' overview_crossplot(
#'   dat = toydata,
#'   cond1 = gdp,
#'   cond2 = population,
#'   threshold1 = 25000,
#'   threshold2 = 27000,
#'   id = ccode,
#'   time = year
#' )
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom ggplot2 ggplot
#' @importFrom ggrepel geom_text_repel




overview_crossplot <-
  function(dat,
           id,
           time,
           cond1,
           cond2,
           threshold1,
           threshold2,
           xaxis = "Condition 1",
           yaxis = "Condition 2",
           label = FALSE,
           color = FALSE) {
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

    id <- dplyr::enquo(id)
    time <- dplyr::enquo(time)
    cond1 <- dplyr::enquo(cond1)
    cond2 <- dplyr::enquo(cond2)

    # Check the length of unique observations
    # (based on time and id) in the data set
    # We need this for the next check
    length_nodup <- dat %>%
      dplyr::distinct(!!id, !!time, .keep_all = TRUE)

    # Check if data set only has unique observations
    if (nrow(length_nodup) == nrow(dat)) {
      red <- dat %>%
        dplyr::ungroup() %>%
        dplyr::group_by(!!id, !!time) %>%
        dplyr::summarise(cond1_mean = mean(!!cond1),
                         cond2_mean = mean(!!cond2)) %>%
        dplyr::ungroup()

      cond1_mean <- red$cond1_mean
      cond1_mean <- dplyr::enquo(cond1_mean)

      cond2_mean <- red$cond2_mean
      cond2_mean <- dplyr::enquo(cond2_mean)

      dat_red <- dat %>%
        dplyr::mutate(
          c1 = ifelse(!!cond1 >= threshold1, 1, 0),
          c2 = ifelse(!!cond2 >= threshold2, 1, 0)
        ) %>%
        dplyr::group_by(c1, c2) %>%
        dplyr::select(!!id, !!time, !!cond1, !!cond2, c1, c2) %>%
        dplyr::mutate(
          quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
          quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
          quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
          quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
        ) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(grp = ifelse(quart1 == 1, 1,
                                   ifelse(
                                     quart2 == 1, 2,
                                     ifelse(quart3 == 1, 3,
                                            ifelse(quart4 == 1, 4, 0))
                                   )),
                      text = paste0(!!id, !!time))


      if (color == TRUE & label == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(
            x = !!cond1_mean,
            y = !!cond2_mean,
            label = text
          )) +
          ggplot2::geom_point(alpha = 0.5, ggplot2::aes(color = factor(grp))) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggrepel::geom_text_repel(size = 2.5) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      if (color == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(x = !!cond1_mean, y = !!cond2_mean)) +
          ggplot2::geom_point(alpha = 0.5, ggplot2::aes(color = factor(grp))) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      if (label == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(
            x = !!cond1_mean,
            y = !!cond2_mean,
            label = text
          )) +
          ggplot2::geom_point(alpha = 0.5) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggrepel::geom_text_repel(size = 2.5) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      else {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(x = !!cond1_mean, y = !!cond2_mean)) +
          ggplot2::geom_point(alpha = 0.5) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }

    }

    # If this is not the case, we need to aggregate the data
    else {
      red <- dat %>%
        dplyr::ungroup() %>%
        dplyr::group_by(!!id, !!time) %>%
        dplyr::summarise(cond1_mean = mean(!!cond1),
                         cond2_mean = mean(!!cond2)) %>%
        dplyr::ungroup()

      cond1_mean <- red$cond1_mean
      cond1_mean <- dplyr::enquo(cond1_mean)

      cond2_mean <- red$cond2_mean
      cond2_mean <- dplyr::enquo(cond2_mean)

      # Apply the code to the code above
      dat_red <- red %>%
        dplyr::mutate(
          c1 = ifelse(!!cond1_mean >= threshold1, 1, 0),
          c2 = ifelse(!!cond2_mean >= threshold2, 1, 0)
        ) %>%
        dplyr::group_by(c1, c2) %>%
        dplyr::mutate(
          quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
          quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
          quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
          quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
        ) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(grp = ifelse(quart1 == 1, 1,
                                   ifelse(
                                     quart2 == 1, 2,
                                     ifelse(quart3 == 1, 3,
                                            ifelse(quart4 == 1, 4, 0))
                                   )),
                      text = paste0(!!id, !!time))

      if (color == TRUE & label == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(
            x = !!cond1_mean,
            y = !!cond2_mean,
            label = text
          )) +
          ggplot2::geom_point(alpha = 0.5, ggplot2::aes(color = factor(grp))) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggrepel::geom_text_repel(size = 2.5) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      if (color == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(x = !!cond1_mean, y = !!cond2_mean)) +
          ggplot2::geom_point(alpha = 0.5, ggplot2::aes(color = factor(grp))) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      if (label == TRUE) {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(
            x = !!cond1_mean,
            y = !!cond2_mean,
            label = text
          )) +
          ggplot2::geom_point(alpha = 0.5) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggrepel::geom_text_repel(size = 2.5) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
      else {
        plot <- dat_red %>%
          ggplot2::ggplot(ggplot2::aes(x = !!cond1_mean, y = !!cond2_mean)) +
          ggplot2::geom_point(alpha = 0.5) +
          ggplot2::geom_vline(xintercept = threshold1) +
          ggplot2::geom_hline(yintercept = threshold2) +
          ggplot2::ylab(yaxis) +
          ggplot2::xlab(xaxis) +
          theme_plot +
          ggplot2::theme(legend.position = "none")

        return(plot)
      }
    }
  }
