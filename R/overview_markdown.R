#' @title overview_markdown
#'
#' @description Produces a Markdown table output for objects obtained via
#'    \code{overview_tab} and \code{overview_crosstab}
#'
#' @param obj Overview object produced by \code{overview_tab} or
#'     \code{overview_crosstab}
#' @param title Optional title printed as a Markdown heading above the table.
#'     Defaults to \code{"Time and scope of the sample"}.
#' @param id The header of the left column (default is \code{"Sample"}).
#'     Ignored when \code{crosstab = TRUE}.
#' @param time The header of the right column (default is \code{"Time frame"}).
#'     Ignored when \code{crosstab = TRUE}.
#' @param crosstab Logical. If \code{TRUE} produces a cross-table output.
#'     Default is \code{FALSE}.
#' @param cond1 Label for the first condition. Ignored when
#'     \code{crosstab = FALSE}.
#' @param cond2 Label for the second condition. Ignored when
#'     \code{crosstab = FALSE}.
#' @param save_out Logical. If \code{TRUE} writes the output to a file.
#'     Default is \code{FALSE}.
#' @param file_path Path (including file name with \code{.md} extension) where
#'     the output is stored when \code{save_out = TRUE}.
#' @return Invisibly returns a character string with the Markdown table. The
#'     table is also printed to the console (unless \code{save_out = TRUE}).
#' @examples
#' data(toydata)
#'
#' overview_object <- overview_tab(dat = toydata, id = ccode, time = year)
#' overview_markdown(obj = overview_object)
#'
#' overview_ct_object <- overview_crosstab(
#'   dat = toydata,
#'   cond1 = gdp,
#'   cond2 = population,
#'   threshold1 = 25000,
#'   threshold2 = 27000,
#'   id = ccode,
#'   time = year
#' )
#' overview_markdown(
#'   obj = overview_ct_object,
#'   crosstab = TRUE,
#'   cond1 = "GDP",
#'   cond2 = "Population"
#' )
#' @export

overview_markdown <-
  function(obj,
           title = "Time and scope of the sample",
           id = "Sample",
           time = "Time frame",
           crosstab = FALSE,
           cond1 = "Condition 1",
           cond2 = "Condition 2",
           save_out = FALSE,
           file_path = "") {

    obj <- as.data.frame(obj)

    if (ncol(obj) != 2) {
      stop(
        "Data frame requires exactly two columns. ",
        "An overview_tab or overview_crosstab object is required."
      )
    }

    if (crosstab == FALSE) {
      header <- paste0("| ", id, " | ", time, " |")
      sep    <- paste0("|", strrep("-", nchar(id) + 2), "|",
                       strrep("-", nchar(time) + 2), "|")
      rows   <- paste0("| ", obj[[1]], " | ", obj[[2]], " |",
                       collapse = "\n")
      out <- paste(
        paste0("## ", title),
        header, sep, rows,
        sep = "\n"
      )
    } else {
      # 2x2 cross-table layout
      col_header <- paste0(
        "| | **", cond1, "**: Fulfilled | **", cond1, "**: Not fulfilled |"
      )
      sep <- paste0("|---|---|---|")
      row1 <- paste0(
        "| **", cond2, "**: Fulfilled | ", obj[1, 1], " | ", obj[1, 2], " |"
      )
      row2 <- paste0(
        "| **", cond2, "**: Not fulfilled | ", obj[2, 1], " | ",
        obj[2, 2], " |"
      )
      out <- paste(
        paste0("## ", title),
        col_header, sep, row1, row2,
        sep = "\n"
      )
    }

    if (save_out) {
      writeLines(out, con = file_path)
    } else {
      cat(out, "\n")
    }

    invisible(out)
  }
