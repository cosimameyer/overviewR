#' @title Helper function to check for date
#' @param x Date object to be checked
#'
is.Date <- function(x) {
  inherits(x, c("Date", "POSIXt"))
}


# Check for consecutive numbers and collapse them with "-"
# Inspired here: https://bit.ly/3ebZo5j
find_int_runs <- function(run = NULL) {
  rundiff <- c(1, diff(run))
  difflist <- split(run, cumsum(rundiff != 1))
  unlist(lapply(difflist, function(x) {
    if (length(x) %in% 1) {
      as.character(x)
    } else {
      paste(x[1], "-", x[length(x)])
    }
  }), use.names = FALSE)
}
