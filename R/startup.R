

#' Start up
#'
#' @param type with type
#' @param ... add more packs
#'
#' @returns list of attached packages
#' @export
#'
#' @examples
#'
#' startup()
startup <- function(type = 1, ...) {
  type_1 <- c("tidyverse", "readxl")

  if (type == 1) pks <- type_1

  map(pks, \(x) suppressPackageStartupMessages(require(x, character.only = TRUE)))
  pks

  ggplot2::update_geom_defaults("rect", list(fill = "#1d3557", alpha = 0.9))
  ggplot2::update_geom_defaults("point", list(color = "#1d3557", alpha = 0.9))

  # if (!quiet) {
  #   cli::cli_alert_success("Geom defaults updated ✌️")
  # }
  #suppressMessages(suppressWarnings(require(i, character.only = TRUE)))
}
