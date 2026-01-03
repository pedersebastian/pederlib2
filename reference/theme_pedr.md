# Theme_pedr

Theme_pedr

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

  x

- strip_text_size:

  x

- strip_text_margin:

  x

- subtitle_size:

  x

- subtitle_margin:

  x

- plot_title_size:

  x

- plot_title_margin:

  x

- strip_color:

  x

- font_family:

  x

- ...:

  passed on to theme_minimal

## Value

theme

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
