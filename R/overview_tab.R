#' Gives you a nice overview table for time and scope conditions
#'
#' @param dat Your dataset
#' @param id Your scope (e.g., country codes or individual IDs)
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @return A data frame that contains a summary of your sample and that can be easily converted to a LaTeX output
#' @examples
#' overview_tab(dat = dataset, id = country_code, time = year)

overview_tab <- function(dat, id, time){
  # Check for consecutive numbers and collapse them with -
  # From here: https://stackoverflow.com/questions/16911773/collapse-runs-of-consecutive-numbers-to-ranges  findIntRuns <- function(run){
  findIntRuns <- function(run){
    rundiff <- c(1, diff(run))
    difflist <- split(run, cumsum(rundiff!=1))
    unlist(lapply(difflist, function(x){
      if(length(x) %in% 1) as.character(x) else paste(x[1], "-", x[length(x)])
    }), use.names=FALSE)
  }

  dat <- dat
  id <- enquo(id)
  time <- enquo(time)
  #  group_var <- enquo(group_var)
  obj_prelim <- dat %>%
    dplyr::group_by(!!id, !!time) %>%
    #  slice(2) %>%
    dplyr::distinct(!!id) %>%
    dplyr::select(!!id, !!time) %>%
    dplyr::group_by(!!id) %>%
    dplyr::mutate(time_frame = paste(findIntRuns(!!time), collapse=", ")) %>%
    # subset it to only one distint country
    dplyr::distinct(!!id, time_frame)
  obj <<- obj_prelim
  return(obj)
}
