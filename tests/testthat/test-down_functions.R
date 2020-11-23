test_that("down_cru_cy_data() works", {

  down_cru_cy_data(username = "zmarshall",
                   password = "ParrotIron4",
                   cru_cy_metric = "pet",
                   cru_cy_folder = file.path(PFUSetup::get_abs_paths()$project_path,
                                             "Data", "CEDA Data", "CEDA_2020")
  )

  testthat::expect_true(length(list.files(file.path(PFUSetup::get_abs_paths()$project_path,
                                                    "Data", "CEDA Data", "CEDA_2020", "pet"))) > 1)
  testthat::expect_true(tools::file_ext(list.files(file.path(PFUSetup::get_abs_paths()$project_path,
                                                             "Data", "CEDA Data", "CEDA_2020", "pet"))[[1]]) == "per")

})

