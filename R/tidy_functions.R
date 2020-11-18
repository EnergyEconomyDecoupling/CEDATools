# This script reads the raw .per (text) tiles downloaded via FTP from CEDA,
# tidies them, and combines them into a single data frame

# Loads required packages
library(tidyverse)
library(PFUSetup)


# Establishes a function which reads an individual CEDA .per (text) file
read_cru_cy_file <- function (cru_cy_file) {
  readr::read_table2(cru_cy_file,
                     col_types = cols(YEAR = col_double(),
                                      JAN = col_double(), FEB = col_double(),
                                      MAR = col_double(), APR = col_double(),
                                      MAY = col_double(), JUN = col_double(),
                                      JUL = col_double(), AUG = col_double(),
                                      SEP = col_double(), OCT = col_double(),
                                      NOV = col_double(), DEC = col_double(),
                                      MAM = col_double(), JJA = col_double(),
                                      SON = col_double(), DJF = col_double(),
                                      ANN = col_double()
                                      ),
                     skip = 3) %>%
    tibble::tibble() %>%
    dplyr::mutate(Country = substr(basename(cru_cy_file), 23, nchar(basename(cru_cy_file))-8), .before = YEAR)
}


# Establishes a function which uses read_ceda_file() to read all the CEDA files
# for a particular metric and binds them into a single tibble
read_cru_cy_files <- function (cru_cy_metric, cru_cy_year, data) {

  dest_file = paste0(PFUSetup::get_abs_paths()$project_path,
                         "/Data/CEDA Data/CEDA_", cru_cy_year, "/", cru_cy_metric, sep ="")

  country_mapping_path <- paste(PFUSetup::get_abs_paths()$project_path,
                                "/Mapping/Country_Mapping_2020.xlsx", sep = "")

  CEDA_mapping <- readxl::read_excel(country_mapping_path,
                                   sheet = "CEDA_PFU") %>%
    tibble::tibble() %>%
    dplyr::select(CEDA_name, `2018`) %>%
    magrittr::set_colnames(c("Country", "PFU_Country_Code"))

  dirs = paste0(dest_file, "/", list.files(path = dest_file), sep = "")

  data <- do.call(rbind, purrr::map(dirs, read_cru_cy_file)) %>%
    dplyr::left_join(CEDA_mapping, by = "Country") %>%
    dplyr::relocate(PFU_Country_Code, .after = "Country")

}
