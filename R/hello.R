# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

hello <- function() {
  print("Hello, world!")
}
usethis::use_git()
usethis::use_github()
usethis::use_tidy_github()
usethis::use_tidy_github_actions()
usethis::use_tidy_github_labels()
usethis::use_pkgdown_github_pages()
