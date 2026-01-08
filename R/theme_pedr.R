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
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, disp)) +
#'   geom_point() +
#'   facet_wrap(vars(vs)) +
#'   theme_pedr(font_family = "Times New Roman")
#' }
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
    valider_font(font_family = font_family)

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


validate_theme <- function(base_size,
                           strip_text_size,
                           strip_text_margin,
                           subtitle_size,
                           subtitle_margin,
                           plot_title_size,
                           plot_title_margin,
                           strip_color) {
  # Valider numeriske input
  rlang::check_required(base_size)
  if (!rlang::is_scalar_double(base_size) && !rlang::is_scalar_integer(base_size)) {
    cli::cli_abort("{.arg base_size} must be a single number.")
  }
  if (base_size <= 0) {
    cli::cli_abort("{.arg base_size} must be greater than 0.")
  }

  if (!rlang::is_scalar_double(strip_text_size) && !rlang::is_scalar_integer(strip_text_size)) {
    cli::cli_abort("{.arg strip_text_size} must be a single number.")
  }
  if (strip_text_size <= 0) {
    cli::cli_abort("{.arg strip_text_size} must be greater than 0.")
  }

  if (!rlang::is_scalar_double(strip_text_margin) && !rlang::is_scalar_integer(strip_text_margin)) {
    cli::cli_abort("{.arg strip_text_margin} must be a single number.")
  }
  if (strip_text_margin < 0) {
    cli::cli_abort("{.arg strip_text_margin} must be a non-negative number.")
  }

  if (!rlang::is_scalar_double(subtitle_size) && !rlang::is_scalar_integer(subtitle_size)) {
    cli::cli_abort("{.arg subtitle_size} must be a single number.")
  }
  if (subtitle_size <= 0) {
    cli::cli_abort("{.arg subtitle_size} must be greater than 0.")
  }

  if (!rlang::is_scalar_double(subtitle_margin) && !rlang::is_scalar_integer(subtitle_margin)) {
    cli::cli_abort("{.arg subtitle_margin} must be a single number.")
  }
  if (subtitle_margin < 0) {
    cli::cli_abort("{.arg subtitle_margin} must be a non-negative number.")
  }

  if (!rlang::is_scalar_double(plot_title_size) && !rlang::is_scalar_integer(plot_title_size)) {
    cli::cli_abort("{.arg plot_title_size} must be a single number.")
  }
  if (plot_title_size <= 0) {
    cli::cli_abort("{.arg plot_title_size} must be greater than 0.")
  }

  if (!rlang::is_scalar_double(plot_title_margin) && !rlang::is_scalar_integer(plot_title_margin)) {
    cli::cli_abort("{.arg plot_title_margin} must be a single number.")
  }
  if (plot_title_margin < 0) {
    cli::cli_abort("{.arg plot_title_margin} must be a non-negative number.")
  }

  # Valider strip_color
  if (!rlang::is_string(strip_color)) {
    cli::cli_abort("{.arg strip_color} must be a single string.")
  }

  rlang::check_installed("grDevices")
  # Sjekk at fargen er gyldig
  tryCatch(
    grDevices::col2rgb(strip_color),
    error = function(e) {
      cli::cli_abort("{.arg strip_color} is not a valid colour: {.val {strip_color}}")
    }
  )
}


valider_font <- function(font_family) {
  # Validated font_family
  if (!rlang::is_string(font_family)) {
    cli::cli_abort("{.arg font_family} must be a single string.")
  }

  parsed_font <- unlist(strsplit(font_family, " ", ))[[1]]

  available_fonts <- systemfonts::system_fonts()$family

  font_exist <- any(grepl(parsed_font, available_fonts, ignore.case = TRUE))

  if (!font_exist) {
    cli::cli_alert_warning(
      "Can not find the font {.val {font_family}}, will use the standard font."
    )
    font_family <- NULL
  }
  return(font_family)
}
