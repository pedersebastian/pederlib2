#' List locales
#'
#' @returns a list of locale found
#' @export
#'
#' @examples
#' list_locale()
list_locale <- function() {
  locales <- system("locale -a", intern = TRUE)
  sort(locales)
}


#' Komma
#'
#' @param ... passed on to scales::comma_format
#'
#' @returns a function to use in label argument in scales in ggplot2
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(drat)) +
#'   geom_histogram() +
#'   scale_x_continuous(labels = komma()) +
#'   theme_minimal()
komma <- function(...) {
  scales::comma_format(decimal.mark = ",", big.mark = ".", ...)
}
