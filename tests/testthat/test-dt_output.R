test_that("overview_tab() returns same results regardless of using data.table or data.frame",
          {
            output_table <- overview_tab(dat = toydata, id = ccode, time = year)
            toydata <- data.table::copy(toydata)
            toydata_dt <- data.table::setDT(toydata)
            output_table2 <-
              overview_tab(dat = toydata_dt, id = ccode, time = year)
            expect_equal(nrow(output_table2), nrow(output_table))
          })

test_that("overview_na() returns same results regardless of using data.table or data.frame",
          {
            output <- overview_na(dat = toydata)
            toydata <- data.table::copy(toydata)
            toydata_dt <- data.table::setDT(toydata)
            output2 <- overview_na(dat = toydata_dt)
            testthat::expect_is(output2, "ggplot")
            testthat::expect_is(output, "ggplot")
          })
