context("check-output")
library(testthat)
library(overviewR)

test_that("overview_tab() returns a data frame", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_is(output_table, "data.frame")
})

# test_that("overview_crosstab() returns a data frame", {
#   output_crosstab <- overview_crosstab(
#     dat = toydata,
#     cond1 = gdp,
#     cond2 = population,
#     threshold1 = 25000,
#     threshold2 = 27000,
#     id = ccode,
#     time = year)
#   expect_is(output_crosstab, "data.frame")
# })

test_that("overview_tab() returns a dataframe with the correct number of rows ", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_equal(nrow(output_table), length(unique(toydata$ccode)))
})
