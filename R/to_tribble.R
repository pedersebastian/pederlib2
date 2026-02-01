#' To tribble
#'
#'
#' @returns Informed message
#' @export
#'
#' @examples
#' to_tribble()
to_tribble <- function() {
  rlang::check_installed("timesaveR")
  cli::cli_inform("use to_tribble() - from github LukasWallrich/timesaveR")
}
