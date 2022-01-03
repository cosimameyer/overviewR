calculate_share_row_wise <- function(dat = NULL) {
  if (any(class(dat) == "data.table")) {

  } else {
    dat_result <- dat %>%
      dplyr::rowwise() %>%
      dplyr::summarise(dplyr::across(dplyr::everything(), dplyr::funs(sum(is.na(
        .
      ))))) %>%
      dplyr::mutate(na_count = rowSums(.),
                    total = length(colnames(.))) %>%
      dplyr::select(na_count, total)

    # Add rownames as variable
    dat_result$variable = 1:nrow(dat_result)

    # Get percentage
    dat_result <- dat_result %>%
      dplyr::mutate(percentage = na_count / (total / 100))
  }
  return(dat_result)
}