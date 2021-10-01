overview_tab_dt <- function(dat = NULL,
                            id = NULL,
                            time = NULL) {

  # Check if data set only has unique observations
  if (nrow(unique(dat, by = c("id", "time"))) == nrow(dat)) {
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time)

    # Return object
    return(tab)
  }
  # If this is not the case, we need to aggregate the data
  else {
    dat <- unique(dat[, .(id, time)][, .(id, time)])

    # Apply code from above to the new data
    # Apply it to the data
    tab <- .overview_tab(dat = dat,
                         id = id,
                         time = time)

    return(tab)
  }
}
