#' @title overview_tab
#'
#' @description Provides an overview table for the time and scope conditions of
#'     a data set
#'
#' @param dat A data set object
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...)
#' @return A data frame object that contains a summary of a sample that
#'     can later be converted to a 'LaTeX' output using \code{overview_print}
#' @examples
#' data(toydata)
#' output_table <- overview_tab(dat = toydata, id = ccode, time = year)
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom dplyr ".."

overview_tab <- function(dat,
                         id,
                         time) {
  if (any(class(dat) == "data.table")) {

    # Start with the data
    id <- rlang::ensym(id)
    time <- rlang::ensym(time)

    # Check if there are NAs in the time or id variable
    # (and drop them but warn the user about it)
    if (sum(is.na(dat[[id]])) > 0) {
      warning(
        "There is a missing value in your id variable. The missing value is automatically deleted."
      )
    }

    # TODO: FIX
    dat[, ..(id, time)][!is.na(id)]

    output <- overview_tab_dt(
      dat = dat,
      id = id,
      time = time
    )

  } else {
    # Start with the data
    id <- dplyr::enquo(id)
    time <- dplyr::enquo(time)

    # Check if there are NAs in the time or id variable
    # (and drop them but warn the user about it)
    dat2 <- dat %>%
      dplyr::filter(!is.na(!!id))

    if (length(dat2) != length(dat)) {
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
