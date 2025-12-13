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

  type_1_info <- NULL
  type_2_info <- NULL

  if (rlang::dots_n(...) == 0) {
    dots <- 1
  } else {
    dots <- rlang::dots_list(...)
    dots <- unlist(dots)
  }


  type_2 <- c(tidymodels::tidymodels_packages())


  if (1 %in% dots) {
    map(c("tidyverse", "readxl"), \(x) attach_pkg(x))

    type_1_info <- c(
      cli::rule(center = cli::col_blue(" * Tidyverse: * ")),
      map(tidyverse::tidyverse_packages(), \(x) print_pkg(x, TRUE)),
      map("readxl", \(x) print_pkg(x, FALSE))
    )
  }


  ## ________________##
  msg <- c(
    cli::rule(cli::style_bold("Attaching packs:")),
    "",
    type_1_info %||% "",
    "",
    "",
    "",
    ""
  )


  ## ________________##


  if (!quiet) {
    message(paste(msg, collapse = "\n"))
    cli::cli(cli::cli_alert_success("Geom defaults updated"))
  }

  invisible()
}

attach_pkg <- function(pkg) {
  suppressWarnings(suppressPackageStartupMessages(library(pkg, character.only = TRUE, warn.conflicts = FALSE)))
}

print_pkg <- function(pkg, indent = FALSE) {
  version <- as.character(utils::packageVersion(pkg))

  out <- paste0(
    cli::col_green(cli::symbol$tick),
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
