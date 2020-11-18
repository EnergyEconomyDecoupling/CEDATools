# Loads required packages
library(RCurl)

down_cru_cy_data <- function (username, password, cru_cy_metric, cru_cy_folder) {

# cru_cy_metrics <- c("cld" = Cloud_cover,
#                     "dtr" = Diurnal_temperature_range,
#                     "frs" = Ground_frost_frequency,
#                     "pet" = Potential_evapotranspiration,
#                     "pre" = precipitation,
#                     "tmn" = Near_surface_temperature_minimum,
#                     "tmp" = Near_surface_temperature,
#                     "tmx" = Near_surface_temperature_maximum,
#                     "vap" = Vapour_pressure,
#                     "wet" = Wet_day_frequency)

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
con <- getCurlHandle(ftp.use.epsv = TRUE, userpwd = up)

# Downloads all countries into dest_file
for(file in links) {
  writeBin(getBinaryURL(file, curl = con, dirlistonly = FALSE),
           paste(dest_file, substr(file, nchar(url), nchar(file)), sep = ""))
  }
}
