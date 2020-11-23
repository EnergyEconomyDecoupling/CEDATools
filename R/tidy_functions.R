# This script contains functions which read the cru_cy raw .per (text) tiles downloaded via FTP from CEDA,
# tidies them, and combines them into a single tibble


#' Establishes a function which reads an individual CEDA .per (text) file
#'
#' @param cru_cy_file a file path to a .per text file downloaded from CEDA
#'
#' @return a tibble containing climate data for a single country
#' @export
#'
#' @examples actaeon_group_temp_data <- read_cru_cy_file(cru_cy_file = "C:/CEDA Data/CEDA_2020/tmp/crucy.v4.04.1901.2019.Actaeon_Group.tmp.per")
#'
read_cru_cy_file <- function (cru_cy_file) {
  readr::read_table2(cru_cy_file,
                     col_types = readr::cols(YEAR = readr::col_double(),
                                             JAN = readr::col_double(), FEB = readr::col_double(),
                                             MAR = readr::col_double(), APR = readr::col_double(),
                                             MAY = readr::col_double(), JUN = readr::col_double(),
                                             JUL = readr::col_double(), AUG = readr::col_double(),
                                             SEP = readr::col_double(), OCT = readr::col_double(),
                                             NOV = readr::col_double(), DEC = readr::col_double(),
                                             MAM = readr::col_double(), JJA = readr::col_double(),
                                             SON = readr::col_double(), DJF = readr::col_double(),
                                             ANN = readr::col_double()
                     ),
                     skip = 3) %>%
    tibble::tibble() %>%
    dplyr::mutate(Country = substr(basename(cru_cy_file), 23, nchar(basename(cru_cy_file))-8), .before = YEAR)
}


#' Read all cru_cy (Climate Research Unit Country) files for a particular metric and bind to create a single tibble
#'
#' Zeke will add more description here.
#'
#' @param cru_cy_folder path to a folder contains cru_cy data files.
#' @param cru_cy_metric three-letter code used to identify filename to read and write.
#' @param cru_cy_year identifies the year of the CEDA data to loaded.
#'
#' @return a tibble with columns containing the CEDA Country name parsed from file names,
#' the ISO country code which corresponds to PFU database, the metric read using the function,
#' and climate data for the selected metric for each of the months,
#' the mean over each of the four seasons, and a yearly mean.
#'
#' @export
#'
#' @examples temp_data <- read_cru_cy_file(cru_cy_folder = "C:/CEDA Data", cru_cy_metric = "tmp", cru_cy_year = 2020)
#'
read_cru_cy_files <- function(cru_cy_folder, cru_cy_metric, cru_cy_year) {

  dest_file <- file.path(cru_cy_folder, paste0("CEDA_", cru_cy_year), cru_cy_metric)

  country_mapping_path <- paste(PFUSetup::get_abs_paths()$project_path,
                                "/Mapping/Country_Mapping_2020.xlsx", sep = "")

  CEDA_mapping <- readxl::read_excel(country_mapping_path,
                                   sheet = "CEDA_PFU") %>%
    tibble::tibble() %>%
    dplyr::select(CEDA_name, `2018`) %>%
    magrittr::set_colnames(c("Country", "PFU_Country_Code"))

  dirs <- paste0(dest_file, "/", list.files(path = dest_file), sep = "")

  do.call(rbind, purrr::map(dirs, read_cru_cy_file)) %>%
    dplyr::left_join(CEDA_mapping, by = "Country") %>%
    dplyr::relocate(PFU_Country_Code, .after = "Country") %>%
    dplyr::mutate(Metric = cru_cy_metric, .after = "PFU_Country_Code")

}
