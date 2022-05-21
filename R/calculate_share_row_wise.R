#' @title calculate_share_row_wise
#'
#' @description Function used in `overview_na` to calculate the share of NA row-wise
#'
#' @param dat Data frame
#' @return The function returns a data set that has the information
#'     on the row-wise NA share

calculate_share_row_wise <- function(dat = NULL) {
  if (any(class(dat) == "data.table")) {
    dat <- data.table::copy(dat)
    dat_result <-
      dat[, list(na_count = rowSums(is.na(dat)), total = ncol(dat))][, .(na_count, total)]

    # Add rownames as variable and get the percentage
    dat_result <-
      dat_result[, list(na_count = 1:nrow(dat_result),
                        percentage = na_count / (total / 100))]

  } else {
    apply(dat, MARGIN = 1, function(x)
      sum(is.na(x)))

    dat_result <- dat %>%
      dplyr::rowwise() %>%
      dplyr::summarise(dplyr::across(dplyr::everything(), list(~sum(is.na(
        .
      ))))) %>%
      dplyr::mutate(na_count = rowSums(.),
                    total = length(colnames(.))) %>%
      dplyr::select(na_count, total)

    # Add rownames as variable
    dat_result$variable <- 1:nrow(dat_result)

    # Get percentage
    dat_result <- dat_result %>%
      dplyr::mutate(percentage = na_count / (total / 100))
  }
  return(dat_result)
}
