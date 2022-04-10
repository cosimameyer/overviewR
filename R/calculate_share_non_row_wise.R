calculate_share_non_row_wise <- function(dat = NULL) {
  if (any(class(dat) == "data.table")) {
    # Generate necessary variables --------------------------------------------
    na_count <- vapply(dat, function(y)
      sum(length(which(is.na(
        y
      )))), FUN.VALUE = numeric(1))
    total <- vapply(dat, function(y)
      length(y), FUN.VALUE = numeric(1))

    dat_result <- data.table(na_count, total)

    # Add rownames as variable
    dat_result <-
      data.table::setDT(dat_result, keep.rownames = "variable")[]

    # Get percentage
    dat_result <- dat_result[, list(percentage = na_count / (total / 100))]
  } else {
    # Generate necessary variables --------------------------------------------
    na_count <- vapply(dat, function(y)
      sum(length(which(is.na(
        y
      )))), FUN.VALUE = numeric(1))
    total <- vapply(dat, function(y)
      length(y), FUN.VALUE = numeric(1))

    dat_result <- data.frame(na_count, total)
    # Add rownames as variable
    dat_result <-
      tibble::rownames_to_column(dat_result, var = "variable")
    # Get percentage
    dat_result <- dat_result %>%
      dplyr::mutate(percentage = na_count / (total / 100))
  }
  return(dat_result)
}
