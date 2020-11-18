# # Loads required packages
# library(RCurl)
#
# down_cru_cy_data <- function (username, password, metric) {
#
# cru_cy_metrics <- c(cld = "Cloud cover",
#                     dtr = "Diurnal temperature range",
#                     frs = "Ground frost frequency",
#                     pet = "Potential evapotranspiration",
#                     pre = "precipitation",
#                     tmn = "Near-surface temperature minimum",
#                     tmp = "Near-surface temperature",
#                     tmx = "Near-surface temperature maximum",
#                     "Vapour pressure" = "vap",
#                     #vap = "Vapour pressure",
#                     wet = "Wet day frequency")
#
# # Establishes FTP url for CEDA mean temperature (tmp)
# url <- paste0("ftp://ftp.ceda.ac.uk/badc/cru/data/cru_cy/cru_cy_4.04/data/", metric)
#
# # Establishes destination directory for files
# dest_file <- paste0(PFUSetup::get_abs_paths()$project_path, "/Data/Temperature Data/CEDA_2020/", metric)
#
# # protocol <- "sftp"
#
# # Sets username and password
# # up <- "zmarshall:ParrotIron4"
# up <- paste0(username, ":", password)
#
# # Parses file names
# filenames <- RCurl::getURL(url, userpwd = up,
#                                ftp.use.epsv = TRUE, dirlistonly = TRUE)
#
# # Separates file names and pastes the FTP URL to create a list of individual FTP links
# links <- paste(url, strsplit(filenames, "\r*\n")[[1]], sep = "")
#
# # Generates curl handle
# con <- getCurlHandle(ftp.use.epsv = TRUE, userpwd = up)
#
# # Downloads all countries into dest_file
# for(file in links) {
#   writeBin(getBinaryURL(file, curl = con, dirlistonly = FALSE),
#            paste(dest_file, substr(file, nchar(url), nchar(file)), sep = ""))
#   }
# }
#
# down_cru_cy_data(username = "zmarshall", password = "ParrotIron4", metric = "Vapour pressure")
#
#
