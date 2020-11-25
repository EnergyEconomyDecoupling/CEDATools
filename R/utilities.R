#' Title
#'
#' @param country
#' @param metric One of "tmp" (for mean monthly temperature),
#'               "tmn" (for mean monthly daily minimum temperature), or
#'               "tmx" (for mean monthly daily maximum temperature).
#' @param version An integer representing the year in which CEDA data were released.
#'                E.g., `2020` means data up through year 2019 that were released in the year 2020.
#'
#' @return
#'
#' @export
#'
#' @examples
sample_ceda_data_path <- function(country = c("Ghana", "South_Africa"),
                                  metric = c("tmp", "tmn", "tmx"),
                                  version = 2020) {

  # Need to check that the value of country  is one of the options given.
  country <- match.arg(country)

    # Need to check that the value of metric is one of the options given.
  metric <- match.arg(metric)

  # Ensure that version year is correct.
  assertthat::assert_that(version == 2020, msg = "Only 2020 is supported in sample_ceda_data_path()")

  # Build the file paths as we go.
  fn_prefix <- "crucy.v4.04.1901."
  fn_prefix_with_date <- paste0(fn_prefix, version-1, ".")

  fn_prefix_with_country <- paste0(fn_prefix_with_date, country, ".")

  fp_with_metric <- lapply(metric, FUN = function(m) {
    file.path(m, paste0(fn_prefix_with_country, m, ".per"))
  }) %>% unlist()

  lapply(fp_with_metric, FUN = function(fpwm) {
    system.file(file.path("extdata", "CEDA Data", paste0("CEDA_", version), fpwm), package = "CEDATools")
  }) %>% unlist()
}
