#' Theme_pedr - Custom ggplot2 theme
#'
#' @param base_size Base font size in points (default: 11)
#' @param strip_text_size Facet strip text size in points (default: 12)
#' @param strip_text_margin Bottom margin for strip text in points (default: 5)
#' @param subtitle_size Subtitle text size in points (default: 13)
#' @param subtitle_margin Bottom margin for subtitle in points (default: 10)
#' @param plot_title_size Plot title text size in points (default: 16)
#' @param plot_title_margin Bottom margin for plot title in points (default: 10)
#' @param strip_color Background color for facet strips (default: "gray90").
#'   Must be a valid R color name or hex code.
#' @param font_family Font family to use (default: "BentonSans Regular").
#'   If font is not available, falls back to system default.
#' @param ... Additional arguments passed to theme_minimal()
#'
#' @returns A ggplot2 theme object
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, disp)) +
#'   geom_point() +
#'   facet_wrap(vars(vs)) +
#'   theme_pedr(font_family = "serif")
theme_pedr <- function(base_size = 11,
                       strip_text_size = 12,
                       strip_text_margin = 5,
                       subtitle_size = 13,
                       subtitle_margin = 10,
                       plot_title_size = 16,
                       plot_title_margin = 10,
                       strip_color = "gray90",
                       font_family = "BentonSans Regular",
                       ...) {
  validate_theme(
    base_size = base_size,
    strip_text_size = strip_text_size,
    strip_text_margin = strip_text_margin,
    subtitle_size = subtitle_size,
    subtitle_margin = subtitle_margin,
    plot_title_size = plot_title_size,
    plot_title_margin = plot_title_margin,
    strip_color = strip_color
  )

  font_family <-
    validate_font(font_family = font_family)

  # ___________#

  out <- ggplot2::theme_minimal(
    base_family = font_family,
    base_size = base_size, ...
  )


  out %+replace%
    ggplot2::theme(
      strip.text = ggplot2::element_text(
        hjust = 0.5, size = strip_text_size,
        margin = ggplot2::margin(b = strip_text_margin),
        family = font_family
      ),
      strip.background = ggh4x::element_part_rect(
        fill = strip_color,
        color = "gray40",
        side = "b",
        linewidth = NULL,
        linetype = NULL
      ),
      plot.subtitle = ggplot2::element_text(
        hjust = 0.5, size = subtitle_size,
        margin = ggplot2::margin(b = subtitle_margin),
        family = font_family,
        color = "gray10"
      ),
      plot.title = ggplot2::element_text(
        hjust = 0.5, size = plot_title_size,
        margin = ggplot2::margin(b = plot_title_margin),
        family = font_family
      )
    )
}


check_positive_number <- function(x,
                                  arg = rlang::caller_arg(x),
                                  call = rlang::caller_env()) {
  if (!rlang::is_scalar_double(x) && !rlang::is_scalar_integer(x)) {
    cli::cli_abort("{.arg {arg}} must be a single number.", call = call)
  }
  if (x <= 0) {
    cli::cli_abort("{.arg {arg}} must be greater than 0.", call = call)
  }
}

check_nonneg_number <- function(x,
                                arg = rlang::caller_arg(x),
                                call = rlang::caller_env()) {
  if (!rlang::is_scalar_double(x) && !rlang::is_scalar_integer(x)) {
    cli::cli_abort("{.arg {arg}} must be a single number.", call = call)
  }
  if (x < 0) {
    cli::cli_abort("{.arg {arg}} must be a non-negative number.", call = call)
  }
}

validate_theme <- function(base_size,
                           strip_text_size,
                           strip_text_margin,
                           subtitle_size,
                           subtitle_margin,
                           plot_title_size,
                           plot_title_margin,
                           strip_color) {
  rlang::check_required(base_size)
  check_positive_number(base_size)
  check_positive_number(strip_text_size)
  check_nonneg_number(strip_text_margin)
  check_positive_number(subtitle_size)
  check_nonneg_number(subtitle_margin)
  check_positive_number(plot_title_size)
  check_nonneg_number(plot_title_margin)

  if (!rlang::is_string(strip_color)) {
    cli::cli_abort("{.arg strip_color} must be a single string.")
  }

  rlang::check_installed("grDevices")
  tryCatch(
    grDevices::col2rgb(strip_color),
    error = function(e) {
      cli::cli_abort("{.arg strip_color} is not a valid colour: {.val {strip_color}}")
    }
  )
}


validate_font <- function(font_family) {
  if (!rlang::is_string(font_family)) {
    cli::cli_abort("{.arg font_family} must be a single string.")
  }

  available_fonts <- systemfonts::system_fonts()$family
  font_exist <- any(grepl(font_family, available_fonts, ignore.case = TRUE))

  if (!font_exist) {
    cli::cli_alert_warning(
      "Can not find the font {.val {font_family}}, will use the standard font."
    )
    font_family <- NULL
  }
  return(font_family)
}
