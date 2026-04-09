test_that("komma() returns a function", {
  expect_true(is.function(komma()))
})

test_that("komma() formats integers with Norwegian thousands separator", {
  fmt <- komma()
  expect_equal(fmt(1000), "1.000")
  expect_equal(fmt(1000000), "1.000.000")
})

test_that("komma() formats decimals with Norwegian notation", {
  fmt <- komma(accuracy = 0.1)
  expect_equal(fmt(1000.5), "1.000,5")
  expect_equal(fmt(0.5), "0,5")
})

test_that("komma() passes accuracy to scales::comma_format", {
  fmt <- komma(accuracy = 0.01)
  expect_equal(fmt(1000.5), "1.000,50")
})

test_that("list_locale() returns a sorted character vector", {
  skip_on_os("windows")
  result <- list_locale()
  expect_type(result, "character")
  expect_true(length(result) > 0)
  expect_equal(result, sort(result))
})

test_that("list_locale() errors on Windows", {
  skip_on_os(c("mac", "linux", "solaris"))
  expect_error(list_locale())
})

test_that("to_tribble() emits a message", {
  expect_message(to_tribble())
})
