context("check-output")
library(testthat)
library(overviewR)


test_that("overview_tab() returns a data frame", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_is(output_table, "data.frame")

  output_table_complex <-
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
  expect_is(output_table_complex, "data.frame")
})

test_that("overview_tab() returns a dataframe with correct number of rows", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  expect_equal(nrow(output_table), length(unique(toydata$ccode)))
})

test_that("overview_tab() returns a dataframe with correct number of rows
          if there are duplicates", {
  data_test <- data.frame(
    ccode = c("RWA", "RWA", "BDI"),
    year = c(1990, 1990, 2000)
  )
  output_table <-
    overview_tab(dat = data_test, id = ccode, time = year)
  expect_is(output_table, "data.frame")
})

test_that("overview_tab() works on a dataframe that is already in the correct
          format", {
  df_com <- data.frame(
    # Countries
    ccode = c(
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
      )
  )
  output_table <-
    overview_tab(dat = df_com, id = ccode, time = year)
  expect_equal(nrow(output_table), 5)
})


test_that("Get a warning message from overview_tab", {
  data_test <- data.frame(
    countries = c("RWA", NA, NA),
    years = c(1990, 2000, 2001)
  )
  expect_warning(overview_tab(data_test, id = countries, time = years))
})


test_that("check output of overview_print", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  input_output <- overview_print(output_table, save_out = FALSE)
  testthat::expect_null(print(input_output))
})

test_that("check output of overview_print with font size", {
  output_table <- overview_tab(dat = toydata, id = ccode, time = year)
  input_output <-
    overview_print(output_table, save_out = FALSE, fontsize = "small")
  testthat::expect_null(print(input_output))
})

test_that("check output of overview_print with save_out", {
  testthat::skip_on_cran()
  output_table <-
    overview_tab(dat = toydata, id = ccode, time = year)
  temp <- tempfile()
  on.exit(unlink(temp), add = TRUE)
  tex_output <-
    overview_print(output_table,
      save_out = TRUE,
      path = temp,
      file = "output.tex"
    )
  testthat::expect_null(print(tex_output))
})

test_that("check output of overview_print for crosstab", {
  output_cross <-
    overview_crosstab(
      dat = toydata,
      id = ccode,
      time = year,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 27000,
      threshold2 = 25000
    )
  input_output <- overview_print(output_cross,
    crosstab = TRUE,
    save_out = FALSE
  )
  testthat::expect_null(print(input_output))
})

test_that("check output of overview_print for crosstab with unique ids", {
  modified <- toydata %>%
    dplyr::ungroup() %>%
    dplyr::group_by(ccode, year) %>%
    dplyr::summarise(
      population = mean(population, na.rm = TRUE),
      gdp = mean(gdp, na.rm = TRUE)
    ) %>%
    dplyr::ungroup()

  output_cross <-
    overview_crosstab(
      dat = modified,
      id = ccode,
      time = year,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 27000,
      threshold2 = 25000
    )
  input_output <- overview_print(output_cross,
    crosstab = TRUE,
    save_out = FALSE
  )
  testthat::expect_null(print(input_output))
})

test_that("check output of overview_print for crosstab with save_out", {
  testthat::skip_on_cran()
  output_cross <-
    overview_crosstab(
      dat = toydata,
      id = ccode,
      time = year,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 27000,
      threshold2 = 25000
    )
  temp <- tempfile()
  on.exit(unlink(temp), add = TRUE)
  tex_output <-
    overview_print(
      output_cross,
      crosstab = TRUE,
      save_out = TRUE,
      path = temp,
      file = "output.tex"
    )
  testthat::expect_null(print(tex_output))
})


test_that("Get a warning message from overview_crosstab", {
  testthat::skip_on_cran()
  data_test <- toydata %>%
    dplyr::mutate(ccode = ifelse(ccode == "RWA", NA, ccode))
  expect_warning(
    overview_crosstab(
      data_test,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 27000,
      threshold2 = 25000,
      id = ccode,
      time = year
    )
  )
})

test_that("Get an error message", {
  df_combined <- data.frame( # Countries
    countries = c(
      rep("RWA", 4),
      rep("AGO", 8),
      rep("BEN", 2),
      rep("GBR", 5),
      rep("FRA", 3)
    )
  )
  expect_error(
    overview_print(df_combined),
    "Data frame requires two columns that represent the time and
        scope dimension of the data"
  )
})

