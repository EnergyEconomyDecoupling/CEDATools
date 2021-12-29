# This script creates constants and saves them in the right locations.
# If there are any changes to these constants,
# source this script before building the package.


#
# Names of columns in CEDA cru_cy data
#

cru_cy_colnames <- list(YEAR = "YEAR",
                        JAN = "JAN",
                        FEB = "FEB",
                        MAR = "MAR",
                        APR = "APR",
                        MAY = "MAY",
                        JUN = "JUN",
                        JUL = "JUL",
                        AUG = "AUG",
                        SEP = "SEP",
                        OCT = "OCT",
                        NOV = "NOV",
                        DEC = "DEC",
                        MAM = "MAM",
                        JJA = "JJA",
                        SON = "SON",
                        DJF = "DJF",
                        ANN = "ANN"
                        )
usethis::use_data(cru_cy_colnames, overwrite = TRUE)





