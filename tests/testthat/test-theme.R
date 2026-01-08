library(ggplot2)



plot1 <-
  ggplot(mtcars, aes(mpg, disp)) +
  geom_point() +
  facet_wrap(vars(vs)) +
  theme_pedr(font_family = "Times New Roman")

plot2 <-
  ggplot(mtcars, aes(mpg, disp)) +
  geom_point() +
  facet_wrap(vars(vs)) +
  theme_pedr()


test_that("simple theme", {
  vdiffr::expect_doppelganger(
    "Simple plot with Times New Roman as font",
    plot1
  )
  vdiffr::expect_doppelganger(
    "Simple plot with default as font",
    plot2
  )
})
# ///

test_that("theme parameters affect plot appearance", {
  plot_large_text <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(vs)) +
    labs(title = "Test title", subtitle = "Test subtitle") +
    theme_pedr(
      base_size = 16,
      strip_text_size = 16,
      subtitle_size = 18,
      plot_title_size = 22
    )

  vdiffr::expect_doppelganger(
    "Theme with larger text sizes",
    plot_large_text
  )
})

test_that("custom strip color works", {
  plot_custom_strip <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(cyl)) +
    theme_pedr(strip_color = "lightblue")

  vdiffr::expect_doppelganger(
    "Theme with custom strip color",
    plot_custom_strip
  )
})

test_that("theme works with title and subtitle", {
  plot_with_labels <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    labs(
      title = "Miles per Gallon vs Displacement",
      subtitle = "Motor Trend Car Road Tests"
    ) +
    theme_pedr()

  vdiffr::expect_doppelganger(
    "Theme with title and subtitle",
    plot_with_labels
  )
})

test_that("theme works without facets", {
  plot_no_facet <- ggplot(mtcars, aes(mpg, disp, color = factor(cyl))) +
    geom_point() +
    labs(title = "Simple scatter plot") +
    theme_pedr()

  vdiffr::expect_doppelganger(
    "Theme without facets",
    plot_no_facet
  )
})

test_that("theme works with multiple facet rows", {
  plot_facet_grid <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_grid(vs ~ am) +
    theme_pedr()

  vdiffr::expect_doppelganger(
    "Theme with facet_grid",
    plot_facet_grid
  )
})

test_that("invalid argument triggers warning in theme_minimal", {
  expect_error(
    ggplot(mtcars, aes(mpg, disp)) +
      geom_point() +
      theme_pedr(regexp = "Finner ikke")
  )
})

test_that("theme returns a theme object", {
  theme_obj <- theme_pedr()
  expect_s3_class(theme_obj, "theme")
  expect_s3_class(theme_obj, "gg")
})

test_that("theme inherits from theme_minimal", {
  theme_obj <- theme_pedr()
  # Sjekk at noen av theme_minimal sine egenskaper er bevart
  expect_true(!is.null(theme_obj$panel.grid))
})

test_that("custom margins work correctly", {
  plot_custom_margins <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(cyl)) +
    labs(title = "Title", subtitle = "Subtitle") +
    theme_pedr(
      strip_text_margin = 15,
      subtitle_margin = 20,
      plot_title_margin = 15
    )

  vdiffr::expect_doppelganger(
    "Theme with custom margins",
    plot_custom_margins
  )
})

test_that("theme works with different plot types", {
  plot_boxplot <- ggplot(mtcars, aes(factor(cyl), mpg)) +
    geom_boxplot() +
    facet_wrap(vars(vs)) +
    labs(title = "Boxplot example") +
    theme_pedr()

  vdiffr::expect_doppelganger(
    "Theme with boxplot",
    plot_boxplot
  )

  plot_bar <- ggplot(mtcars, aes(factor(cyl))) +
    geom_bar() +
    facet_wrap(vars(vs)) +
    labs(title = "Bar plot example") +
    theme_pedr()

  vdiffr::expect_doppelganger(
    "Theme with bar plot",
    plot_bar
  )
})

test_that("theme can be combined with additional theme elements", {
  plot_modified <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(vs)) +
    theme_pedr() +
    theme(axis.text.x = element_text(angle = 45))

  vdiffr::expect_doppelganger(
    "Theme with additional modifications",
    plot_modified
  )
})

test_that("ellipsis arguments are passed to theme_minimal", {
  # Test at ... fungerer ved å sende base_line_size
  theme_obj <- theme_pedr(base_line_size = 1.5)
  expect_s3_class(theme_obj, "theme")
})
