#' @title overview_crosstab
#'
#' @description This function allows you sort your sample conditionally in a nice cross table. This can be helpful if you want to get a first sense of your data before digging deeper. Note, if you use a data set that has multiple observations on your id-time unit, the function automatically aggregates this information using the mean.
#' @param dat Your dataset
#' @param cond1 The variable that describes your first condition
#' @param cond2 The variable that describes your second condition
#' @param threshold1 A threshold above which your first condition is fulfilled
#' @param threshold2 A threshold above which your second condition is fulfilled
#' @param id Your scope (e.g., country codes or individual IDs)
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @return A data frame that contains a summary of your sample and that can be easily converted to a LaTeX output
#' @examples
#'\dontrun{
#'
#' output_crosstab <- overview_crosstab(
#' dat = toydata,
#' cond1 = gdp,
#' cond2 = population,
#' threshold1 = 25000,
#' threshold2 = 27000,
#' id = ccode,
#' time = year)
#' }

overview_crosstab <- function(dat, cond1, cond2, threshold1, threshold2, id, time){
  # Generate some error messages
  # if (is.null(dat)) stop('overview_crosstab requires a data frame')
  # if (is.null(id)) stop('overview_crosstab requires a scope condition (e.g., countries)')
  # if (is.null(time)) stop('overview_crosstab requires a time frame (e.g., a  numeric year variable)')
  # if (is.null(cond1)) stop('overview_crosstab requires a conditional variable')
  # if (is.null(cond2)) stop('overview_crosstab requires a conditional variable')
  # if (is.null(threshold1) | !is.numeric(threshold1)) stop('overview_crosstab requires a threshold (numeric)')
  # if (is.null(threshold2) | !is.numeric(threshold2)) stop('overview_crosstab requires a threshold (numeric)')

  id <- dplyr::enquo(id)
  time <- dplyr::enquo(time)
  cond1 <- dplyr::enquo(cond1)
  cond2 <- dplyr::enquo(cond2)

  # Check the length of unique observations (based on time and id) in the dataset
  # We need this for the next check
  #length_nodup <- unique( dat[ , c("time", "id") ] )

  length_nodup <- dat %>%
    dplyr::distinct(!!time, !!id, .keep_all = T)

  # Check if data set only has unique observations
  if (nrow(length_nodup) == nrow(dat)) {
    red <- dat %>%
    dplyr::mutate(c1 = ifelse(!!cond1 >= threshold1, 1, 0),
                  c2 = ifelse(!!cond2 >= threshold2, 1, 0)) %>%
    dplyr::group_by(c1, c2) %>%
    dplyr::select(!!id, !!time, !!cond1, !!cond2, c1, c2) %>%
    dplyr::mutate(quart1 = ifelse(c1 ==1 & c2 == 1, 1, 0),
                  quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
                  quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
                  quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)) %>%
    dplyr::ungroup()

#
#   get_quarter <- function(dat, quart, value, id, time) {
#     quart_dat <-
#       dat %>% dplyr::filter(quart == value) %>% dplyr::select(!!id,!!time)
#     quart_dat_1 <- overview_tab(quart_dat, !!id, !!time)
#     quart_dat_1 <- as.data.frame(quart_dat_1)
#     part <-
#       paste(paste0(quart_dat_1[, 1], " (", as.character(quart_dat_1[, 2]), ")"), collapse =
#               ", ")
#     return(part)
#   }
#
#   red$quart1 <- dplyr::enquo(red$quart1)
#   red$quart2 <- dplyr::enquo(red$quart2)
#   red$quart3 <- dplyr::enquo(red$quart3)
#   red$quart4 <- dplyr::enquo(red$quart4)
#
#
#   part1 <- get_quarter(red, !!quart1, 1, !!id, !!time)
#   part2 <- get_quarter(red, !!quart2, 1, !!id, !!time)
#   part3 <- get_quarter(red, !!quart3, 1, !!id, !!time)
#   part4 <- get_quarter(red, !!quart4, 1, !!id, !!time)


  quart1 <- red %>% dplyr::filter(quart1 == 1) %>% dplyr::select(!!id, !!time)
  quart2 <- red %>% dplyr::filter(quart2 == 1) %>% dplyr::select(!!id, !!time)
  quart3 <- red %>% dplyr::filter(quart3 == 1) %>% dplyr::select(!!id, !!time)
  quart4 <- red %>% dplyr::filter(quart4 == 1) %>% dplyr::select(!!id, !!time)

  quart1_1 <- overviewR::overview_tab(quart1, !!id, !!time)
  quart1_1 <- as.data.frame(quart1_1)
  part1 <- paste(paste0(quart1_1[,1], " (", as.character(quart1_1[,2]), ")"), collapse=", ")

  quart2_1 <- overviewR::overview_tab(quart2, !!id, !!time)
  quart2_1 <- as.data.frame(quart2_1)
  part2 <- paste(paste0(quart2_1[,1], " (", as.character(quart2_1[,2]), ")"), collapse=", ")

  quart3_1 <- overviewR::overview_tab(quart3, !!id, !!time)
  quart3_1 <- as.data.frame(quart3_1)
  part3 <- paste(paste0(quart3_1[,1], " (", as.character(quart3_1[,2]), ")"), collapse=", ")

  quart4_1 <- overviewR::overview_tab(quart4, !!id, !!time)
  quart4_1 <- as.data.frame(quart4_1)
  part4 <- paste(paste0(quart4_1[,1], " (", as.character(quart4_1[,2]), ")"), collapse=", ")

  # Bring it back in a data frame structure to make it easily convertible to a table
  dat1 <- cbind(part1, part2) #cbind("Cond1 fulfilled" = part1, "Cond1 not fulfilled" = part2)
  dat2 <- cbind(part3, part4)
  crosstab <- data.frame(rbind(dat1, dat2)) #, row.names = c("Cond2 fulfilled", "Cond2 not fulfilled"))

  return(crosstab)}

  # If this is not the case, we need to aggregate the data
  else {
    red <- dat %>%
      dplyr::ungroup() %>%
      dplyr::group_by(!!id, !!time) %>%
      dplyr::summarise(cond1_mean = mean(!!cond1),
                       cond2_mean = mean(!!cond2)) %>%
      dplyr::ungroup()

    cond1_mean <- red$cond1_mean
    cond1_mean <- dplyr::enquo(cond1_mean)

    cond2_mean <- red$cond2_mean
    cond2_mean <- dplyr::enquo(cond2_mean)

    # Apply the code to the code above
    red <- red %>%
      dplyr::mutate(c1 = ifelse(!!cond1_mean >= threshold1, 1, 0),
                    c2 = ifelse(!!cond2_mean >= threshold2, 1, 0)) %>%
      dplyr::group_by(c1, c2) %>%
      dplyr::mutate(quart1 = ifelse(c1 ==1 & c2 == 1, 1, 0),
                    quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
                    quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
                    quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)) %>%
      dplyr::ungroup()

    quart1 <- red %>% dplyr::filter(quart1 == 1) %>% dplyr::select(!!id, !!time)
    quart2 <- red %>% dplyr::filter(quart2 == 1) %>% dplyr::select(!!id, !!time)
    quart3 <- red %>% dplyr::filter(quart3 == 1) %>% dplyr::select(!!id, !!time)
    quart4 <- red %>% dplyr::filter(quart4 == 1) %>% dplyr::select(!!id, !!time)

    quart1_1 <- overviewR::overview_tab(quart1, !!id, !!time)
    quart1_1 <- as.data.frame(quart1_1)
    part1 <- paste(paste0(quart1_1[,1], " (", as.character(quart1_1[,2]), ")"), collapse=", ")

    quart2_1 <- overviewR::overview_tab(quart2, !!id, !!time)
    quart2_1 <- as.data.frame(quart2_1)
    part2 <- paste(paste0(quart2_1[,1], " (", as.character(quart2_1[,2]), ")"), collapse=", ")

    quart3_1 <- overviewR::overview_tab(quart3, !!id, !!time)
    quart3_1 <- as.data.frame(quart3_1)
    part3 <- paste(paste0(quart3_1[,1], " (", as.character(quart3_1[,2]), ")"), collapse=", ")

    quart4_1 <- overviewR::overview_tab(quart4, !!id, !!time)
    quart4_1 <- as.data.frame(quart4_1)
    part4 <- paste(paste0(quart4_1[,1], " (", as.character(quart4_1[,2]), ")"), collapse=", ")

    # Bring it back in a data frame structure to make it easily convertible to a table
    dat1 <- cbind(part1, part2)
    dat2 <- cbind(part3, part4)
    crosstab <- data.frame(rbind(dat1, dat2))

    return(crosstab)

    }
}


