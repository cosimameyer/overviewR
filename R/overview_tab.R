#' @title overview_tab
#'
#' @description This function gives you a nice overview table for time and scope conditions
#'
#' @param dat Your dataset
#' @param id Your scope (e.g., country codes or individual IDs)
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @return A data frame that contains a summary of your sample and that can be later easily converted to a LaTeX output
#' @examples
#' overview_tab(dat = dataset, id = country_code, time = year)

overview_tab <- function(dat, id, time) {
  # Generate some error messages
  if (is.null(dat)) stop('overview_tab requires a data frame')
  if (is.null(id)) stop('overview_tab requires a scope condition (e.g., countries)')
  if (is.null(time)) stop('overview_tab requires a time frame (e.g., a year variable)')

  # Check for consecutive numbers and collapse them with -
  # From here: https://stackoverflow.com/questions/16911773/collapse-runs-of-consecutive-numbers-to-ranges  findIntRuns <- function(run){
  findIntRuns <- function(run) {
    rundiff <- c(1, diff(run))
    difflist <- split(run, cumsum(rundiff != 1))
    unlist(lapply(difflist, function(x) {
      if (length(x) %in% 1)
        as.character(x)
      else
        paste(x[1], "-", x[length(x)])
    }), use.names = FALSE)
  }

  # Then start with the data
  dat <- dat
  id <- dplyr::enquo(id)
  time <- dplyr::enquo(time)

  # Apply it to the data
  obj <- dat %>%
    # Select important variables
    dplyr::select(!!id,!!time) %>%
    # # Group data
    # dplyr::group_by(!!id,!!time) %>%
    # Only get distinct IDs
    dplyr::distinct(!!id) %>%
    # Group by ID
    dplyr::group_by(!!id) %>%
    # Apply function generated above
    dplyr::mutate(time_frame = paste(findIntRuns(!!time), collapse = ", ")) %>%
    # Subset it to only one distint country
    dplyr::distinct(!!id, time_frame)

  # Return obj
  return(obj)
}