test_that("check output of for crosstab", {
  testthat::skip_on_cran()

  toydata_no_dup <-
    toydata %>%
    dplyr::select(ccode, year, population, gdp) %>%
    dplyr::group_by(ccode, year) %>%
    dplyr::mutate(
      ccode = dplyr::first(ccode),
      year = dplyr::first(year),
      population = mean(population),
      gdp = mean(gdp)
    ) %>%
    dplyr::mutate(ccode = ifelse(year == 1990 & ccode == "RWA", NA, ccode)) %>%
    dplyr::ungroup() %>%
    dplyr::distinct()

  expect_warning(
    overview_crosstab(
      dat = toydata_no_dup,
      id = ccode,
      time = year,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 27000,
      threshold2 = 25000
    )
  )
})


test_that("Get a warning message", {
  data_test <- data.frame(
    countries = c("RWA", "BDI"),
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
    ccode = c(
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
      seq(1, 44, by = 2)
  )
  output_cross <-
    overview_crosstab(
      dat = df_com,
      id = ccode,
      time = year,
      cond1 = population,
      cond2 = gdp,
      threshold1 = 20,
      threshold2 = 10
    )
  expect_equal(nrow(output_cross), 2)
})

test_that("check output of overview_na", {
  plot_na <- overview_na(dat = toydata)
  testthat::expect_is(plot_na, "ggplot")
  plot_na_abs <- overview_na(dat = toydata, perc = FALSE)
  testthat::expect_is(plot_na_abs, "ggplot")
})

test_that("check output of overview_na with row_wise", {
  plot_na_row <- overview_na(dat = toydata, row_wise = TRUE)
  testthat::expect_is(plot_na_row, "ggplot")
  plot_na_abs_row <-
    overview_na(
      dat = toydata,
      perc = FALSE,
      row_wise = TRUE
    )
  testthat::expect_is(plot_na_abs_row, "ggplot")
})

test_that("check output of overview_overlap", {
  toydata2 <- toydata
  plot_overlap_bar <-
    overview_overlap(
      dat1 = toydata,
      dat2 = toydata2,
      dat1_id = ccode,
      dat2_id = ccode,
      plot_type = "bar"
    )
  testthat::expect_is(plot_overlap_bar, "ggplot")
  plot_overlap_venn <-
    overview_overlap(
      dat1 = toydata,
      dat2 = toydata2,
      dat1_id = ccode,
      dat2_id = ccode,
      plot_type = "venn"
    )
  testthat::expect_is(plot_overlap_venn, "ggplot")
})


test_that("overview_na() returns a data frame", {
  overview_na_df <- overview_na(
    dat = toydata,
    row_wise = TRUE,
    add = TRUE
  )
  expect_is(overview_na_df, "data.frame")
})

test_that("check output of overview_heat", {
  plot_heat <-
    overview_heat(toydata, ccode, year, perc = TRUE, exp_total = 12)
  testthat::expect_is(plot_heat, "ggplot")
  plot_heat_abs <- overview_heat(toydata, ccode, year, perc = FALSE)
  testthat::expect_is(plot_heat_abs, "ggplot")
})

test_that("check output of overview_heat with label FALSE", {
  plot_heat_no_lab <- overview_heat(
    toydata,
    ccode,
    year,
    perc = TRUE,
    label = FALSE,
    exp_total = 12
  )
  testthat::expect_is(plot_heat_no_lab, "ggplot")
})

test_that("check output of overview_heat with label FALSE and no perc", {
  plot_heat_abs_lab_false <-
    overview_heat(toydata, ccode, year,
      perc = FALSE,
      label = FALSE
    )
  testthat::expect_is(plot_heat_abs_lab_false, "ggplot")
})

test_that("check output of overview_plot", {
  plot <- overview_plot(dat = toydata, id = ccode, time = year)
  testthat::expect_is(plot, "ggplot")
})

test_that("check output of overview_plot", {
  plot <-
    overview_plot(
      dat = toydata,
      id = ccode,
      time = year,
      asc = FALSE
    )
  testthat::expect_is(plot, "ggplot")
})

test_that("check output of overview_plot with color", {
  plot <-
    overview_plot(
      dat = toydata,
      id = ccode,
      time = year,
      color = population
    )
  testthat::expect_is(plot, "ggplot")
})

test_that("check output of overview_plot with color", {
  plot <-
    overview_plot(
      dat = toydata,
      id = ccode,
      time = year,
      color = population,
      asc = FALSE
    )
  testthat::expect_is(plot, "ggplot")
})




test_that("check output of overview_crossplot", {
  plot_cross <-
    overview_crossplot(toydata, ccode, year, gdp, population, 25000, 27000)
  testthat::expect_is(plot_cross, "ggplot")
  plot_cross_col <-
    overview_crossplot(toydata, ccode, year, gdp, population, 25000, 27000,
      color = TRUE
    )
  testthat::expect_is(plot_cross_col, "ggplot")
  plot_cross_lab <-
    overview_crossplot(toydata, ccode, year, gdp, population, 25000, 27000,
      label = TRUE
    )
  testthat::expect_is(plot_cross_lab, "ggplot")
  plot_cross_lab_col <-
    overview_crossplot(
      toydata,
      ccode,
      year,
      gdp,
      population,
      25000,
      27000,
      label = TRUE,
      color = TRUE
    )
  testthat::expect_is(plot_cross_lab, "ggplot")
})


test_that("check output of overview_crossplot without dups", {
  toydata_no_dup <-
    toydata %>%
    dplyr::select(ccode, year, population, gdp) %>%
    dplyr::group_by(ccode, year) %>%
    dplyr::mutate(
      ccode = dplyr::first(ccode),
      year = dplyr::first(year),
      population = mean(population),
      gdp = mean(gdp)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::distinct()

  plot_cross <-
    overview_crossplot(toydata_no_dup, ccode, year, gdp, population, 25000, 27000)
  testthat::expect_is(plot_cross, "ggplot")
  plot_cross_col <-
    overview_crossplot(toydata_no_dup, ccode, year, gdp, population, 25000, 27000,
      color = TRUE
    )
  testthat::expect_is(plot_cross_col, "ggplot")
  plot_cross_lab <-
    overview_crossplot(toydata_no_dup, ccode, year, gdp, population, 25000, 27000,
      label = TRUE
    )
  testthat::expect_is(plot_cross_lab, "ggplot")
  plot_cross_lab_col <-
    overview_crossplot(
      toydata_no_dup,
      ccode,
      year,
      gdp,
      population,
      25000,
      27000,
      label = TRUE,
      color = TRUE
    )
  testthat::expect_is(plot_cross_lab, "ggplot")
})



test_that("check output of overview_crossplot with label FALSE", {
  plot_cross_no_lab <-
    overview_crossplot(toydata, ccode, year, gdp, population, 25000, 27000,
      label = FALSE
    )
  testthat::expect_is(plot_cross_no_lab, "ggplot")
  plot_cross_no_lab_but_col <-
    overview_crossplot(
      toydata,
      ccode,
      year,
      gdp,
      population,
      25000,
      27000,
      label = FALSE,
      color = TRUE
    )
  testthat::expect_is(plot_cross_no_lab_but_col, "ggplot")
})



test_that("check output of overview_crossplot with no color", {
  plot_cross_no_lab_no_col <-
    overview_crossplot(
      toydata,
      ccode,
      year,
      gdp,
      population,
      25000,
      27000,
      color = FALSE,
      label = FALSE
    )
  testthat::expect_is(plot_cross_no_lab_no_col, "ggplot")
  plot_cross_no_col <-
    overview_crossplot(toydata, ccode, year, gdp, population, 25000, 27000,
      color = FALSE
    )
  testthat::expect_is(plot_cross_no_col, "ggplot")
})

test_that("for time$day in overview_tab", {
  expect_error(overview_tab(dat = toydata, id = ccode, time = list(year = toydata$year, month = toydata$month, day = NULL), complex_date = TRUE))
})
# test_that("check output of overview_crossplot with unique observations", {
#   modified <- toydata %>%
#     dplyr::ungroup() %>%
#     dplyr::group_by(ccode, year) %>%
#     dplyr::summarise(population = mean(population, na.rm=TRUE),
#                      gdp = mean(gdp, na.rm=TRUE)) %>%
#     dplyr::ungroup()
#
#
#   plot_cross <-
#     overview_crossplot(modified, ccode, year, cond1 = gdp, cond2 = population, threshold1 = 25000, threshold2 = 27000)
#   testthat::expect_is(plot_cross, "ggplot")
#   plot_cross_col <-
#     overview_crossplot(modified, ccode, year, cond1 = gdp, cond2 = population, threshold1 = 25000, threshold2 = 27000,
#                        color = TRUE)
#   testthat::expect_is(plot_cross_col, "ggplot")
#   plot_cross_lab <-
#     overview_crossplot(modified, ccode, year, cond1 = gdp, cond2 = population, threshold1 = 25000, threshold2 = 27000,
#                        label = TRUE)
#   testthat::expect_is(plot_cross_lab, "ggplot")
#   plot_cross_lab_col <-
#     overview_crossplot(modified, ccode, year, cond1 = gdp, cond2 = population, threshold1 = 25000, threshold2 = 27000,
#                        label = TRUE, color = TRUE)
#   testthat::expect_is(plot_cross_lab, "ggplot")
#
#
# })
#
# test_that("check output of overview_overlap", {
#   plot <-
#     overview_overlap(
#       dat1 = toydata,
#       dat2 = toydata,
#       dat1_id = ccode,
#       dat2_id = ccode
#     )
#   testthat::expect_is(plot, "ggplot")
# })
