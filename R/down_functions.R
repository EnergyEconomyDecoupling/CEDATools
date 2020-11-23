#' The function cru_cy_metrics downloads the latest (2020) Climate Research Unit
#' Country-Level datasets (cru_cy) (http://data.ceda.ac.uk/badc/cru/data/cru_cy/cru_cy_4.04/data)
#' from CEDA via FTP (ftp://ftp.ceda.ac.uk/badc/cru/data/cru_cy/cru_cy_4.04/data/).
#' Users must first create an account with CEDA.
#' The following metrics are available, and are denoted by three letter codes:
#' "cld" = Cloud cover,
#' "dtr" = Diurnal temperature range,
#' "frs" = Ground frost frequency,
#' "pet" = Potential evapotranspiration,
#' "pre" = Precipitation,
#' "tmn" = Near surface temperature minimum,
#' "tmp" = Near surface temperature,
#' "tmx" = Near surface temperature maximum,
#' "vap" = Vapour pressure,
#' "wet" = Wet day frequency
#'
#' @param username the username for a user-created CEDA account
#' @param password the password for a user-created CEDA account
#' @param cru_cy_metric the three letter metric code the user wishes to download
#' @param cru_cy_folder the filepath for the data to be downloaded in
#'
#' @return
#' @export down_cru_cy_data
#'
#' @examples
#'
down_cru_cy_data <- function (username, password, cru_cy_metric, cru_cy_folder) {


# Establishes FTP url for CEDA mean temperature (tmp)
url <- paste0("ftp://ftp.ceda.ac.uk/badc/cru/data/cru_cy/cru_cy_4.04/data/", cru_cy_metric, "/")

# Establishes destination directory for files
dest_file <- file.path(cru_cy_folder, cru_cy_metric)

# Creates the dest_file directory if it does not exist
if (dir.exists(dest_file) == FALSE) {
  dir.create(dest_file)
}

# protocol <- "sftp"

# Sets username and password
up <- paste0(username, ":", password)

# Parses file names
filenames <- RCurl::getURL(url, userpwd = up,
                           ftp.use.epsv = TRUE, dirlistonly = TRUE)

# Separates file names and pastes the FTP URL to create a list of individual FTP links
links <- paste(url, strsplit(filenames, "\r*\n")[[1]], sep = "")

# Generates curl handle
con <- RCurl::getCurlHandle(ftp.use.epsv = TRUE, userpwd = up)

# Downloads all countries into dest_file
for(file in links) {
  writeBin(RCurl::getBinaryURL(file, curl = con, dirlistonly = FALSE),
           paste(dest_file, substr(file, nchar(url), nchar(file)), sep = ""))
  }
}
