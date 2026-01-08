# Theme_pedr - Custom ggplot2 theme

Theme_pedr - Custom ggplot2 theme

## Usage

``` r
theme_pedr(
  base_size = 11,
  strip_text_size = 12,
  strip_text_margin = 5,
  subtitle_size = 13,
  subtitle_margin = 10,
  plot_title_size = 16,
  plot_title_margin = 10,
  strip_color = "gray90",
  font_family = "BentonSans Regular",
  ...
)
```

## Arguments

- base_size:

  Base font size in points (default: 11)

- strip_text_size:

  Facet strip text size in points (default: 12)

- strip_text_margin:

  Bottom margin for strip text in points (default: 5)

- subtitle_size:

  Subtitle text size in points (default: 13)

- subtitle_margin:

  Bottom margin for subtitle in points (default: 10)

- plot_title_size:

  Plot title text size in points (default: 16)

- plot_title_margin:

  Bottom margin for plot title in points (default: 10)

- strip_color:

  Background color for facet strips (default: "gray90"). Must be a valid
  R color name or hex code.

- font_family:

  Font family to use (default: "BentonSans Regular"). If font is not
  available, falls back to system default.

- ...:

  Additional arguments passed to theme_minimal()

## Value

A ggplot2 theme object

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)
ggplot(mtcars, aes(mpg, disp)) +
  geom_point() +
  facet_wrap(vars(vs)) +
  theme_pedr(font_family = "Times New Roman")
} # }
```
