test_that("overview_tab() returns same results regardless of using
          data.table or data.frame",
          {
            output_table <- overview_tab(dat = toydata, id = ccode, time = year)
            toydata_copy <- data.table::copy(toydata)
            toydata_dt <- data.table::setDT(toydata_copy)
            output_table2 <-
              overview_tab(dat = toydata_dt, id = ccode, time = year)
            expect_equal(nrow(output_table2), nrow(output_table))
          })

test_that("overview_tab() returns same results regardless of using
          data.table or data.frame",
          {
            toydata_no_dup <-
              toydata %>% dplyr::select(ccode, year) %>%  dplyr::group_by(ccode, year) %>% dplyr::distinct()
            output_table <-
              overview_tab(dat = toydata_no_dup, id = ccode, time = year)
            toydata_no_dup_copy <- data.table::copy(toydata_no_dup)
            toydata_dt <- data.table::setDT(toydata_no_dup_copy)
            output_table2 <-
              overview_tab(dat = toydata_dt, id = ccode, time = year)
            expect_equal(nrow(output_table2), nrow(output_table))
          })

test_that("overview_na() returns same results regardless of using data.table
          or data.frame",
          {
            output <- overview_na(dat = toydata)
            toydata_copy <- data.table::copy(toydata)
            toydata_dt <- data.table::setDT(toydata_copy)
            output2 <- overview_na(dat = toydata_dt)
            testthat::expect_is(output2, "ggplot")
            testthat::expect_is(output, "ggplot")
          })

test_that(
  "overview_na() returns same results regardless of using data.table
          or data.frame (row_wise=TRUE)",
  {
    output <- overview_na(dat = toydata, row_wise =  TRUE)
    toydata_copy <- data.table::copy(toydata)
    toydata_dt <- data.table::setDT(toydata_copy)
    output2 <-
      overview_na(dat = toydata_dt, row_wise =  TRUE)
    testthat::expect_is(output2, "ggplot")
    testthat::expect_is(output, "ggplot")
  }
)

test_that(
  "overview_na() returns same results regardless of using data.table
          or data.frame (add=TRUE)",
  {
    output <- overview_na(dat = toydata, row_wise = TRUE, add = TRUE)
    toydata_copy <- data.table::copy(toydata)
    toydata_dt <- data.table::setDT(toydata_copy)
    output2 <-
      overview_na(dat = toydata_dt, row_wise = TRUE, add =  TRUE)
    testthat::expect_is(output2, "data.frame")
    testthat::expect_is(output, "data.frame")
  }
)

test_that("check output of overview_heat with dt", {
  toydata_copy <- data.table::copy(toydata)
  toydata_dt <- data.table::setDT(toydata_copy)

  plot_heat <-
    overview_heat(toydata_dt,
                  ccode,
                  year,
                  perc = TRUE,
                  exp_total = 12)
  testthat::expect_is(plot_heat, "ggplot")
  plot_heat_abs <-
    overview_heat(toydata_dt, ccode, year, perc = FALSE)
  testthat::expect_is(plot_heat_abs, "ggplot")
})

test_that("for complex_date in overview_tab", {
  toydata_copy <- data.table::copy(toydata)
  toydata_dt <- data.table::setDT(toydata_copy)

  output_table <-
    overview_tab(
      dat = toydata,
      id = ccode,
      time = list(
        year = toydata$year,
        month = toydata$month,
        day = toydata$day
      ),
      complex_date = TRUE
    )
  output_table2 <-
    overview_tab(
      dat = toydata_dt,
      id = ccode,
      time = list(
        year = toydata_dt$year,
        month = toydata_dt$month,
        day = toydata_dt$day
      ),
      complex_date = TRUE
    )
  expect_equal(nrow(output_table2), nrow(output_table))

})


test_that("Get a warning message from overview_tab", {
  data_test <- toydata %>%
    dplyr::mutate(ccode = ifelse(ccode == "RWA", NA, ccode))

  toydata_copy <- data.table::copy(data_test)
  toydata_dt <- data.table::setDT(toydata_copy)

  expect_warning(
      overview_tab(dat = toydata_dt, id = ccode, time = year)
  )
})

