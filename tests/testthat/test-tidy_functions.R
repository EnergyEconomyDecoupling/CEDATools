# Loads required packages
library(testthat)

# This tests the function read_ceda_file()
test_that("read_ceda_file() works", {

  # Defines a file path for CEDA 2020 tmp Actaeon_Group data to test
  test_filepath = paste0(PFUSetup::get_abs_paths()$project_path,
                         "/Data/CEDA Data/CEDA_2020/tmp/crucy.v4.04.1901.2019.Actaeon_Group.tmp.per",
                         sep ="")


  test_data <- read_ceda_file(ceda_file = test_filepath)


  expect_true(!is.null(test_data))
  expect_true(identical(colnames(test_data),
                        c("Country", "YEAR", "JAN", "FEB", "MAR", "APR", "MAY",
                          "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "MAM",
                          "JJA", "SON", "DJF", "ANN")) == TRUE
              )



})


# test_that("read_ceda_files() works as expected", {
#
#   test_2 <- tibble::tribble(~COUNTRY, ~YEAR, ~JAN, ~FEB, ~MAR, ~APR, ~MAY, ~JUN. ~JUL,
#                             ~AUG, ~SEP, ~OCT, ~NOV, ~DEC, ~MAM, ~JJA, ~SON,
#                             ~DJF, ~ANN,
#                             "Actaeon_Group", 1901, 26.1, 26.5, 26.5, 25.9, 24.6, 23.5, 22.9,
#                             22.6, 22.8, 23.5, 24.4, 25.2, 25.6, 23.0, 23.6,
#                             25.9, 24.5)
#   read_ceda_files()
#
#   expect_true(!is.null(test_2))
#   expect_true(length(unique(test_2$)))
#
#
# })

# tmp_2019 <- read_ceda_files(ceda_metric = "tmp", ceda_year = 2019)
#
# tmx_2019 <- read_ceda_files(ceda_metric = "tmx", ceda_year = 2019)
#
# tmp_2020 <- read_ceda_files(ceda_metric = "tmp", ceda_year = 2020)
#
# tmx_2020 <- read_ceda_files(ceda_metric = "tmx", ceda_year = 2020)



#####################################################################################################################
