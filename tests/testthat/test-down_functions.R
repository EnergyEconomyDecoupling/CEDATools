test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


down_cru_cy_data(username = "zmarshall",
                 password = "ParrotIron4",
                 cru_cy_metric = "wet",
                 cru_cy_folder = file.path(PFUSetup::get_abs_paths()$project_path,
                                           "Data", "CEDA Data", "CEDA_2020")
)

username = "zmarshall"
password = "ParrotIron4"
cru_cy_metric = "vap"
