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
