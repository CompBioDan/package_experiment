## 'standardise_counts' ----------------------------------------------------------------

test_that("'standardise_counts' returns ERROR with invalid dataframe columns", {
  df <- data.frame(
    region = c("a", "b", "c", "d"),
    time = c(2011, 2011, 2011, 2011),
    # sex = c("Male", "Female", "Male", "Female"),
    age = c(50, 50, 50, 50),
    count = c(96.3, 49.6, 20.2, 68.9)
  )
  expect_error(standardise_counts(df))
})


test_that("'setup_input_counts' returns correct stocks dataframe if valid stock provided", {

  input_stocks <- data.frame(
    region = c("a", "a", "a", "a"),
    time = c(2011, 2011, 2011, 2011, 2012, 2012, 2012, 2012),
    sex = c("Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
    age = c(1, 1, 2, 2, 1, 1, 2, 2),
    count = c(96.3, 49.6, 20.2, 68.9, 96.3, 49.6, 20.2, 68.9)
  )

  output_stocks <- data.frame(
    region = c("a", "a"),
    time = c(2011, 2011),
    sex = c("Male", "Female"),
    age = c(1, 1),
    count = c(96.3, 49.6)
  )

    expect_equal(standardise_counts(input_stocks, c(2011), c(1)),
                 output_stocks)
})


test_that("'apply_base_sd' returns ERROR with invalid dataframe columns", {
  df <- data.frame(
    region = c("a", "b", "c", "d"),
    time = c(2011, 2011, 2011, 2011),
    sex = c("Male", "Female", "Male", "Female"),
    # sd = c(0.1, 0.7, 1.6, 6.2),
    age = c(50, 50, 50, 50)
  )
  baseline_sd <- 1
  expect_error(apply_base_sd(
    df,
    baseline_sd
  ))
})

test_that("'apply_base_sd' returns dataframe with correct baseline SD", {
  df <- data.frame(
    region = c("a", "b", "c", "d"),
    time = c(2011, 2011, 2011, 2011),
    sex = c("Male", "Female", "Male", "Female"),
    sd = c(0.1, 0.7, 1.6, 6.2),
    age = c(50, 50, 50, 50)
  )
  baseline_sd <- 1
  expect_equal(
    apply_base_sd(
      df,
      baseline_sd
    ),
    data.frame(
      region = c("a", "b", "c", "d"),
      time = c(2011, 2011, 2011, 2011),
      sex = c("Male", "Female", "Male", "Female"),
      sd = c(1, 1, 1.6, 6.2),
      age = c(50, 50, 50, 50)
    )
  )

  df <- data.frame(
    region = c("a", "b", "c", "d"),
    time = c(2011, 2011, 2011, 2011),
    sex = c("Male", "Female", "Male", "Female"),
    sd = c(NA, NA, 1.6, 6.2),
    age = c(50, 50, 50, 50)
  )
  baseline_sd <- 1
  expect_equal(
    apply_base_sd(
      df,
      baseline_sd
    ),
    data.frame(
      region = c("a", "b", "c", "d"),
      time = c(2011, 2011, 2011, 2011),
      sex = c("Male", "Female", "Male", "Female"),
      sd = c(1, 1, 1.6, 6.2),
      age = c(50, 50, 50, 50)
    )
  )
})
