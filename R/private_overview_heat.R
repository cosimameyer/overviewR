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
    # Generate a count
    browser()
    if (any(class(dat) == "data.table")) {
      if (perc) {
        dat_agg <- dat[, `:=`(c("count", "total"), {
          count <- .N
          total <- count/12
          .(count, total)
        }), by =  col_names]
      } else {
        dat_agg <- dat[, `:=`(count = .N), by = .(id, time)]
      }
      # TODO: This does not work yet
      # Plot the result
      plot <- dat_agg %>%
        data.table::setDF() %>%
        dplyr::ungroup() %>%
        dplyr::group_by(!!id) %>%
        ggplot2::ggplot(ggplot2::aes(factor(!!time), !!id)) +
        ggplot2::geom_tile(ggplot2::aes(fill = count), colour = "white") +
        ggplot2::scale_fill_gradient(low = col_low, high = col_high) +
        ggplot2::ylab(yaxis) +
        ggplot2::xlab(xaxis) +
        ggplot2::scale_y_discrete(limits = rev) +
        theme_plot
    } else {
     if (perc) {
      dat_agg <- dat %>%
        dplyr::group_by(!!id,!!time) %>%
        dplyr::mutate(count = dplyr::n(),
                      total = count / exp_total)
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
    }

    # If there is a label, add it
    if (label & !perc) {
      plot <- plot +
        ggplot2::geom_text(ggplot2::aes(label = round(count, 1)), size = 3.3)
    }
    if (perc) {
      plot <- plot +
        ggplot2::geom_text(ggplot2::aes(label = paste(round(100 * total, 2),
                                                      "%", sep = "")),
                           size = 3.3)
    }
    return(plot)
  }
