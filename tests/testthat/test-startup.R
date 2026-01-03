

test_that(
  "sjekker at clean versjon er riktig",
  {
  expect_setequal(
    .packages(),
    base_pkg)
}
)
