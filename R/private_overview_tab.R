.overview_tab <- function(dat = NULL,
                          id = NULL,
                          time = NULL) {

  # # Start with the data
  # id <- rlang::ensym(id)
  # time <- rlang::ensym(time)

  unique(unique(dat[, .(id, time)][order(id, time)][, .(time,
                                                        id)])[, `:=` (time_frame = paste(find_int_runs(time), collapse = ", ")),
                                                              by = .(id)][, .(id, time_frame)])
}
