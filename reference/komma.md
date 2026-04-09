# Komma

Komma

## Usage

``` r
komma(...)
```

## Arguments

- ...:

  passed on to scales::comma_format

## Value

a function to use in label argument in scales in ggplot2

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(drat)) +
  geom_histogram() +
  scale_x_continuous(labels = komma()) +
  theme_minimal()
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```
