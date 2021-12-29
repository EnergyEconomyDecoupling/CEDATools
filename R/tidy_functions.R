#' Read a single CEDA cru_cy text file
#'
#' Establishes a function which reads an individual CEDA .per (text) file
#'
#' @param cru_cy_file a file path to a .per text file downloaded from CEDA
#' @param year_col the column name "YEAR".
#'
#' @return a tibble containing climate data for a single country
#' @export read_cru_cy_file
#'
read_cru_cy_file <- function (cru_cy_file,
                              year_col = CEDATools::cru_cy_colnames$YEAR
                              ) {

  readr::read_table(file = cru_cy_file,
                    col_types = readr::cols(.default = readr::col_double()),
                    skip = 3) |>
    tibble::tibble() |>
    dplyr::mutate(Country = substr(basename(cru_cy_file), 23, nchar(basename(cru_cy_file))-8), .before = year_col)

}


#' Read all cru_cy text files for a particular metric
#'
#' Read all cru_cy (Climate Research Unit Country) files for a particular metric and bind to create a single tibble.
#' Data is drawn from a directory supplied by the user, likely created through the down_cru_cy_files function.
#'
#' @param cru_cy_folder path to a folder contains all cru_cy data folders.
#' @param cru_cy_metric three-letter code used to identify filename to read and write.
#' @param cru_cy_year identifies the year of the CEDA data to loaded.
#' @param jan_col the column name "JAN".
#' @param ann_col the column name "ANN".
#'
#' @return a tibble with five columns: Country, Metric, Year, Month, Value.
#'
#' @export read_cru_cy_files
#'
read_cru_cy_files <- function(cru_cy_folder, cru_cy_metric, cru_cy_year,
                              jan_col = CEDATools::cru_cy_colnames$JAN,
                              ann_col = CEDATools::cru_cy_colnames$ANN) {

  dest_file <- file.path(cru_cy_folder, paste0("CEDA_", cru_cy_year), cru_cy_metric)

  dirs <- paste0(dest_file, "/", list.files(path = dest_file), sep = "")

  do.call(rbind, purrr::map(dirs, CEDATools::read_cru_cy_file)) |>
    dplyr::mutate(Metric = cru_cy_metric, .after = "Country") |>
    tidyr::pivot_longer(cols = jan_col:ann_col,
                        names_to = "Month",
                        values_to = "Value")

}



#' Create a dataframe containing multiple cru_cy metrics
#'
#' Reads all cru_cy (Climate Research Unit Country) files for a multiple metrics and binds to create a single tibble.
#' Data is drawn from a directory supplied by the user, likely created through the down_cru_cy_files function.
#'
#' @param agg_cru_cy_folder path to a folder contains all cru_cy data folders,
#' passed to the `cru_cy_folder` argument in `read_cru_cy_files`
#' @param agg_cru_cy_metrics a character string of metrics which is iterated over with `read_cru_cy_files`
#' using `lapply`
#' @param agg_cru_cy_year identifies the year of the CEDA data to loaded,
#' passed to the `cru_cy_year` argument in `read_cru_cy_files`
#'
#' @return a tibble with five columns: Country, Metric, Year, Month, Value.
#' In contrast to `read_cru_cy_files` there may be multiple metrics if `length(agg_cru_cy_metrics) > 1`.
#'
#' @export create_agg_cru_cy_df
#'
create_agg_cru_cy_df <- function(agg_cru_cy_folder, agg_cru_cy_metrics, agg_cru_cy_year) {

  agg_cru_cy_df <- lapply(agg_cru_cy_metrics,
                          CEDATools::read_cru_cy_files,
                          cru_cy_folder = agg_cru_cy_folder,
                          cru_cy_year = agg_cru_cy_year) |>
    data.table::rbindlist() |>
    tibble::as_tibble()

}

















