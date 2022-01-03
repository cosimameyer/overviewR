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
