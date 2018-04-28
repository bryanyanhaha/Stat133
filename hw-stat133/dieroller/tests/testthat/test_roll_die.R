context("Check die arguments")



test_that("check_sides with right vectors", {

  expect_true(check_sides(1:6))
})


test_that("check_sides with invalid lengths", {

  expect_error(check_sides(c('8', 'two', 'three')))
  expect_error(check_sides(c('kay')))
  expect_error(check_sides(1:10))
  expect_error(check_sides(6))
})


test_that("check_sides fails with invalid types", {

  expect_error(check_sides(c('one', 'two', 'three')))
  expect_error(check_sides(c('one')),
               "\n'prob' must be a vector of length 6")
})


test_that("check_prob works with ok vectors", {

  expect_true(check_prob(rep(1/6, 6)))
})


test_that("check_prob fails with invalid lengths", {

  expect_error(check_prob(1:5))
  expect_error(check_prob(1))
})


test_that("check_prob fails with invalid numbers", {

  expect_error(check_prob(0.1, 0.1, 0.1, 0.1, 0.1, 0.1))
})
