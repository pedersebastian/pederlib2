# Start up

type = 1 - tidyverse + readxl type = 2 - tidymodels core pkg TODO type =
3 - tidymodel core + ext TODO type = 4 - web TODO

## Usage

``` r
startup(..., quiet = FALSE)
```

## Arguments

- ...:

  packs to add

- quiet:

  description

## Value

list of attached packages

## Examples

``` r
startup()
#> ! Can not find the font "BentonSans Regular", will use the standard font.
#> ── Attaching packs: ────────────────────────────────────────────────────────────
#> 
#> ───────────────────────────────  * Tidyverse: *  ───────────────────────────────
#> — ✔ ggplot2 4.0.1     
#> — ✔ tibble 3.3.1     
#> — ✔ tidyr 1.3.2     
#> — ✔ readr 2.1.6     
#> — ✔ purrr 1.2.1     
#> — ✔ dplyr 1.1.4     
#> — ✔ stringr 1.6.0     
#> — ✔ forcats 1.0.1     
#> — ✔ lubridate 1.9.4     
#> ✔ readxl 1.4.5     
#> 
#> 
#> 
#> ✔ Geom defaults updated
#> ✔ Theme set to theme_peder()
```
