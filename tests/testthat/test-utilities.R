test_that("sample_ceda_data_path() works correctly", {
  # Get tmp data for Ghana
  res <- sample_ceda_data_path(country = "Ghana", metric = "tmp", version = 2020)
  expected <- file.path("extdata", "CEDA Data", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per")
  expect_true(endsWith(res, expected))



  expect_error(sample_ceda_data_path(metric = "xx"),
               regexp = "'arg' should be one of “tmp”, “tmn”, “tmx”")

  # **** Zeke build better tests ****
  # * All paths for GHA and ZAF and all 3 metrics
  # * Other versions (2021)
  # * Other countries (CEDA names)
  # * Test for a bad country name

  # * Fill rest of description
  # * Use the new path function in all tests
  #   to become independent of Dropbox

})
