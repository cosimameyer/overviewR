#' @title overview_tab
#'
#' @description Provides an overview table for the time and scope conditions of
#'     a data set. If a data.table object is provided, the function uses
#'     data.table's syntax to perform the evaluation
#'
#' @param dat A data frame or data table object
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...). Time can be a character vector containing multiple time variables.
#' @return A data frame object that contains a summary of a sample that
#'     can later be converted to a 'LaTeX' output using \code{overview_print}
#' @examples
#' data(toydata)
#' output_table <- overview_tab(dat = toydata, id = ccode, time = year)
#' @export
#' @importFrom dplyr "%>%"

overview_tab <- function(dat,
                         id,
                         time) {

  # # Check whether time contains multiple objects
  # if (length(time) > 0) {
  #   # If there are multiple objects, identify which object belongs to year, month, or day
  #   mapply(X = time, MoreArgs = dat, function(x) {
  #     browser()
  #     dat[, colnames(dat) == time[[1]]]
  #   })
  #   for (i in colnames(dat)) {
  #     for (j in time) {
  #       time_1 <-
  #       browser()
  #     }
  #
  #   }
  # }

  if (any(class(dat) == "data.table")) {
    # Start with the data
    id <- deparse(substitute(id))
    time <- deparse(substitute(time))
    col_names <- c(id, time)

    # Check if there are NAs in the time or id variable
    # (and drop them but warn the user about it)
    if (sum(is.na(dat[[id]])) > 0) {
      warning(
        "There is a missing value in your id variable. The missing value is automatically deleted."
      )
      dat <- dat[!is.na(get(id)), col_names, with = FALSE]
    }

    output <- overview_tab_dt(
      dat = dat,
      id = id,
      time = time,
      col_names = col_names
    )

  } else {
    # Start with the data
    id <- rlang::ensym(id)
    time <- rlang::ensym(time)

    # Check if there are NAs in the time or id variable
    # (and drop them but warn the user about it)
    dat2 <- dat %>%
      dplyr::filter(!is.na(!!id))

    if (nrow(dat2) != nrow(dat)) {
      warning(
        "There is a missing value in your id variable. The missing value is automatically deleted."
      )
    }

    output <- overview_tab_df(
      dat2 = dat2,
      dat = dat,
      id = id,
      time = time
    )
  }
  return(output)
}
