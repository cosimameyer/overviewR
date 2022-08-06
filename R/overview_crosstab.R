#' @title overview_crosstab
#'
#' @description Sorts a data set conditionally in a cross table.
#'     This can be helpful to get a sense of the time and scope
#'     conditions of a data set. Note, if used with a data set that has multiple
#'     observations on the id-time unit, the function automatically aggregates
#'     this information using the mean.
#' @param dat A data set object
#' @param cond1 Variable that describes the first condition
#' @param cond2 Variable that describes the second condition
#' @param threshold1 A threshold for \code{cond1}
#' @param threshold2 A threshold for \code{cond2}
#' @param id Scope (e.g., country codes or individual IDs)
#' @param time Time (e.g., time periods given by years, months, ...)
#' @return A data frame object that contains a summary of the data set that can
#'       later be converted to a 'LaTeX' output using \code{overview_print}
#' @examples
#' data(toydata)
#' overview_crosstab(
#'   dat = toydata,
#'   cond1 = gdp,
#'   cond2 = population,
#'   threshold1 = 25000,
#'   threshold2 = 27000,
#'   id = ccode,
#'   time = year
#' )
#' @export
#' @importFrom dplyr "%>%"

overview_crosstab <-
  function(dat,
           cond1,
           cond2,
           threshold1,
           threshold2,
           id,
           time) {
    id <- dplyr::enquo(id)
    time <- dplyr::enquo(time)
    cond1 <- dplyr::enquo(cond1)
    cond2 <- dplyr::enquo(cond2)

    # Check if there are NAs in the time or id variable
    # (and drop them but warn the user about it)
    dat2 <- dat %>%
      dplyr::filter(!is.na(!!id))

    if (nrow(dat2) == nrow(dat)) {
      # Check the length of unique observations
      # (based on time and id) in the data set
      # We need this for the next check
      length_nodup <- dat %>%
        dplyr::distinct(!!id, !!time, .keep_all = TRUE)

      # Check if data set only has unique observations
      if (nrow(length_nodup) == nrow(dat)) {
        red <- dat %>%
          dplyr::mutate(
            c1 = ifelse(!!cond1 >= threshold1, 1, 0),
            c2 = ifelse(!!cond2 >= threshold2, 1, 0)
          ) %>%
          dplyr::group_by(c1, c2) %>%
          dplyr::select(!!id, !!time, !!cond1, !!cond2, c1, c2) %>%
          dplyr::mutate(
            quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
            quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
            quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
            quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
          ) %>%
          dplyr::ungroup()

        quart1 <-
          red %>%
          dplyr::filter(quart1 == 1) %>%
          dplyr::select(!!id, !!time)
        quart2 <-
          red %>%
          dplyr::filter(quart2 == 1) %>%
          dplyr::select(!!id, !!time)
        quart3 <-
          red %>%
          dplyr::filter(quart3 == 1) %>%
          dplyr::select(!!id, !!time)
        quart4 <-
          red %>%
          dplyr::filter(quart4 == 1) %>%
          dplyr::select(!!id, !!time)

        quart1_1 <- overview_tab(quart1, !!id, !!time)
        quart1_1 <- as.data.frame(quart1_1)
        part1 <-
          paste(paste0(quart1_1[, 1], " (", as.character(quart1_1[, 2]), ")"),
            collapse = ", "
          )

        quart2_1 <- overview_tab(quart2, !!id, !!time)
        quart2_1 <- as.data.frame(quart2_1)
        part2 <-
          paste(paste0(quart2_1[, 1], " (", as.character(quart2_1[, 2]), ")"),
            collapse = ", "
          )

        quart3_1 <- overview_tab(quart3, !!id, !!time)
        quart3_1 <- as.data.frame(quart3_1)
        part3 <-
          paste(paste0(quart3_1[, 1], " (", as.character(quart3_1[, 2]), ")"),
            collapse = ", "
          )

        quart4_1 <- overview_tab(quart4, !!id, !!time)
        quart4_1 <- as.data.frame(quart4_1)
        part4 <-
          paste(paste0(quart4_1[, 1], " (", as.character(quart4_1[, 2]), ")"),
            collapse = ", "
          )

        # Bring it back in a data frame structure to make it easily
        # convertible to a table
        dat1 <-
          cbind(part1, part2)
        dat2 <- cbind(part3, part4)
        crosstab <-
          data.frame(rbind(dat1, dat2))

        return(crosstab)
      }

      # If this is not the case, we need to aggregate the data
      else {
        red <- dat %>%
          dplyr::ungroup() %>%
          dplyr::group_by(!!id, !!time) %>%
          dplyr::summarise(
            cond1_mean = mean(!!cond1),
            cond2_mean = mean(!!cond2)
          ) %>%
          dplyr::ungroup()

        cond1_mean <- red$cond1_mean
        cond1_mean <- dplyr::enquo(cond1_mean)

        cond2_mean <- red$cond2_mean
        cond2_mean <- dplyr::enquo(cond2_mean)

        # Apply the code to the code above
        red <- red %>%
          dplyr::mutate(
            c1 = ifelse(!!cond1_mean >= threshold1, 1, 0),
            c2 = ifelse(!!cond2_mean >= threshold2, 1, 0)
          ) %>%
          dplyr::group_by(c1, c2) %>%
          dplyr::mutate(
            quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
            quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
            quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
            quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
          ) %>%
          dplyr::ungroup()

        quart1 <-
          red %>%
          dplyr::filter(quart1 == 1) %>%
          dplyr::select(!!id, !!time)
        quart2 <-
          red %>%
          dplyr::filter(quart2 == 1) %>%
          dplyr::select(!!id, !!time)
        quart3 <-
          red %>%
          dplyr::filter(quart3 == 1) %>%
          dplyr::select(!!id, !!time)
        quart4 <-
          red %>%
          dplyr::filter(quart4 == 1) %>%
          dplyr::select(!!id, !!time)

        quart1_1 <- overview_tab(quart1, !!id, !!time)
        quart1_1 <- as.data.frame(quart1_1)
        part1 <-
          paste(paste0(quart1_1[, 1], " (", as.character(quart1_1[, 2]), ")"),
            collapse = ", "
          )

        quart2_1 <- overview_tab(quart2, !!id, !!time)
        quart2_1 <- as.data.frame(quart2_1)
        part2 <-
          paste(paste0(quart2_1[, 1], " (", as.character(quart2_1[, 2]), ")"),
            collapse = ", "
          )

        quart3_1 <- overview_tab(quart3, !!id, !!time)
        quart3_1 <- as.data.frame(quart3_1)
        part3 <-
          paste(paste0(quart3_1[, 1], " (", as.character(quart3_1[, 2]), ")"),
            collapse = ", "
          )

        quart4_1 <- overview_tab(quart4, !!id, !!time)
        quart4_1 <- as.data.frame(quart4_1)
        part4 <-
          paste(paste0(quart4_1[, 1], " (", as.character(quart4_1[, 2]), ")"),
            collapse = ", "
          )

        # Bring it back in a data frame structure to make
        # it easily convertible to a table
        dat1 <- cbind(part1, part2)
        dat2 <- cbind(part3, part4)
        crosstab <- data.frame(rbind(dat1, dat2))

        return(crosstab)
      }
    } else {
      warning(
        "There is a missing value in your id variable. The missing value is automatically deleted."
      )

      dat <- dat %>%
        dplyr::filter(!is.na(!!id))


      # Check the length of unique observations
      # (based on time and id) in the data set
      # We need this for the next check
      length_nodup <- dat %>%
        dplyr::distinct(!!id, !!time, .keep_all = TRUE)

      # Check if data set only has unique observations
      if (nrow(length_nodup) == nrow(dat)) {
        red <- dat %>%
          dplyr::mutate(
            c1 = ifelse(!!cond1 >= threshold1, 1, 0),
            c2 = ifelse(!!cond2 >= threshold2, 1, 0)
          ) %>%
          dplyr::group_by(c1, c2) %>%
          dplyr::select(!!id, !!time, !!cond1, !!cond2, c1, c2) %>%
          dplyr::mutate(
            quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
            quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
            quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
            quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
          ) %>%
          dplyr::ungroup()

        quart1 <-
          red %>%
          dplyr::filter(quart1 == 1) %>%
          dplyr::select(!!id, !!time)
        quart2 <-
          red %>%
          dplyr::filter(quart2 == 1) %>%
          dplyr::select(!!id, !!time)
        quart3 <-
          red %>%
          dplyr::filter(quart3 == 1) %>%
          dplyr::select(!!id, !!time)
        quart4 <-
          red %>%
          dplyr::filter(quart4 == 1) %>%
          dplyr::select(!!id, !!time)

        quart1_1 <- overview_tab(quart1, !!id, !!time)
        quart1_1 <- as.data.frame(quart1_1)
        part1 <-
          paste(paste0(quart1_1[, 1], " (", as.character(quart1_1[, 2]), ")"),
            collapse = ", "
          )

        quart2_1 <- overview_tab(quart2, !!id, !!time)
        quart2_1 <- as.data.frame(quart2_1)
        part2 <-
          paste(paste0(quart2_1[, 1], " (", as.character(quart2_1[, 2]), ")"),
            collapse = ", "
          )

        quart3_1 <- overview_tab(quart3, !!id, !!time)
        quart3_1 <- as.data.frame(quart3_1)
        part3 <-
          paste(paste0(quart3_1[, 1], " (", as.character(quart3_1[, 2]), ")"),
            collapse = ", "
          )

        quart4_1 <- overview_tab(quart4, !!id, !!time)
        quart4_1 <- as.data.frame(quart4_1)
        part4 <-
          paste(paste0(quart4_1[, 1], " (", as.character(quart4_1[, 2]), ")"),
            collapse = ", "
          )

        # Bring it back in a data frame structure to make it easily
        # convertible to a table
        dat1 <-
          cbind(part1, part2)
        dat2 <- cbind(part3, part4)
        crosstab <-
          data.frame(rbind(dat1, dat2))

        return(crosstab)
      }

      # If this is not the case, we need to aggregate the data
      else {
        red <- dat %>%
          dplyr::ungroup() %>%
          dplyr::group_by(!!id, !!time) %>%
          dplyr::summarise(
            cond1_mean = mean(!!cond1),
            cond2_mean = mean(!!cond2)
          ) %>%
          dplyr::ungroup()

        cond1_mean <- red$cond1_mean
        cond1_mean <- dplyr::enquo(cond1_mean)

        cond2_mean <- red$cond2_mean
        cond2_mean <- dplyr::enquo(cond2_mean)

        # Apply the code to the code above
        red <- red %>%
          dplyr::mutate(
            c1 = ifelse(!!cond1_mean >= threshold1, 1, 0),
            c2 = ifelse(!!cond2_mean >= threshold2, 1, 0)
          ) %>%
          dplyr::group_by(c1, c2) %>%
          dplyr::mutate(
            quart1 = ifelse(c1 == 1 & c2 == 1, 1, 0),
            quart2 = ifelse(c1 == 0 & c2 == 1, 1, 0),
            quart3 = ifelse(c1 == 1 & c2 == 0, 1, 0),
            quart4 = ifelse(c1 == 0 & c2 == 0, 1, 0)
          ) %>%
          dplyr::ungroup()

        quart1 <-
          red %>%
          dplyr::filter(quart1 == 1) %>%
          dplyr::select(!!id, !!time)
        quart2 <-
          red %>%
          dplyr::filter(quart2 == 1) %>%
          dplyr::select(!!id, !!time)
        quart3 <-
          red %>%
          dplyr::filter(quart3 == 1) %>%
          dplyr::select(!!id, !!time)
        quart4 <-
          red %>%
          dplyr::filter(quart4 == 1) %>%
          dplyr::select(!!id, !!time)

        quart1_1 <- overview_tab(quart1, !!id, !!time)
        quart1_1 <- as.data.frame(quart1_1)
        part1 <-
          paste(paste0(quart1_1[, 1], " (", as.character(quart1_1[, 2]), ")"),
            collapse = ", "
          )

        quart2_1 <- overview_tab(quart2, !!id, !!time)
        quart2_1 <- as.data.frame(quart2_1)
        part2 <-
          paste(paste0(quart2_1[, 1], " (", as.character(quart2_1[, 2]), ")"),
            collapse = ", "
          )

        quart3_1 <- overview_tab(quart3, !!id, !!time)
        quart3_1 <- as.data.frame(quart3_1)
        part3 <-
          paste(paste0(quart3_1[, 1], " (", as.character(quart3_1[, 2]), ")"),
            collapse = ", "
          )

        quart4_1 <- overview_tab(quart4, !!id, !!time)
        quart4_1 <- as.data.frame(quart4_1)
        part4 <-
          paste(paste0(quart4_1[, 1], " (", as.character(quart4_1[, 2]), ")"),
            collapse = ", "
          )

        # Bring it back in a data frame structure to make
        # it easily convertible to a table
        dat1 <- cbind(part1, part2)
        dat2 <- cbind(part3, part4)
        crosstab <- data.frame(rbind(dat1, dat2))

        return(crosstab)
      }
    }
  }
