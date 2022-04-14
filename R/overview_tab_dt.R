#' @title overview_tab_dt
#'
#' @description Internal function that calculates the `overview_tab` for data.table objects
#'
#' @param dat Your data set
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...). There are three options to add a date variable: 1) Time can be a character vector containing **one** time variable, 2) a time variable following the YYYY-MM-DD format, or 3) or a list containing multiple time variables (`time = list(year = NULL, month = NULL, day = NULL)`).
#' @param col_names The column names (containing id and time)
#' @return A data.table

overview_tab_dt <- function(dat = NULL,
                            id = NULL,
                            time = NULL,
                            col_names = NULL) {

  # Check if data set only has unique observations
  if (nrow(unique(dat, by = c(id, time))) == nrow(dat)) {
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time,
                         col_names = col_names)

    # Return object
    return(tab)
  }
  # If this is not the case, we need to aggregate the data
  else {
    dat <- unique(dat[, ..col_names])

    # Apply code from above to the new data
    # Apply it to the data
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time,
                         col_names = col_names)

    return(tab)
  }
}
