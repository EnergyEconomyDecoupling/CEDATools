test_that("sample_ceda_data_path() works correctly", {
  # Get tmp data for Ghana
  res <- sample_ceda_data_path(country = "Ghana", metric = "tmp", version = 2020)
  expected <- file.path("extdata", "CEDA Data", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per")
  expect_true(endsWith(res, expected))


  # **** Zeke build better tests ****
  # * metric = "xx": should fail expect_error()
  # * All paths for GHA and ZAF and all 3 metrics
  # * Other versions (2021)
  # * Other countries (CEDA names)

})
