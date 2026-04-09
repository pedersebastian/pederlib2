# Start up

Attaches commonly used packages and sets ggplot2 defaults:

- Default (no args): tidyverse + readxl

- `startup(2)`: adds tidymodels core packages

## Usage

``` r
startup(..., quiet = FALSE)
```

## Arguments

- ...:

  optional numeric flags. Pass `2` to also attach tidymodels packages.

- quiet:

  if `TRUE`, suppresses all messages

## Value

invisibly returns a character vector of attached package names

## Examples

``` r
startup()
#> ! Can not find the font "BentonSans Regular", will use the standard font.
#> ── Attaching packs: ────────────────────────────────────────────────────────────
#> 
#> ───────────────────────────────  * Tidyverse: *  ───────────────────────────────
#> — ✔ ggplot2      4.0.2     
#> — ✔ tibble       3.3.1     
#> — ✔ tidyr        1.3.2     
#> — ✔ readr        2.2.0     
#> — ✔ purrr        1.2.1     
#> — ✔ dplyr        1.2.1     
#> — ✔ stringr      1.6.0     
#> — ✔ forcats      1.0.1     
#> — ✔ lubridate    1.9.5     
#> ✔ readxl       1.4.5     
#> ✔ Geom defaults updated
#> ✔ Theme set to theme_pedr()
```
