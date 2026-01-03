#' Start up
#'
#' @param ... packs to add
#' @param quiet description
#' @description
#' type = 1 - tidyverse + readxl
#' type = 2 - tidymodels core pkg TODO
#' type = 3 - tidymodel core + ext TODO
#' type = 4 - web TODO
#'
#'
#' @returns list of attached packages
#' @export
#'
#' @examples
#'
#' startup()
startup <- function(..., quiet = FALSE) {
  ggplot2::update_geom_defaults("rect", list(fill = "#1d3557", alpha = 0.9))
  ggplot2::update_geom_defaults("point", list(color = "#1d3557", alpha = 0.9))
  theme_output <-
    utils::capture.output(
      {
        ggplot2::theme_set(theme_pedr())
      },
      type = "message"
    )

  type_1_info <- NULL
  type_2_info <- NULL


  if (rlang::dots_n(...) == 0) {
    dots <- 1
  } else {
    dots <- rlang::dots_list(...)
    dots <- unlist(dots)
  }


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
#### Tidyverse and readxl attach

    map(c("tidyverse", "readxl"), \(x) attach_pkg(x))

    type_1_info <- c(
      cli::rule(center = cli::col_blue(" * Tidyverse: * ")),
      map(type_1, \(x) print_pkg(x, TRUE)),
      map("readxl", \(x) print_pkg(x, FALSE))
    )
###


  if (2 %in% dots) {

    map(type_2, \(x) attach_pkg(x))
    type_2_info <- c(
      cli::rule(center = cli::col_blue(" * Tidymodels: * ")),
      map(type_2, \(x) print_pkg(x, TRUE))
    )

    attached_pkg <- c(attached_pkg, type_2)
  }


  ## ________________##
  msg <- c(
    cli::rule(cli::style_bold("Attaching packs:")),
    "",
    type_1_info %||% "",
    "",
    type_2_info %||% "",
    "",
    ""
  )


  ## ________________##


  if (!quiet) {
    message(paste(msg, collapse = "\n"))
    cli::cli(cli::cli_alert_success("Geom defaults updated"))
    cli::cli(cli::cli_alert_success("Theme set to theme_peder()"))
    cat(theme_output)
  }
  invisible(attached_pkg)
}

attach_pkg <- function(pkg) {
  suppressWarnings(
    suppressPackageStartupMessages(
      library(pkg,
        character.only = TRUE,
        warn.conflicts = FALSE
      )
    )
  )
}

print_pkg <- function(pkg, indent = FALSE, symbol = cli::symbol$tick) {
  version <- as.character(utils::packageVersion(pkg))

  out <- paste0(
    cli::col_green(symbol),
    " ",
    cli::col_blue(format(pkg)),
    " ",
    cli::ansi_align(version, 10)
  )
  if (indent) {
    return(paste0(
      cli::style_bold(cli::symbol$em_dash), " ",
      out
    ))
  }
  out
}
