# test <- overview_tab(final_prepared, ccode, year)
# test2 <- as.matrix(test)
#
#
# overview_print <-
#   function(dat, title = "Time and scope of the sample") {
#     dat <- as.matrix(dat)
#     if (ncol(dat) != 2) {
#       stop(
#         "Data frame requires two columns that represent the time and scope dimension of the data"
#       )
#     }
#     if (nrow(dat) == 2) {
#       warning(
#         "Are you sure you want a table for time and scope conditions? For a crosstab, set option crosstab = TRUE"
#       )
#     }
#     for (i in length(dat)) {
#       begin_tab <-
#         paste0(
#           "% Overview table generated in ",
#           version[['version.string']],
#           " using overviewR \n \\begin{table}[ht] \n \\centering \n \\caption{",
#           title ,
#           "} \n \\begin{tabular}{ll} \n \\hline \n" colnames(dat[,1]),  " & " colnames(dat[,2]),
#           " \\",
#           "\\hline \n"
#         )
#       out <- paste0(dat[, 1], " & ", dat[, 2], " \\", "\\\n")
#       end_tab <-
#         paste0("\\hline \n \\end{tabular} \n \\end{table} \n")
#       cat(begin_tab, out, end_tab)
#
#     }
#   }
#
# overview_print(test, title = "best table ever")
# test3 <- test2[1:2,]
# overview_print(test3)
overview_print <-
  function(dat,
           title = "Time and scope of the sample",
           crosstab = FALSE,
           cond1 = "XX",
           cond2 = "XX") {
    dat <- as.matrix(dat)

    if (ncol(dat) != 2) {
      stop(
        "Data frame requires two columns that represent the time and scope dimension of the data"
      )
    }


    if (crosstab == FALSE) {
      if (nrow(dat) == 2) {
        warning(
          "Are you sure you want a table for time and scope conditions? For a crosstab, set option crosstab = TRUE"
        )
      }
      for (i in length(dat)) {
        begin_tab <-
          paste0(
            "% Overview table generated in ",
            version[['version.string']],
            " using overviewR \n \\begin{table}[ht] \n \\centering \n \\caption{",
            title,
            "} \n \\begin{tabular}{ll} \n \\hline \n",
            colnames(dat[, 1]),
            " & ",
            colnames(dat[, 2]),
            " \\",
            "\\hline \n"
          )
        out <- paste0(dat[, 1], " & ", dat[, 2], " \\", "\\\n")
        end_tab <-
          paste0("\\hline \n \\end{tabular} \n \\end{table} \n")
        cat(begin_tab, out, end_tab)
      }
    }
    if (crosstab == TRUE) {
      for (i in length(dat)) {
        begin_crosstab <- paste0(
          "% Overview table generated in ",
          version[['version.string']],
          " using overviewR \n % Please add the following required packages to your document preamble: \n % \\usepackage{multirow} % \\usepackage{tabularx} \n
% \\newcolumntype{b}{X} \n % \\newcolumntype{s}{>{\\hsize=.5\\hsize}X} \n \\begin{table}[] \n \\begin{tabularx}{\\textwidth}{ssbb} \n \\hline & & \n \\multicolumn{2}{c}{\\textbf{",
          cond1,
          "}} \\\ ", " & & \\textbf{Fulfilled} & \n \\textbf{Not fulfilled} \\\ ",
          "\\hline \\\ \\multirow{2}{*}{\\textbf{",
          cond2,
          "}} & \\textbf{Fulfilled} & \n"
        )

        # & ", "\\\n", " & \\textbf{Not fulfilled} & & \n ", "\\ ", "\\hline \n"
        #   cond1,
        #   "}}",
        #   " \\\n",
        #   "\\multicolumn{2}{l}{} & \\textbf{Fulfilled} & \\textbf{Not fulfilled}",
        #   " \\\n",
        #   "\\hline \n \\multirow{2}{*}{\\textbf{",
        #   cond2,
        #   "}} & \\textbf{Fulfilled} & "
        # )

        cross_out1 <- paste0(dat[1, 1], " & ", dat[1, 2], "\\\ ")

        mid_crosstab <- paste0(" & \\textbf{Not fulfilled} & ")

        cross_out2 <- paste0(dat[2, 1], " & ", dat[2, 2], "\\\ ")

        end_crosstab <-
          paste0("\\hline \\\ \\end{tabularx} \n \\end{table} \n")
        cat(begin_crosstab,
            cross_out1,
            mid_crosstab,
            cross_out2,
            end_crosstab)
      }
    }
  }









#
# print.table <-  function(obj, type, timeframe, caption) {
#   colnames(obj) <- c(type, timeframe)
#   xtable::print.xtable(
#     xtable::xtable(obj, caption = caption),
#     caption.placement = "top",
#     bookmarks = TRUE,
#     include.rownames=FALSE
#   )
# }
#
# print.table(test, type = "ccode", timeframe="time_frame", caption="Overview of sample")
