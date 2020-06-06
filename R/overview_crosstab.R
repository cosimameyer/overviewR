#' @title overview_crosstab
#'
#' @description This function allows you sort your sample conditionally in a nice cross table. This can be helpful if you want to get a first sense of your data before digging deeper.
#' @param dat Your dataset
#' @param cond1 The variable that describes your first condition
#' @param cond2 The variable that describes your second condition
#' @param threshold1 A threshold above which your first condition is fulfilled
#' @param threshold2 A threshold above which your second condition is fulfilled
#' @param id Your scope (e.g., country codes or individual IDs)
#' @param time Your time (e.g., time periods given by years, months, ...)
#' @return A data frame that contains a summary of your sample and that can be easily converted to a LaTeX output
#' @examples
#' overview_crosstab(dat = dataset, cond1 = var1, cond2 = var2, threshold1 = 50, threshold2 = 70, id = country_code, time = year)


overview_crosstab <- function(dat, cond1, cond2, threshold1, threshold2, id, time){
  # # Generate some error messages
  # if (is.null(dat)) stop('overview_crosstab requires a data frame')
  # if (is.null(id)) stop('overview_crosstab requires a scope condition (e.g., countries)')
  # if (is.null(time)) stop('overview_crosstab requires a time frame (e.g., a year variable)')
  # if (is.null(cond1)) stop('overview_crosstab requires a conditional variable')
  # if (is.null(cond2)) stop('overview_crosstab requires a conditional variable')
  # if (is.null(threshold1) | !is.numeric(threshold1)) stop('overview_crosstab requires a threshold (numeric)')
  # if (is.null(threshold2) | !is.numeric(threshold2)) stop('overview_crosstab requires a threshold (numeric)')
  #


  id <- dplyr::enquo(id)
  time <- dplyr::enquo(time)
  cond1 <- dplyr::enquo(cond1)
  cond2 <- dplyr::enquo(cond2)

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

  quart1 <- red %>% dplyr::filter(quart1 == 1) %>% dplyr::select(!!id, !!time)
  quart2 <- red %>% dplyr::filter(quart2 == 1) %>% dplyr::select(!!id, !!time)
  quart3 <- red %>% dplyr::filter(quart3 == 1) %>% dplyr::select(!!id, !!time)
  quart4 <- red %>% dplyr::filter(quart4 == 1) %>% dplyr::select(!!id, !!time)

  quart1_1 <- overview_tab(quart1, !!id, !!time)
  quart1_1 <- as.data.frame(quart1_1)
  part1 <- paste(paste0(quart1_1[,1], " (", as.character(quart1_1[,2]), ")"), collapse=",")

  quart2_1 <- overview_tab(quart2, !!id, !!time)
  quart2_1 <- as.data.frame(quart2_1)
  part2 <- paste(paste0(quart2_1[,1], " (", as.character(quart2_1[,2]), ")"), collapse=", ")

  quart3_1 <- overview_tab(quart3, !!id, !!time)
  quart3_1 <- as.data.frame(quart3_1)
  part3 <- paste(paste0(quart3_1[,1], " (", as.character(quart3_1[,2]), ")"), collapse=", ")

  quart4_1 <- overview_tab(quart4, !!id, !!time)
  quart4_1 <- as.data.frame(quart4_1)
  part4 <<- paste(paste0(quart4_1[,1], " (", as.character(quart4_1[,2]), ")"), collapse=", ")

  # Bring it back in a data frame structure to make it easily convertible to a table
  dat1 <- cbind("Cond1 fulfilled" = part1, "Cond1 not fulfilled" = part2)
  dat2 <- cbind(part3, part4)
  crosstab <<- data.frame(rbind(dat1, dat2), row.names = c("Cond2 fulfilled", "Cond2 not fulfilled"))

  return(crosstab)
  # colnames(dat) <- c("Cond1 fulfilled", "Cond1 not fulfilled")
  # row.names(dat) <- c("Cond2 fulfilled", "Cond2 not fulfilled")
}
##############################################################################################################
#
# red <- final_prepared %>%
#   mutate(cond1 = ifelse(fshare > 20, 1, 0),
#          cond2 = ifelse(conflict == 1, 1, 0)) %>%
#   group_by(cond1, cond2) %>%
#   select(ccode, year, fshare, conflict, cond1, cond2) %>%
#   mutate(quart1 = ifelse(cond1 ==1 & cond2 == 1, 1, 0),
#          quart2 = ifelse(cond1 == 0 & cond2 == 1, 1, 0),
#          quart3 = ifelse(cond1 == 1 & cond2 == 0, 1, 0),
#          quart4 = ifelse(cond1 == 0 & cond2 == 0, 1, 0)) %>%
#   ungroup()
#
# quart1 <- red %>% filter(quart1 == 1) %>% select(ccode, year)
# quart2 <- red %>% filter(quart2 == 1) %>% select(ccode, year)
# quart3 <- red %>% filter(quart3 == 1) %>% select(ccode, year)
# quart4 <- red %>% filter(quart4 == 1) %>% select(ccode, year)
#
# quart1 <- sample(quart1, ccode, year)
# part1 <- paste(paste0(quart1$ccode, " (", quart1$time_frame, ")"), collapse=", ")
#
# quart2 <- sample(quart2, ccode, year)
# part2 <- paste(paste0(quart2$ccode, " (", quart2$time_frame, ")"), collapse=", ")
#
# quart3 <- sample(quart3, ccode, year)
# part3 <- paste(paste0(quart3$ccode, " (", quart3$time_frame, ")"), collapse=", ")
#
# quart4 <- sample(quart4, ccode, year)
# part4 <- paste(paste0(quart4$ccode, " (", quart4$time_frame, ")"), collapse=", ")
#
#
# # Bring it back in a data frame structure to make it easily convertible to a table
# dat1 <- cbind(part1, part2)
# dat2 <- cbind(part3, part4)
# dat <- data.frame(rbind(dat1, dat2))
#
# colnames(dat) <- c("Cond1 fulfilled", "Cond2 not fulfilled")
# rownames(dat) <- c("Cond2 fulfilled", "Cond2 not fulfilled")

