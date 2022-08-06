#' @title overview_tab_df
#'
#' @description Internal function that calculates the `overview_tab` for data.frame objects
#'
#' @param dat2 Your data set
#' @param dat Your data set
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...). There are three options to add a date variable: 1) Time can be a character vector containing **one** time variable, 2) a time variable following the YYYY-MM-DD format, or 3) or a list containing multiple time variables (`time = list(year = NULL, month = NULL, day = NULL)`).
#' @return A data.frame

overview_tab_df <- function(dat2 = NULL,
                            dat = NULL,
                            id = NULL,
                            time = NULL) {
  if (nrow(dat2) == nrow(dat)) {
    # Check the length of unique observations (based on time and id) in the
    # data set
    # We need this for the next check
    length_nodup <- dat %>%
      dplyr::distinct(!!id, !!time, .keep_all = TRUE)

    # Check if data set only has unique observations
    if (nrow(length_nodup) == nrow(dat)) {
      # Apply it to the data
      tab <- dat %>%
        # Select important variables
        dplyr::select(!!id, !!time) %>%
        # Group data
        dplyr::group_by(!!id, !!time) %>%
        # Arrange the data
        dplyr::arrange(!!id, !!time) %>%
        # Only get distinct IDs
        dplyr::distinct(!!id) %>%
        # Group by ID
        dplyr::group_by(!!id) %>%
        # Apply function generated above
        dplyr::mutate(time_frame = paste(find_int_runs(!!time),
          collapse = ", "
        )) %>%
        # Subset it to only one distinct country
        dplyr::distinct(!!id, time_frame)

      # Return object
      return(tab)
    }
    # If this is not the case, we need to aggregate the data
    else {
      dat2 <- dat %>%
        dplyr::select(!!id, !!time) %>%
        dplyr::group_by(!!id, !!time) %>%
        dplyr::distinct(!!id, !!time)

      # Apply code from above to the new data
      # Apply it to the data
      tab2 <- dat2 %>%
        # Select important variables
        dplyr::select(!!id, !!time) %>%
        # # Group data
        dplyr::group_by(!!id, !!time) %>%
        # Arrange the data
        dplyr::arrange(!!id, !!time) %>%
        # Only get distinct IDs
        dplyr::distinct(!!id) %>%
        # Group by ID
        dplyr::group_by(!!id) %>%
        # Apply function generated above
        dplyr::mutate(time_frame = paste(find_int_runs(!!time),
          collapse = ", "
        )) %>%
        # Subset it to only one distinct country
        dplyr::distinct(!!id, time_frame)

      return(tab2)
    }
  }
}
