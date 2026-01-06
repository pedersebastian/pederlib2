library(ggplot2)
library(vdiffr)



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
