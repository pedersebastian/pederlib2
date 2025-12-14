#' Theme_pedr
#'
#' @param base_size x
#' @param strip_text_size x
#' @param strip_text_margin x
#' @param subtitle_size x
#' @param subtitle_margin x
#' @param plot_title_size x
#' @param plot_title_margin x
#' @param strip_color x
#' @param font_family x
#' @param ... passed on to theme_minimal
#'
#' @returns theme
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, disp)) +
#' geom_point() +
#' facet_wrap(vars(vs))
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


  parsed_font <- unlist(strsplit(font_family, " ", ))[[1]]

  if (!any(grepl(parsed_font, systemfonts::system_fonts()$family)))  {
    cli::cli(cli::cli_alert_warning("Finner ikke {font_family}, bruker standard"))
    font_family <- NULL
  }

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





