# Cross-sectional data for countries

Small, artificially generated toy data set that comes in a
cross-sectional format where the unit of analysis is either country-year
or country-year-month. It provides artificial information for five
countries (Angola, Benin, France, Rwanda, and the UK) for a time span
from 1990 to 1999 to illustrate the use of the package.

## Usage

``` r
data(toydata)
```

## Format

An object of class `"data.frame"`

- ccode:

  ISO3 country code (as character) for the countries in the sample
  (Angola, Benin, France, Rwanda, and UK)

- year:

  A value between 1990 and 1999

- month:

  An abbreviation (MMM) for month (character)

- gpd:

  A fake value for GDP (randomly generated)

- population:

  A fake value for population (randomly generated)

## References

This data set was artificially created for the overviewR package.

## Examples

``` r

data(toydata)
head(toydata)
#>   ccode year month      gdp population day
#> 1   RWA 1990   Jan 24180.77  14969.988   1
#> 2   RWA 1990   Jan 23650.53  11791.464   2
#> 3   RWA 1990   Jan 21860.14  30047.979   3
#> 4   RWA 1990   Jan 20801.06  19853.556   4
#> 5   RWA 1990   Jan 18702.84   5148.118   5
#> 6   RWA 1990   Jan 30272.37  48625.140   6
```
