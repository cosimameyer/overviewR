#' @title overview_tab
#'
#' @description Provides an overview table for the time and scope conditions of
#'     a data set. If a data.table object is provided, the function uses
#'     data.table's syntax to perform the evaluation
#'
#' @param dat A data frame or data table object
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...). There are three options to add a date variable: 1) Time can be a character vector containing **one** time variable, 2) a time variable following the YYYY-MM-DD format, or 3) or a list containing multiple time variables (`time = list(year = NULL, month = NULL, day = NULL)`).
#' @param complex_date Boolean argument identifying if there is a more complex (list-wise) date_time parameter (FALSE is the default)
#' @return A data frame object that contains a summary of a sample that
#'     can later be converted to a 'LaTeX' output using \code{overview_print}
#' @examples
#' # With version 1 (and also 2):
#'
#' data(toydata)
#' output_table <- overview_tab(dat = toydata, id = ccode, time = year)
#'
#' # With version 3:
#' overview_tab(dat = toydata, id = ccode, time = list(year = toydata$year,
#'              month = toydata$month, day = toydata$day), complex_date = TRUE)
#'
#' @export
#' @importFrom dplyr "%>%"
#' @importFrom rlang :=


overview_tab <- function(dat,
                         id,
                         time = list(year = NULL, month = NULL, day = NULL),
                         complex_date = FALSE) {


  # Check whether time contains multiple objects
  if (complex_date) {
    # Identify non-empty objects
    time <- time[lapply(time, length) > 0]

    if(is.null(time$day)) {
      stop(
        "The current version requires a day if you are providing multiple time arguments. Please also add a `day` in `time = list(year = ..., month = ..., day = ...)`."
      )
    }
    # If month object is a character, convert it into numbers
    if (!is.null(time$month) & !is.numeric(time$month)) {
      date <- paste(time$year, time$month, time$day, sep = "-")

      # if (any(grepl("-$", date))) {
      #   date <- gsub("-$", replacement = "", date)
      # } else if (any(grepl("--$", date))) {
      #   date <- gsub("--$", replacement = "", date)
      # }

      # Convert a possible non-numeric month to a numeric month
      if (!is.null(time$year) &
          !is.null(time$month) & !is.null(time$day)) {
        dat$date_time <-
          as.Date(strftime(as.POSIXlt(date, format = "%Y-%b-%d")))
      }

    }
  }

  if (any(class(dat) == "data.table")) {
    # Start with the data
    if (!complex_date) {
      time <- deparse(substitute(time))
    } else {
      time <- deparse(substitute(date_time))
    }
    id <- deparse(substitute(id))
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
    if (!complex_date) {
      time <- rlang::ensym(time)
    } else {
      time <- "date_time"
      time <- rlang::ensym(time)
    }
    id <- rlang::ensym(id)


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
