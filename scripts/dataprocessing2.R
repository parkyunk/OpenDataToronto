#### Preamble ####
# Purpose: Clean the survey data downloaded from OpenDataToronto
# Author: Yunkyung Park
# Data: February 6, 2021
# Contact: clara.park@mail.utoronto.ca

#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)

# get package
package <- show_package("6db96adf-d8a8-465b-a7e8-29be98907cc9")

# get all resources for this package
resources <- list_package_resources("6db96adf-d8a8-465b-a7e8-29be98907cc9")

datastore_resources2 <- filter(resources, tolower(format) %in% c('xlsx'))

installation2 <- filter(datastore_resources2, row_number()==1) %>%
  get_resource()

colnames(installation2) <- installation2[c(2),]

installation2 <- installation2[-c(1:2),]

cleaned <-
  clean_names(installation2) %>%
  select(-coordinates)

write_csv(
  x = installation2,
  file = "renewable_energy_installation2.csv"
)