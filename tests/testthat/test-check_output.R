context("check-output")
library(testthat)
library(overviewR)

test_that("overview_tab() returns a data frame", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_is(output_table, "data.frame")
})

test_that("overview_tab() returns a dataframe with correct number of rows", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_equal(nrow(output_table), length(unique(toydata$ccode)))
})

test_that("overview_tab() works on a dataframe that is already in the correct
          format", {
            df_com <- data.frame(
              # Countries
              ccode  = c(
                rep("RWA", 4),
                rep("AGO", 8),
                rep("BEN", 2),
                rep("GBR", 5),
                rep("FRA", 3)
              ),
              # Time frame
              year =
                c(
                  seq(1990, 1995),
                  seq(1990, 1992),
                  seq(1995, 1999),
                  seq(1991, 1999, by = 2),
                  seq(1993, 1999, by = 3)
                ))
            output_table <- overview_tab(dat = df_com, id = ccode, time = year)
            expect_equal(nrow(output_table), 5)
          })

test_that("check output of overview_print", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  tex_output <- overview_print(output_table, save_out = TRUE)
  input_output <- overview_print(output_table, save_out = FALSE)
  testthat::expect_null(print(tex_output))
  testthat::expect_null(print(input_output))
})

test_that("check output of overview_print for crosstab", {
  output_cross <- overview_crosstab(dat = toydata, id = ccode, time = year,
                                    cond1 = population, cond2 = gdp,
                                    threshold1 = 27000, threshold2 = 25000)
  tex_output <- overview_print(output_cross, crosstab = TRUE, save_out = TRUE)
  input_output <- overview_print(output_cross, crosstab = TRUE,
                                 save_out = FALSE)
  testthat::expect_null(print(tex_output))
  testthat::expect_null(print(input_output))
})

test_that("Get an error message", {
  df_combined <- data.frame(
    # Countries
    countries  = c(
      rep("RWA", 4),
      rep("AGO", 8),
      rep("BEN", 2),
      rep("GBR", 5),
      rep("FRA", 3)
    ))
  expect_error(overview_print(df_combined),
  "Data frame requires two columns that represent the time and
        scope dimension of the data")
})

test_that("Get a warning message", {
  data_test <- data.frame(
    countries  = c("RWA", "BDI"),
    years = c(1990, 2000)
    )
  expect_warning(overview_print(data_test))
})

test_that("overview_crosstab() returns a data frame", {
output_crosstab <- overview_crosstab(
  dat = toydata,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 25000,
  threshold2 = 27000,
  id = ccode,
  time = year
)
expect_is(output_crosstab, "data.frame")
})

test_that("overview_crosstab() works on a dataframe that is already in the
correct format", {
            df_com <- data.frame(
              # Countries
              ccode  = c(
                rep("RWA", 4),
                rep("AGO", 8),
                rep("BEN", 2),
                rep("GBR", 5),
                rep("FRA", 3)
              ),
              # Time frame
              year =
                c(
                  seq(1990, 1993),
                  seq(1990, 1997),
                  seq(1995, 1996),
                  seq(1991, 1995),
                  seq(1993, 1999, by = 3)
                ),
              population =
                seq(1, 44, by = 2),
              gdp =
                seq(1, 44, by = 2))
            output_cross <- overview_crosstab(dat = df_com, id = ccode,
                                              time = year,
                                              cond1 = population,
                                              cond2 = gdp,
                                              threshold1 = 20,
                                              threshold2 = 10)
            expect_equal(nrow(output_cross), 2)
})
