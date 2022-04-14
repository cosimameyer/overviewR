#' @title theme_heat_plot
#'
#' @description Defines the theme for the `overview_heat` plot function
#'
#' @return A theme for the `overview_heat` plot
#'

theme_heat_plot <- function() {
  theme_plot <- ggplot2::theme(
    # get rid of panel grids
    axis.line = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    # Change plot and panel background
    plot.background = ggplot2::element_rect(fill = "white"),
    panel.background = ggplot2::element_rect(fill = "white"),
    # Change legend
    legend.direction = "horizontal",
    legend.position = "none",
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
    text = ggplot2::element_text(size = 8,
                                 face = "plain")

  )

  return(theme_plot)
}
