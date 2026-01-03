test_that(
  "Checking clean version",
  {
    expect_setequal(
      .packages(),
      base_pkg
    )
  }
)


test_that(
  "Check package actually attached",
  {
    skip_if_not_installed("tidyverse")
    expect_setequal(
      startup(quiet = TRUE),
      type_1_pkg
    )

    skip_if_not_installed("tidymodels")
    expect_setequal(
      startup(2, quiet = TRUE),
      c(type_1_pkg, type_2_pkg)
    )
  }
)
