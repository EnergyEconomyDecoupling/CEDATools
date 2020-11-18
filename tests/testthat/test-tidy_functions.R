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

  # ag_tmp_2 <- tibble::tribble(~COUNTRY, ~PFU_Country_Code, ~YEAR, ~JAN, ~FEB, ~MAR, ~APR, ~MAY, ~JUN. ~JUL,
  #                             ~AUG, ~SEP, ~OCT, ~NOV, ~DEC, ~MAM, ~JJA, ~SON,
  #                             ~DJF, ~ANN,
  #                             "Actaeon_Group", "", 1901, 26.1, 26.5, 26.5, 25.9, 24.6, 23.5, 22.9,
  #                             22.6, 22.8, 23.5, 24.4, 25.2, 25.6, 23.0, 23.6,
  #                             25.9, 24.5)

  tmp_data_2020 <- read_cru_cy_files(cru_cy_folder = file.path(PFUSetup::get_abs_paths()$project_path,
                                                               "Data", "CEDA Data"),
                                     cru_cy_metric = "tmp", cru_cy_year = 2020)

  expect_true(!is.null(tmp_data_2020))
  expect_true(tmp_data_2020$Metric == cru_cy_metric)
  expect_true(max(tmp_data_2020$YEAR) == cru_cy_year - 1)
  expect_true(identical(colnames(ag_tmp),
                        c("Country", "PFU_Country_Code", "Metric", "YEAR", "JAN",
                          "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP",
                          "OCT", "NOV", "DEC", "MAM", "JJA", "SON", "DJF", "ANN")
                        ) == TRUE)

})


# tmp_2019 <- read_cru_cy_files(cru_cy_folder = file.path(PFUSetup::get_abs_paths()$project_path, "Data", "CEDA Data"),
#                                                         cru_cy_metric = "tmp", cru_cy_year = 2019)
#
# tmx_2019 <- read_cru_cy_files(cru_cy_metric = "tmx", cru_cy_year = 2019)
#
# tmp_2020 <- read_cru_cy_files(cru_cy_metric = "tmp", cru_cy_year = 2020)
#
# tmx_2020 <- read_cru_cy_files(cru_cy_metric = "tmx", cru_cy_year = 2020)



#####################################################################################################################
