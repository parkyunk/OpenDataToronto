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

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))


# load the first datastore resource as a sample
installation <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

# clean column_names
cleaned_installation_data <- 
  clean_names(installation)

# select only the needed ones
cleaned_installation_data <-
  cleaned_installation_data %>%
  select(address_full, municipality, general_use_code, centreline_measure, 
         building_name, type_install, year_install, size_install)

# update typo in type_install
cleaned_installation_data <-
  cleaned_installation_data %>%
  mutate(
    type_install =
      recode(
        type_install,
        'MircoFIT' = 'MicroFIT',
        'MircoFIT A' = 'MicroFIT A'
      )
  )

write_csv(
  x = installation,
  file = "renewable_energy_installation.csv"
)