% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidy_functions.R
\name{read_cru_cy_files}
\alias{read_cru_cy_files}
\title{Read all cru_cy text files for a particular metric}
\usage{
read_cru_cy_files(
  cru_cy_folder,
  cru_cy_metric,
  cru_cy_year,
  jan_col = CEDATools::cru_cy_colnames$JAN,
  ann_col = CEDATools::cru_cy_colnames$ANN
)
}
\arguments{
\item{cru_cy_folder}{path to a folder contains all cru_cy data folders.}

\item{cru_cy_metric}{three-letter code used to identify filename to read and write.}

\item{cru_cy_year}{identifies the year of the CEDA data to loaded.}

\item{jan_col}{the column name "JAN".}

\item{ann_col}{the column name "ANN".}
}
\value{
a tibble with five columns: Country, Metric, Year, Month, Value.
}
\description{
Read all cru_cy (Climate Research Unit Country) files for a particular metric and bind to create a single tibble.
Data is drawn from a directory supplied by the user, likely created through the down_cru_cy_files function.
}
