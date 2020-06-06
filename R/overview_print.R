#' @title overview_print
#'
#' @description This function produces a LaTeX for both overview_tab and overview_crosstab
#'
#' @param obj Your overview object produced by overview_tab or overview_crosstab
#' @param title Title of your table (default is "Time and scope of the sample")
#' @param crosstab Logical argument, if TRUE produces a crosstab output, default is FALSE
#' @param cond1 Description for your first condition (character), will be ignored if crosstab is FALSE
#' @param cond2 Description for your second condition (character), will be ignored if crosstab is FALSE
#' @param save_out This is an optional argument that exports your table as .tex file, default is FALSE
#' @return A LaTeX output that you can copy and paste in your text document
#' @examples
#' \dontrun{
#' overview_print(obj = overview_object, title = "Some nice title", crosstab = FALSE)
#' overview_print(obj = overview_ct_object, title = "Some nice title for a cross tab", crosstab = TRUE, cond1 = "Name of first condition", cond2 = "Name of second condition")
#' }

overview_print <-
  function(obj,
           title = "Time and scope of the sample",
           crosstab = FALSE,
           cond1 = "Condition 1",
           cond2 = "Condition 2",
           save_out = FALSE) {
    obj <- as.matrix(obj)

    if (ncol(obj) != 2) {
      stop(
        "Data frame requires two columns that represent the time and scope dimension of the data"
      )
    }


    if (crosstab == FALSE) {
      if (nrow(obj) == 2) {
        warning(
          "Are you sure you want a table for time and scope conditions? For a crosstab, set option crosstab = TRUE"
        )
      }
      for (i in length(obj)) {
        begin_tab <-
          paste0(
            "% Overview table generated in ",
            version[['version.string']],
            " using overviewR \n \\begin{table}[ht] \n \\centering \n \\caption{",
            title,
            "} \n \\begin{tabular}{ll} \n \\hline \n",
            colnames(obj[, 1]),
            " & ",
            colnames(obj[, 2]),
            " \\\\ ",
            "\\hline \n"
          )
        out <- paste0(obj[, 1], " & ", obj[, 2], " \\\\")
        end_tab <-
          paste0("\\hline \n \\end{tabular} \n \\end{table} \n")
        output <- cat(begin_tab, out, end_tab)
        if (save_out == TRUE) {
          save(output, file = "overviewR_table.tex")
        }
      }
    }
    if (crosstab == TRUE) {
      for (i in length(obj)) {
        begin_crosstab <- paste0(
          "% Overview table generated in ",
          version[['version.string']],
          " using overviewR \n % Please add the following required packages to your document preamble: \n % \\usepackage{multirow} % \\usepackage{tabularx} \n
% \\newcolumntype{b}{X} \n % \\newcolumntype{s}{>{\\hsize=.5\\hsize}X} \n \\begin{table}[] \n \\begin{tabularx}{\\textwidth}{ssbb} \n \\hline & & \n \\multicolumn{2}{c}{\\textbf{",
          cond1,
          "}} \\\\ ",
          " & & \\textbf{Fulfilled} & \n \\textbf{Not fulfilled} \\\\ ",
          "\\hline \\\\ \\multirow{2}{*}{\\textbf{",
          cond2,
          "}} & \\textbf{Fulfilled} & \n"
        )
        cross_out1 <- paste0(obj[1, 1], " & ", obj[1, 2], "\\\\ ")

        mid_crosstab <-
          paste0("\\\\ \\hline \\\\ & \\textbf{Not fulfilled} & ")

        cross_out2 <- paste0(obj[2, 1], " & ", obj[2, 2], "\\\\ ")

        end_crosstab <-
          paste0("\\hline \\\\ \\end{tabularx} \n \\end{table} \n")
        output <- cat(begin_crosstab,
                      cross_out1,
                      mid_crosstab,
                      cross_out2,
                      end_crosstab)
        if (save_out == TRUE) {
          save(output, file = "overviewR_crosstab.tex")
        }
      }
    }
  }
