#' @title overview_print
#'
#' @description Produces a 'LaTeX' output for output obtained via
#'    \code{overview_tab} and \code{overview_crosstab}
#'
#' @param obj Overview object produced by overview_tab or overview_crosstab
#' @param title Caption of the table (default is "Time and scope of the sample")
#' @param id The name of the left column (default is "Sample"), will be ignored
#'     if crosstab is TRUE
#' @param time The name of the right column (default is ("Time frame")), will
#'     be ignored if \code{crosstab} is TRUE
#' @param crosstab Logical argument, if TRUE produces a \code{crosstab} output,
#'     default is FALSE
#' @param cond1 Description for the first condition (character), will be
#'     ignored if \code{crosstab} is FALSE. This should correspond to the input
#'     for \code{cond1} in \code{overview_crosstab}
#' @param cond2 Description for the second condition (character), will be
#'     ignored if \code{crosstab} is FALSE. This should correspond to the input
#'     for \code{cond2} in \code{overview_crosstab}
#' @param save_out Optional argument, exports the output table as a .tex
#'     file, default is FALSE
#' @param path Specifies the path where the output should be saved
#' @param file Specifies name and file type (.tex)
#' @param label Specifies the label (default is "tab:tab1")
#' @param fontsize Specifies the font size (all 'LaTeX' font sizes such as
#'     "scriptsize" or "small" work)
#' @return A 'LaTeX' output that can either be copy-pasted in a text document or
#'     exported directed as a .tex file
#' @examples
#' data(toydata)
#'
#' overview_object <- overview_tab(dat = toydata, id = ccode, time = year)
#' overview_print(
#'   obj = overview_object,
#'   title = "Some nice title",
#'   crosstab = FALSE
#' )
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
#' overview_print(
#'   obj = overview_ct_object,
#'   title = "Some nice title for a cross tab",
#'   crosstab = TRUE,
#'   cond1 = "Name of first condition",
#'   cond2 = "Name of second condition"
#' )
#' @export overview_print overview_latex
#' @alias overview_print
#' @importFrom dplyr "%>%"


overview_latex <-
  function(obj,
           title = "Time and scope of the sample",
           id = "Sample",
           time = "Time frame",
           crosstab = FALSE,
           cond1 = "Condition 1",
           cond2 = "Condition 2",
           save_out = FALSE,
           path,
           file,
           label = "tab:tab1",
           fontsize) {
    obj <- as.matrix(obj)

    # Add a fontsize (if defined)
    if (missing(fontsize) == FALSE) {
      fontsize_mod <- paste0("\\", fontsize)
    } else {
      fontsize_mod <- ""
    }

    if (ncol(obj) != 2) {
      stop(
        "Data frame requires two columns that represent the time and
        scope dimension of the data. A overview_tab or overview_crosstab
        object is required."
      )
    }

    if (crosstab == FALSE) {
      if (nrow(obj) == 2) {
        warning(
          "Are you sure you want a table for time and scope conditions? For a
          crosstab, set option crosstab = TRUE"
        )
      }
      for (i in length(obj)) {
        begin_tab <-
          paste0(
            "% Overview table generated in ",
            version[["version.string"]],
            " using overviewR \n",
            "% Table created on ",
            as.character(Sys.Date()),
            "\n",
            "\\begin{table}[ht] \n \\centering \n \\caption{",
            title,
            "} \n",
            "\\label{",
            label,
            "} \n",
            fontsize_mod,
            "\n",
            "\\begin{tabular}{ll} \n \\hline \n",
            id,
            " & ",
            time,
            " \\\\ \\hline \n"
          )
        out <- paste0(obj[, 1], " & ", obj[, 2], " \\\\ \n")
        end_tab <-
          paste0("\\hline \n \\end{tabular} \n \\end{table} \n")
        if (save_out == FALSE) {
          cat(begin_tab, out, end_tab)
        }
        if (save_out == TRUE) {
          save_dir <- paste0(path, file)
          sink(save_dir)
          cat(begin_tab, out, end_tab)
          sink()
        }
      }
    }
    if (crosstab == TRUE) {
      for (i in length(obj)) {
        begin_crosstab <- paste0(
          "% Overview table generated in ",
          version[["version.string"]],
          " using overviewR \n",
          "% Table created on ",
          as.character(Sys.Date()),
          "\n",
          "% Please add the following packages to your document preamble: \n",
          "% \\usepackage{multirow} \n",
          "% \\usepackage{tabularx} \n",
          "% \\newcolumntype{b}{X} \n",
          "% \\newcolumntype{s}{>{\\hsize=.5\\hsize}X} \n",
          "\\begin{table}[ht] \n",
          "\\caption{",
          title,
          "} \n",
          "\\label{",
          label,
          "} \n",
          fontsize_mod,
          "\n",
          "\\begin{tabularx}{\\textwidth}{ssbb} \n",
          "\\hline & & \\multicolumn{2}{c}{\\textbf{",
          cond1,
          "}} \\\\ \n",
          " & & \\textbf{Fulfilled} & \\textbf{Not fulfilled} \\\\ ",
          "\n \\hline \\\\ \n \\multirow{2}{*}{\\textbf{",
          cond2,
          "}} & \\textbf{Fulfilled} & \n"
        )
        cross_out1 <- paste0(obj[1, 1], " & ", obj[1, 2], "\\\\ ")

        mid_crosstab <-
          paste0("\n \\\\ \\hline \\\\ \n & \\textbf{Not fulfilled} & ")

        cross_out2 <- paste0(obj[2, 1], " & ", obj[2, 2], "\\\\ ")

        end_crosstab <-
          paste0("\\hline \\\\ \n \\end{tabularx} \n \\end{table} \n")
        if (save_out == FALSE) {
          cat(
            begin_crosstab,
            cross_out1,
            mid_crosstab,
            cross_out2,
            end_crosstab
          )
        }
      }
      if (save_out == TRUE) {
        save_dir <- paste0(path, file)
        sink(save_dir)
        cat(
          begin_crosstab,
          cross_out1,
          mid_crosstab,
          cross_out2,
          end_crosstab
        )
        sink()
      }
    }
  }

overview_print <- overview_latex
