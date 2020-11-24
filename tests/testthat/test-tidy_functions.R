# This tests the function read_ceda_file()
test_that("read_cru_cy_file() works", {

  # Defines a single file path for a CEDA 2020 cru_cy file, namely tmp Actaeon_Group data, to test
  test_filepath = paste0(PFUSetup::get_abs_paths()$project_path,
                         "/Data/CEDA Data/CEDA_2020/tmp/crucy.v4.04.1901.2019.Actaeon_Group.tmp.per",
                         sep ="")


  ag_tmp <- read_cru_cy_file(cru_cy_file = test_filepath)


  expect_true(!is.null(ag_tmp))
  expect_true(identical(colnames(ag_tmp),
                        c("Country", "YEAR", "JAN", "FEB", "MAR", "APR", "MAY",
                          "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "MAM",
                          "JJA", "SON", "DJF", "ANN")) == TRUE
              )
})


test_that("read_cru_cy_files() works as expected", {


  tmp_data_2020 <- read_cru_cy_files(cru_cy_folder = file.path(PFUSetup::get_abs_paths()$project_path,
                                                               "Data", "CEDA Data"),
                                     cru_cy_metric = "tmp", cru_cy_year = 2020)

  expect_true(!is.null(tmp_data_2020))
  expect_true(unique(tmp_data_2020$Metric) == "tmp")
  expect_true(max(tmp_data_2020$YEAR) == 2019)
  expect_true(identical(colnames(tmp_data_2020),
                        c("Country", "PFU_Country_Code", "Metric", "YEAR", "JAN",
                          "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP",
                          "OCT", "NOV", "DEC", "MAM", "JJA", "SON", "DJF", "ANN")
                        ) == TRUE)
})
