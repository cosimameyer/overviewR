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


overview_tab <- function(dat, id, time) {
  # Check for consecutive numbers and collapse them with "-"
  # Inspired here: https://bit.ly/3ebZo5j
  find_int_runs <- function(run) {
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

  # Then start with the data
  id <- dplyr::enquo(id)
  time <- dplyr::enquo(time)

  # Check if there are NAs in the time or id variable
  # (and drop them but warn the user about it)
  dat2 <- dat %>%
    dplyr::filter(!is.na(!!id))

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
                                         collapse = ", ")) %>%
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
                                         collapse = ", ")) %>%
        # Subset it to only one distinct country
        dplyr::distinct(!!id, time_frame)

      return(tab2)
    }
  }
  else{
    warning(
      "There is a missing value in your id variable. The missing value is automatically deleted."
    )

    dat <- dat %>%
      dplyr::filter(!is.na(!!id))
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
                                         collapse = ", ")) %>%
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
                                         collapse = ", ")) %>%
        # Subset it to only one distinct country
        dplyr::distinct(!!id, time_frame)

      return(tab2)
    }
  }
}
