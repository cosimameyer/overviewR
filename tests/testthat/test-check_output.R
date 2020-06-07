context("check-output")

# Normal data set
set.seed(68163)
df_combined <- data.frame(
  # Countries
  countries  = c(
    rep("RWA", 4),
    rep("AGO", 8),
    rep("BEN", 2),
    rep("GBR", 5),
    rep("FRA", 3)
  ),
  # Time frame
  years =
    c(
      seq(1990, 1995),
      seq(1990, 1992),
      seq(1995, 1999),
      seq(1991, 1999, by = 2),
      seq(1993, 1999, by = 3)
    ),
  # GDP
  gdp =
    runif(22, 10000, 40000),
  # Population
  population =
    runif(22, 100, 50000),
  stringsAsFactors = FALSE
)

output_table <- overview_tab(dat = df_combined, id = countries, time = years)

expect_is(output_table, "data.frame")

output_crosstab <- overview_crosstab(
  dat = df_combined,
  cond1 = gdp,
  cond2 = population,
  threshold1 = 30000,
  threshold2 = 15000,
  id = countries,
  time = years
)

expect_is(output_crosstab, "data.frame")

