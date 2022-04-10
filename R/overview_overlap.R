#' @title overview_overlap
#'
#' @description Provides an overview of the overlap of two data sets.
#'     Cautionary note: This function is currently only preliminary workable
#'     and can only capture 2 data sets. We are working on an extension that
#'     allows to compare multiple data sets.
#'
#' @param dat1 A first data set object
#' @param dat2 A second data set object
#' @param dat1_id Scope (e.g., country codes or individual IDs) of dat1.
#'     It is important that both ID variables are exactly the same to generate
#'     the perfect match.
#' @param dat2_id Scope (e.g., country codes or individual IDs) of dat2.
#'     It is important that both ID variables are exactly the same to generate
#'     the perfect match.
#' @param dat1_name Name of dat1 ("Data set 1" is the default)
#' @param dat2_name Name of dat2 ("Data set 2" is the default)
#' @param plot_type Type of plot ("bar" and "venn" are the two options) "venn"
#'     relies on the ggvenn function
#' @return A ggplot2 object (bar chart) that shows the overlap of two data sets.
#' @examples
#' \dontrun{
#' data(toydata)
#' toydata2 <- toydata[which(toydata$year > 1992), ]
#' overview_overlap(dat1 = toydata, dat2 = toydata2, dat1_id = ccode,
#'                  dat2_id = ccode)
#' }
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom ggplot2 ggplot
#' @importFrom ggvenn ggvenn

overview_overlap <-
  function(dat1,
           dat2,
           dat1_id,
           dat2_id,
           dat1_name = "Data set 1",
           dat2_name = "Data set 2",
           plot_type = "bar") {
    dat1 <- dat1
    dat2 <- dat2
    dat1_id <- dplyr::enquo(dat1_id)
    dat2_id <- dplyr::enquo(dat2_id)

    if (plot_type == "bar") {
      dat1_final <- dat1 %>%
        # Subset it to the ID
        dplyr::select(!!dat1_id) %>%
        # Group by ID
        dplyr::group_by(!!dat1_id) %>%
        # Count occurences of each ID
        dplyr::count() %>%
        # Rename the count variable
        dplyr::rename(count = n)

      dat2_final <- dat2 %>%
        # Subset it to the ID
        dplyr::select(!!dat2_id) %>%
        # Group by ID
        dplyr::group_by(!!dat2_id) %>%
        # Count occurences of each ID
        dplyr::count() %>%
        # Rename the count variable
        dplyr::rename(count2 = n)

      # Merge both data sets to get a better idea of the overlap
      subset <-
        # Join both data sets
        dplyr::full_join(
          x = dat1_final,
          y = dat2_final,
          by.x = !!dat1_id,
          by.y = !!dat2_id,
          all = TRUE
        )

      # Plot it
      plot <- subset %>%
        tidyr::pivot_longer(count:count2, names_to = "count") %>%
        dplyr::group_by(!!dat1_id) %>%
        ggplot2::ggplot(ggplot2::aes(
          x = !!dat1_id,
          y = value,
          fill = count
        )) +
        ggplot2::geom_bar(stat = "identity",
                          width = .5,
                          position = "dodge") +
        ggplot2::scale_fill_grey(
          name = "Data set",
          breaks = c("count", "count2"),
          labels = c(dat1_name, dat2_name)
        ) +
        ggplot2::theme_classic() +
        ggplot2::xlab("Identifier") +
        ggplot2::ylab("Count (absolute number of observations)") +
        ggplot2::ggtitle("Overlap of data sets")

      # Return plot
      return(plot)
    }
    if (plot_type == "venn") {
      # Subset the id to a vector
      dat1_sub <-
        dat1 %>% dplyr::select(!!dat1_id) %>% as.character %>% as.vector
      dat2_sub <-
        dat2 %>% dplyr::select(!!dat2_id) %>% as.character %>% as.vector

      # Generate a list
      x <- list(`Data set 1` = dat1_sub,
                `Data set 2` = dat2_sub)

      # Plot list
      plot <- ggvenn::ggvenn(
        x,
        fill_color = c("#dceaf2", "#2A5773"),
        stroke_size = 0.5,
        set_name_size = 5
      )
      return(plot)
    }
  }
