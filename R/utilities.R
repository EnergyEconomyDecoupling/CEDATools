#' Establish a user-independent file path to the sample CEDA cru_cy data bundled in CEDATools
#'
#' @return a file path to bundled CEDA cru_cy data for tmp (Near surface temperature),
#'         tmn (Near surface temperature minimum), tmx (Near surface temperature maximum)
#'         for Ghana and South Africa.
#'         This path is unique indpendent of the user/machine.
#' @export
#'
sample_ceda_data_folder <- function() {
  system.file(file.path("extdata", "CEDA Data"), package = "CEDATools")
}


#' Create a list of file paths to CEDA cru_cy files
#'
#' @param ceda_data_folder The file path to the folder containing the cru_cy CEDA Data,
#'                         specificially a folder named "CEDA Data".
#'                         By default this is set to `sample_ceda_data_folder`,
#'                         but any file path leading to the "CEDA Data" folder can be used.
#'                         Note that the data must be present in a folder in CEDA Data/CEDA_2020
#'                         with the corresponding metric code.
#' @param country Any of the countries present in cru_cy CEDA files,
#'                note that some country names are unique to CEDA,
#'                as they are taken from the file names, and contain underscores,
#'                and abbreviations such as "Isl" for "Islands".
#' @param metric One of:"cld" = Cloud cover,
#'                      "dtr" = Diurnal temperature range,
#'                      "frs" = Ground frost frequency,
#'                      "pet" = Potential evapotranspiration,
#'                      "pre" = Precipitation,
#'                      "tmn" = Near surface temperature minimum,
#'                      "tmp" = Near surface temperature,
#'                      "tmx" = Near surface temperature maximum,
#'                      "vap" = Vapour pressure,
#'                      "wet" = Wet day frequency
#' @param version An integer representing the year in which CEDA data were released.
#'                E.g., `2020` means data up through year 2019 that were released in the year 2020.
#'
#' @return a list of file paths for selected cru_cy CEDA text files (.per), determined by metric and country.
#' @export
#'
ceda_data_path <- function(ceda_data_folder = sample_ceda_data_folder(),
                           country, # It may be good to create a csv with CEDA cru_cy country names, and include it in extdata
                           metric = c("cld", "dtr", "frs", "pet", "pre", "tmn", "tmp", "tmx", "vap", "wet"),
                           version = 2020) {

  # Need to check that the value of metric is one of the options given.
  metric <- match.arg(metric, several.ok = TRUE)

  # Build the file paths as we go.
  fn_prefix <- "crucy.v4.04.1901." # This is a 2020 string. May need to update later.
  fn_prefix_with_date <- paste0(fn_prefix, version-1, ".")

  fn_prefix_with_country <- paste0(fn_prefix_with_date, country, ".")

  fp_with_metric <- lapply(metric, FUN = function(m) {
    file.path(m, paste0(fn_prefix_with_country, m, ".per"))
  }) %>% unlist()

  lapply(fp_with_metric, FUN = function(fpwm) {
    file.path(ceda_data_folder, paste0("CEDA_", version), fpwm)
  }) %>% unlist()

}

#' Create a list of file paths to sample CEDA cru_cy files bundled in CEDATools
#'
#' @param country One of either "Ghana" or "South Africa",
#'                the two countries for sample data is bundled in CEDATools
#' @param metric One of:"tmn" = Near surface temperature minimum,
#'                      "tmp" = Near surface temperature,
#'                      "tmx" = Near surface temperature maximum.
#'               The three metrics for which there is sample data bundled in CEDATools
#' @param version An integer representing the year in which CEDA data were released.
#'                E.g., `2020` means data up through year 2019 that were released in the year 2020.
#'
#' @return A list of paths for the selected sample data,
#'         determined by the sample metric and sample countries selected.
#'
#' @export
#'
sample_ceda_data_path <- function(country = c("Ghana", "South_Africa"),
                                  metric = c("tmp", "tmn", "tmx"),
                                  version = 2020) {

  # Need to check that the value of country is one of the options given.
  country <- match.arg(country, several.ok = TRUE)

  # Need to check that the value of metric is one of the options given.
  metric <- match.arg(metric, several.ok = TRUE)

  # Ensure that version year is correct.
  assertthat::assert_that(version == 2020, msg = "Only 2020 is supported in sample_ceda_data_path()")


  ceda_data_path(ceda_data_folder = sample_ceda_data_folder(),
                 country = country,
                 metric = metric,
                 version = version)
}
