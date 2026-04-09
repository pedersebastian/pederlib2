#' Start up
#'
#' @param ... optional numeric flags. Pass `2` to also attach tidymodels packages.
#' @param quiet if `TRUE`, suppresses all messages
#' @description
#' Attaches commonly used packages and sets ggplot2 defaults:
#' - Default (no args): tidyverse + readxl
#' - `startup(2)`: adds tidymodels core packages
#'
#' @returns invisibly returns a character vector of attached package names
#' @export
#'
#' @examples
#' startup()
startup <- function(..., quiet = FALSE) {
  ggplot2::update_geom_defaults("rect", list(fill = "#1d3557", alpha = 0.9))
  ggplot2::update_geom_defaults("point", list(color = "#1d3557", alpha = 0.9))
  theme_output <-
    utils::capture.output(
      ggplot2::theme_set(theme_pedr()),
      type = "message"
    )

  type_2_info <- NULL

  dots <- if (rlang::dots_n(...) == 0) 1L else unlist(rlang::dots_list(...))

  type_1 <- c(
    "ggplot2",
    "tibble",
    "tidyr",
    "readr",
    "purrr",
    "dplyr",
    "stringr",
    "forcats",
    "lubridate"
  )

  type_2 <- c(
    "broom",
    "dials",
    "infer",
    "modeldata",
    "parsnip",
    "recipes",
    "rsample",
    "tailor",
    "tune",
    "workflows",
    "workflowsets",
    "yardstick"
  )

  attached_pkg <- c(type_1, "readxl")

  walk(c("tidyverse", "readxl"), attach_pkg)

  type_1_info <- c(
    cli::rule(center = cli::col_blue(" * Tidyverse: * ")),
    map(type_1, \(x) print_pkg(x, TRUE)),
    map("readxl", \(x) print_pkg(x, FALSE))
  )

  if (2 %in% dots) {
    walk(type_2, attach_pkg)
    type_2_info <- c(
      cli::rule(center = cli::col_blue(" * Tidymodels: * ")),
      map(type_2, \(x) print_pkg(x, TRUE))
    )
    attached_pkg <- c(attached_pkg, type_2)
  }

  msg <- c(
    cli::rule(cli::style_bold("Attaching packs:")),
    "",
    type_1_info,
    if (!is.null(type_2_info)) c("", type_2_info)
  )

  if (!quiet) {
    message(paste(msg, collapse = "\n"))
    cli::cli_alert_success("Geom defaults updated")
    cli::cli_alert_success("Theme set to theme_pedr()")
    cat(theme_output)
  }
  invisible(attached_pkg)
}

attach_pkg <- function(pkg) {
  suppressWarnings(
    suppressPackageStartupMessages(
      library(pkg, character.only = TRUE, warn.conflicts = FALSE)
    )
  )
}

print_pkg <- function(pkg, indent = FALSE, symbol = cli::symbol$tick) {
  version <- as.character(utils::packageVersion(pkg))

  out <- paste0(
    cli::col_green(symbol),
    " ",
    cli::col_blue(format(pkg, width = 12)),
    " ",
    cli::ansi_align(version, 10)
  )
  if (indent) {
    return(paste0(
      cli::style_bold(cli::symbol$em_dash),
      " ",
      out
    ))
  }
  out
}
