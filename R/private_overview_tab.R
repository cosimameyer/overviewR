#' @title .overview_tab
#'
#' @description Internal function that calculates the `overview_tab` for data.table objects
#'
#' @param dat Your data set
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...). There are three options to add a date variable: 1) Time can be a character vector containing **one** time variable, 2) a time variable following the YYYY-MM-DD format, or 3) or a list containing multiple time variables (`time = list(year = NULL, month = NULL, day = NULL)`).
#' @param col_names The column names (containing id and time)
#' @return A data.table

.overview_tab <- function(dat = NULL,
                          id = NULL,
                          time = NULL,
                          col_names = NULL) {
  return_cols <- c(id, "time_frame")
  dat <-
    unique(unique(dat[, ..col_names])[, list(time_frame = paste(find_int_runs(get(time)), collapse = ", ")), by = get(id)])
  data.table::setnames(x = dat, old = "get", new = id)

  return(dat)

}
