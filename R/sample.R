############################################################################################
## Define functions
# 1)
# Check for consecutive numbers and collapse them with -
# From here: https://stackoverflow.com/questions/16911773/collapse-runs-of-consecutive-numbers-to-ranges
findIntRuns <- function(run){
  rundiff <- c(1, diff(run))
  difflist <- split(run, cumsum(rundiff!=1))
  unlist(lapply(difflist, function(x){
    if(length(x) %in% 1) as.character(x) else paste(x[1], "-", x[length(x)])
  }), use.names=FALSE)
}

# 2)
sample <- function(dat, id, time){
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
    #  mutate(all = paste(time, collapse=",")) %>%
    # subset it to only one distint country
    dplyr::distinct(!!id, time_frame)
  obj <<- obj_prelim
  # obj <- list("Time"=obj_prelim$time_frame,"Observation"=obj_prelim$id)
  # obj_prelim <- final_prepared %>%
  #   group_by(ccode, year) %>%
  #   #  slice(2) %>%
  #   distinct(ccode) %>%
  #   select(ccode, year) %>%
  #   group_by(ccode) %>%
  #   mutate(time_frame = paste(findIntRuns(year), collapse=", ")) %>%
  #   #  mutate(all = paste(time, collapse=",")) %>%
  #   # subset it to only one distint country
  #   distinct(ccode, time_frame)
  # obj <- list("Time"=obj_prelim$time_frame,"Country"=obj_prelim$ccode)
  # table <- flextable::flextable(obj)
  return(obj)
}
# 3) Print function
# print.table <- function(obj){
#   id <- obj$id
#   time_frame <- obj$time_frame
#   # # Stars
#   # starsfn <- function(x) {
#   #   ifelse(x<=0.001,return("***"),
#   #          ifelse(x<=0.05,return("**"),
#   #                 ifelse(x <=0.1,return("*"),return(""))) )
#   # }
#   #
#   # stars <- sapply(obj[[5]], starsfn)
#
#   cat("Sample descriptives\n=======\n\n")
#
#   res.tab <- cbind(obj[[2]], obj[[1]])
# #  rownames(res.tab) <- paste(coln,1:length(obj[[1]]))
#   colnames(res.tab) <- c("Country", "Time")
#
#   print(res.tab)
# #  return(list("coln"=coln))
#  # cat("R-squared", round(obj[[6]], 3), "\t", "adjusted R-squared", round(obj[[7]], 3))
# }

# print.table <- function(obj, type){
#   colnames(obj) <- c("Observation","Time frame")
#   if(type == latex) {
#     #  colnames(obj) <- c("Observation","Time frame")
#     print.xtable(xtable(obj,caption="Overview of sample"),
#                  caption.placement="top",
#                  bookmarks=TRUE)
#   }
#   else {
#     flextable(obj)
#   }
# }

############################################################################################
## Run everything
# Do the magic
# sample(final_prepared, id = ccode, time = year)
#
# tab(obj, type = "Observation", timeframe = "Time frame")
#
# print.table(obj, type = "Observation", timeframe = "Time frame")
# Get the table publication ready (LaTeX, Word, text, ...)

# obj_prelim %>%
#   gt()

# Add gtable to highlight most frequent parts

# Add cross tab function to categorize observations in a cross tab based on conditions
