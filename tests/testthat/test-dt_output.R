test_that("overview_tab() returns same results regardless of using data.table or data.frame", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  toydata_dt <- data.table::setDT(toydata)
  output_table2 <- overview_tab(dat = toydata_dt, id = ccode, time = year)
  expect_equal(nrow(output_table2), nrow(output_table))
})
