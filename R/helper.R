#' @title find_int_runs
#'
#' @description Function used in `overview_tab` to find running integers
#'
#' @param run Variable (integer) that should be checked for consecutive values
#' @return The function returns a data set

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
