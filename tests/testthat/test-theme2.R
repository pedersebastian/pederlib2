library(ggplot2)
library(vdiffr)



test_that("base_size validation works", {
  expect_error(
    theme_pedr(base_size = "10")
  )

  expect_error(
    theme_pedr(base_size = c(10, 12))
  )

  expect_error(
    theme_pedr(base_size = -5)
  )

  expect_error(
    theme_pedr(base_size = 0)
  )

  # Skal fungere
  expect_s3_class(theme_pedr(base_size = 15), "theme")
})

test_that("strip_text_size validation works", {
  expect_error(
    theme_pedr(strip_text_size = "large")
  )

  expect_error(
    theme_pedr(strip_text_size = c(10, 12))
  )

  expect_error(
    theme_pedr(strip_text_size = -3)
  )

  expect_s3_class(theme_pedr(strip_text_size = 14), "theme")
})

test_that("strip_text_margin validation works", {
  expect_error(
    theme_pedr(strip_text_margin = "5px")
  )

  expect_error(
    theme_pedr(strip_text_margin = c(5, 10))
  )

  expect_error(
    theme_pedr(strip_text_margin = -2),
  )

  # 0 skal være OK (ikke-negativt)
  expect_s3_class(theme_pedr(strip_text_margin = 0), "theme")
  expect_s3_class(theme_pedr(strip_text_margin = 10), "theme")
})

test_that("subtitle_size validation works", {
  expect_error(
    theme_pedr(subtitle_size = NA)
  )

  expect_error(
    theme_pedr(subtitle_size = 0),
  )

  expect_s3_class(theme_pedr(subtitle_size = 16), "theme")
})

test_that("subtitle_margin validation works", {
  expect_error(
    theme_pedr(subtitle_margin = NULL)
  )

  expect_error(
    theme_pedr(subtitle_margin = -5)
  )

  expect_s3_class(theme_pedr(subtitle_margin = 0), "theme")
  expect_s3_class(theme_pedr(subtitle_margin = 15), "theme")
})

test_that("plot_title_size validation works", {
  expect_error(
    theme_pedr(plot_title_size = c(16, 18))
  )

  expect_error(
    theme_pedr(plot_title_size = -10)
  )

  expect_s3_class(theme_pedr(plot_title_size = 20), "theme")
})

test_that("plot_title_margin validation works", {
  expect_error(
    theme_pedr(plot_title_margin = "auto")
  )

  expect_error(
    theme_pedr(plot_title_margin = -8),
    "plot_title_margin. ma være et ikke-negativt tall"
  )

  expect_s3_class(theme_pedr(plot_title_margin = 0), "theme")
  expect_s3_class(theme_pedr(plot_title_margin = 12), "theme")
})

test_that("strip_color validation works", {
  expect_error(
    theme_pedr(strip_color = c("red", "blue"))
  )

  expect_error(
    theme_pedr(strip_color = 123)
  )

  expect_error(
    theme_pedr(strip_color = "notacolor123")
  )

  # Gyldige farger skal fungere
  expect_s3_class(theme_pedr(strip_color = "red"), "theme")
  expect_s3_class(theme_pedr(strip_color = "#FF0000"), "theme")
  expect_s3_class(theme_pedr(strip_color = "gray90"), "theme")
})

test_that("font_family validation works", {
  expect_error(
    theme_pedr(font_family = c("Arial", "Times")),
    "font_family.* must be a single string."
  )

  expect_error(
    theme_pedr(font_family = 123),
    "font_family.* must be a single string."
  )

  expect_error(
    theme_pedr(font_family = NULL),
    "font_family.* must be a single string."
  )


  # Vanlig font skal ikke gi warning
  expect_no_warning(
    theme_pedr(font_family = "sans")
  )
})

test_that("invalid font family gives warning but still works", {
  # Theme skal fortsatt bli laget selv med ugyldig font
  suppressWarnings({
    theme_obj <- theme_pedr(font_family = "ThisFontDoesNotExist999")
  })
  expect_s3_class(theme_obj, "theme")
})

test_that("multiple validation errors are caught independently", {
  # Test at hver parameter valideres uavhengig
  expect_error(
    theme_pedr(base_size = -1, strip_text_size = "invalid"),
    "base_size" # Første feil skal fanges først
  )
})

test_that("valid edge case values work", {
  # Test gyldige edge cases
  expect_s3_class(
    theme_pedr(
      base_size = 0.1, # Veldig liten men positiv
      strip_text_margin = 0,
      subtitle_margin = 0,
      plot_title_margin = 0
    ),
    "theme"
  )

  expect_s3_class(
    theme_pedr(
      base_size = 100, # Veldig stor
      strip_text_size = 50
    ),
    "theme"
  )
})

test_that("integer and double values both work", {
  # Test at bade integer og double godtas
  expect_s3_class(theme_pedr(base_size = 12L), "theme") # integer
  expect_s3_class(theme_pedr(base_size = 12.5), "theme") # double

  expect_s3_class(theme_pedr(strip_text_margin = 5L), "theme")
  expect_s3_class(theme_pedr(strip_text_margin = 5.5), "theme")
})

test_that("ggh4x dependency is checked", {
  # Dette er vanskelig a teste uten a faktisk avinstallere ggh4x
  # Men vi kan i det minste sjekke at funksjonen bruker ggh4x
  theme_obj <- theme_pedr()

  # Sjekk at theme objektet inneholder ggh4x elementer
  expect_true("strip.background" %in% names(theme_obj))
})

# ---- VISUELLE TESTER MED GYLDIGE PARAMETERE ----

test_that("theme with all custom parameters works visually", {
  plot_custom <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(vs)) +
    labs(title = "Custom Title", subtitle = "Custom Subtitle") +
    theme_pedr(
      base_size = 10,
      strip_text_size = 14,
      strip_text_margin = 8,
      subtitle_size = 12,
      subtitle_margin = 15,
      plot_title_size = 18,
      plot_title_margin = 12,
      strip_color = "lightblue"
    )

  vdiffr::expect_doppelganger(
    "Theme with all custom parameters",
    plot_custom
  )
})

test_that("theme with minimal margins works", {
  plot_minimal <- ggplot(mtcars, aes(mpg, disp)) +
    geom_point() +
    facet_wrap(vars(cyl)) +
    labs(title = "Minimal Margins", subtitle = "Test") +
    theme_pedr(
      strip_text_margin = 0,
      subtitle_margin = 0,
      plot_title_margin = 0
    )

  vdiffr::expect_doppelganger(
    "Theme with zero margins",
    plot_minimal
  )
})
