#' Cross-sectional data for countries
#'
#' Small, artificially generated toy data set that comes in a cross-sectional
#' format where the unit of analysis is either country-year or
#' country-year-month. It provides artificial information for five countries
#' (Angola, Benin, France, Rwanda, and the UK) for a time span from 1990 to 1999 to
#' illustrate the use of the package.
#'
#' @docType data
#'
#' @usage data(toydata)
#'
#' @format An object of class \code{"data.frame"}
#' \describe{
#'  \item{ccode}{ISO3 country code (as character) for the countries in the
#'      sample (Angola, Benin, France, Rwanda, and UK)}
#'  \item{year}{A value between 1990 and 1999}
#'  \item{month}{An abbreviation (MMM) for month (character)}
#'  \item{gpd}{A fake value for GDP (randomly generated)}
#'  \item{population}{A fake value for population (randomly generated)}
#' }
#' @references This data set was artificially created for the overviewR package.
#' @keywords datasets
#' @examples
#'
#' data(toydata)
#' head(toydata)
"toydata"
