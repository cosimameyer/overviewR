#' @title overview_overlap
#'
#' @description Provides an overview of the overlap of two data sets
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
#' @param dat1_name Name of dat2 ("Data set 2" is the default)
#' @param plot_type Type of plot ("bar" and "venn" are the two options) "venn"
#'     relies on the ggvenn function
#' @return A ggplot2 object (bar chart) that shows the overlap of two data sets.
#' @examples
#' data(toydata)
#' toydata2 <- toydata %>% dplyr::filter(year>1992)
#' overview_overlap(toydata, toydata2, ccode, ccode)
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

    # General preparations
    dat1 <- dat1
    dat2 <- dat2
    dat1_id <- dplyr::enquo(dat1_id)
    dat2_id <- dplyr::enquo(dat2_id)
    dat1_name <- dplyr::enquo(dat1_name)
    dat2_name <- dplyr::enquo(dat2_name)


    if(plot_type=="bar") {
    # Prepare the data for merging
    dat1_final <- dat1 %>%
      # Subset it to the ID
      dplyr::select(!!dat1_id) %>%
      # Group by ID
      group_by(!!dat1_id) %>%
      # Count occurences of each ID
      count() %>%
      # Rename the count variable
      dplyr::rename(count = n)

    dat2_final <- dat2 %>%
      # Subset it to the ID
      dplyr::select(!!dat2_id) %>%
      # Group by ID
      group_by(!!dat2_id) %>%
      # Count occurences of each ID
      count() %>%
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
      group_by(!!dat1_id) %>%
      ggplot2::ggplot(ggplot2::aes(x = !!dat1_id, y = value, fill = count)) +
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
      dat1_sub <- dat1 %>% dplyr::select(!!dat1_id) %>% sapply(as.character) %>% as.vector
      dat2_sub <- dat2 %>% dplyr::select(!!dat2_id) %>% sapply(as.character) %>% as.vector

      # Generate a list
      x <- list(
        `Data set 1` = dat1_sub,
        `Data set 2` = dat2_sub
      )

      # Plot list
      plot <- ggvenn::ggvenn(
        x,
        fill_color = c("#dceaf2", "#2A5773"),
        stroke_size = 0.5, set_name_size = 5
      )
      return(plot)
    }
  }
#
# # toydata_cc <- toydata$ccode
# # toydata2_cc <- toydata2$ccode
# # venn.diagram(
# #   x = list(toydata_cc, toydata2_cc),
# #   category.names = c("Set 1" , "Set 2 " ),
# #   filename = '#14_venn_diagramm.png',
# #   output=TRUE
# # )
#
# dat1_sub <- toydata %>% .$ccode # dat1$dat1_id #
# dat2_sub <- toydata2 %>% .$ccode # dat1$dat1_id #
# dat2_sub <- toydata2 %>% dplyr::select(ccode) %>% data.frame()# dat1$dat1_id #
# #      dat2_sub <- dat2$dat2_id # %>% dplyr::select(!!dat2_id)
#
# dat1_sub <- toydata$ccode
# dat2_sub <- toydata2$ccode
# # Generate a list
# x <- list(
#   `Data set 1` = dat1_sub,
#   `Data set 2` = dat2_sub
# )
