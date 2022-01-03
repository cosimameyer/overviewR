
overview_tab_dt <- function(dat = NULL,
                            id = NULL,
                            time = NULL,
                            col_names = NULL) {

  # Check if data set only has unique observations
  if (nrow(unique(dat, by = c(id, time))) == nrow(dat)) {
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time,
                         col_names = col_names)

    # Return object
    return(tab)
  }
  # If this is not the case, we need to aggregate the data
  else {
    dat <- unique(dat[, ..col_names])

    # Apply code from above to the new data
    # Apply it to the data
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time,
                         col_names = col_names)

    return(tab)
  }
}
