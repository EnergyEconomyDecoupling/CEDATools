test_that("sample_ceda_data_folder() works correctly", {
  test_sample_folder <- sample_ceda_data_folder()
  expected_end_sample_folder <- file.path("extdata", "CEDA Data")
  expect_true(endsWith(test_sample_folder, expected_end_sample_folder))
})


test_that("sample_ceda_data_path() works correctly", {

  # Test paths match for Ghana tmp data
  # Get tmp data for Ghana
  GHN_tmp <- sample_ceda_data_path(country = "Ghana", metric = "tmp", version = 2020)

  # Test that the file path created for tmp data for Ghana matches expected path
  expected_GHN_tmp <- file.path("extdata", "CEDA Data", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per")
  expect_true(endsWith(GHN_tmp, expected_GHN_tmp))

  # Test all possible sample paths
  # Get all sample data
  all <- sample_ceda_data_path(country = c("Ghana", "South_Africa"), metric = c("tmp", "tmx", "tmn"), version = 2020)
  # Alternaticely just:
  # all <- sample_ceda_data_path()

  # Test that the file paths created for all sample data match expected paths for all sample data
  # Create list of expected file paths
  expected_all <- c(file.path("extdata", "CEDA Data", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per"),
                    file.path("extdata", "CEDA Data", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.South_Africa.tmp.per"),
                    file.path("extdata", "CEDA Data", "CEDA_2020", "tmx", "crucy.v4.04.1901.2019.Ghana.tmx.per"),
                    file.path("extdata", "CEDA Data", "CEDA_2020", "tmx", "crucy.v4.04.1901.2019.South_Africa.tmx.per"),
                    file.path("extdata", "CEDA Data", "CEDA_2020", "tmn", "crucy.v4.04.1901.2019.Ghana.tmn.per"),
                    file.path("extdata", "CEDA Data", "CEDA_2020", "tmn", "crucy.v4.04.1901.2019.South_Africa.tmn.per"))

  # Tests each element of the expected_all and all lists of filepaths. Is there a better way to do this?
  # expect_true(endsWith(all, expected_all))
  expect_true(endsWith(all[[1]], expected_all[[1]]))
  expect_true(endsWith(all[[2]], expected_all[[2]]))
  expect_true(endsWith(all[[3]], expected_all[[3]]))
  expect_true(endsWith(all[[4]], expected_all[[4]]))
  expect_true(endsWith(all[[5]], expected_all[[5]]))
  expect_true(endsWith(all[[6]], expected_all[[6]]))

  # Test for a bad country name
  expect_error(sample_ceda_data_path(metric = "xx"),
               regexp = "'arg' should be one of ")

  # Test for a bad metric
  expect_error(sample_ceda_data_path(country = "xx"),
               regexp = "'arg' should be one of ")


})


test_that("ceda_data_path() works correctly", {

  # Tests that the path for a single file (Ghana tmp) is as expected
  expect_equal(ceda_data_path(ceda_data_folder = "temp_folder",
                              country = "Ghana",
                              metric = "tmp",
                              version = 2020),
               file.path("temp_folder", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per"))

  # Tests that the paths for two files (two countries, one metric) are as expected.
  # This checks that mutliple values can be passed to the country argument.
  expect_equal(ceda_data_path(ceda_data_folder = "temp_folder",
                              country = c("Ghana", "South_Africa"),
                              metric = "tmp",
                              version = 2020),
               c(file.path("temp_folder", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per"),
                 file.path("temp_folder", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.South_Africa.tmp.per")))

  # Tests that the paths for six files (two countries, three metrics) are as expected.
  # This checks that multiple values can be passed to both the country, and the metric arguments.
  expect_equal(ceda_data_path(ceda_data_folder = "temp_folder",
                              country = c("Ghana", "South_Africa"),
                              metric = c("tmp", "tmn", "tmx"),
                              version = 2020),
               c(file.path("temp_folder", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.Ghana.tmp.per"),
                 file.path("temp_folder", "CEDA_2020", "tmp", "crucy.v4.04.1901.2019.South_Africa.tmp.per"),
                 file.path("temp_folder", "CEDA_2020", "tmn", "crucy.v4.04.1901.2019.Ghana.tmn.per"),
                 file.path("temp_folder", "CEDA_2020", "tmn", "crucy.v4.04.1901.2019.South_Africa.tmn.per"),
                 file.path("temp_folder", "CEDA_2020", "tmx", "crucy.v4.04.1901.2019.Ghana.tmx.per"),
                 file.path("temp_folder", "CEDA_2020", "tmx", "crucy.v4.04.1901.2019.South_Africa.tmx.per")))
})
