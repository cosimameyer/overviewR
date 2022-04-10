.overview_tab <- function(dat = NULL,
                          id = NULL,
                          time = NULL,
                          col_names = NULL) {
  return_cols <- c(id, "time_frame")
  dat <-
    unique(unique(dat[, ..col_names])[, list(time_frame = paste(find_int_runs(get(time)), collapse = ", ")), by = get(id)])
  data.table::setnames(x = dat, old = "get", new = id)

  return(dat)

}
