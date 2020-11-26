# This tests the function read_ceda_file()
test_that("read_cru_cy_file() works", {

  # Defines a single file path for a CEDA 2020 cru_cy file, namely tmp Actaeon_Group data, to test
  test_filepath = sample_ceda_data_path(country = "Ghana",
                                        metric = "tmp")


  GHN_tmp <- read_cru_cy_file(cru_cy_file = test_filepath)


  expect_true(!is.null(GHN_tmp))
  expect_true(identical(colnames(GHN_tmp),
                        c("Country", "YEAR", "JAN", "FEB", "MAR", "APR", "MAY",
                          "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "MAM",
                          "JJA", "SON", "DJF", "ANN")) == TRUE)
})


test_that("read_cru_cy_files() works as expected", {


  GHN_ZAF_tmp <- read_cru_cy_files(cru_cy_folder = sample_ceda_data_folder(),
                                   cru_cy_metric = "tmp", cru_cy_year = 2020)

  expect_true(!is.null(GHN_ZAF_tmp))
  expect_true(unique(GHN_ZAF_tmp$Metric) == "tmp")
  expect_true(max(GHN_ZAF_tmp$YEAR) == 2019)
  expect_true(identical(colnames(GHN_ZAF_tmp),
                        c("Country", "Metric", "YEAR", "Month", "Value")
                        ) == TRUE)
})

test_that("create_agg_cru_cy_df() works as expected", {

  tmp_tmn_tmx <- create_agg_cru_cy_df(agg_cru_cy_folder = sample_ceda_data_folder(),
                                                agg_cru_cy_metrics = c("tmp", "tmn", "tmx"),
                                                agg_cru_cy_year = 2020)

  expect_true(!is.null(tmp_tmn_tmx))
  expect_equal(object = unique(tmp_tmn_tmx$Metric), expected = c("tmp", "tmn", "tmx"))
  expect_true(max(tmp_tmn_tmx$YEAR) == 2019)
  expect_true(identical(colnames(tmp_tmn_tmx), c("Country", "Metric", "YEAR", "Month", "Value")) == TRUE)
})

