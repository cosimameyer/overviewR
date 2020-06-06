#
# tab <- function(obj, type, timeframe){
#   colnames(obj) <- c(type, timeframe)
#   table <- flextable::flextable(obj)
#   return(table)
# }
#
# tab(obj, type = "Country", timeframe="Years")
# print.table <-  function(obj, type, timeframe, caption) {
#   colnames(obj) <- c(type, timeframe)
#   xtable::print.xtable(
#     xtable::xtable(obj, caption = caption),
#     caption.placement = "top",
#     bookmarks = TRUE,
#     include.rownames=FALSE
#   )
# }
# print.table(obj, type = "Country", timeframe="Years", caption="Overview of sample")
