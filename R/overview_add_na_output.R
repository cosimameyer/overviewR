#' @title overview_add_na_output
#'
#' @description Function used in `overview_na` to generate a new data frame with
#'     na_count and percentage share of NAs for each row
#'
#' @param dat_result Data.frame from `overview_na`
#' @param dat Data frame
#' @return The function returns a data set that has the information
#'     on the row-wise NA share

overview_add_na_output <- function(dat_result = NULL, dat = NULL) {
  if (any(class(dat) == "data.table")) {
    dat_result <- dat_result[, .(na_count, percentage)]
    dat_with_na <- cbind(dat, dat_result)
    return(dat_with_na)
  } else {
    dat_result <- dat_result %>%
      dplyr::select(na_count, percentage)
    dat_with_na <- cbind(dat, dat_result)
    return(dat_with_na)
  }
}
