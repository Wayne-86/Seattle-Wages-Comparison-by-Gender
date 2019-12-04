# Interactive Visualizations
# Heat map showing the frequency of incidents
#----------------------------------------------
# install.packages("dplyr")
# install.packages("leaflet")
# install.packages("leaflet.extras")
#----------------------------------------------
library("dplyr")
library("leaflet")
library("leaflet.extras")

source("./source/fire_response_api_functions.R")
source("./source/fire_response_api_key.R")

# Create a function called get_heat_map for server.R to use
# get_heat_map <- function(fire_response_df, lat, long, season) {
#   seasons <- c("Q1", "Q2", "Q3", "Q4")
#   df <- fire_response_df %>%
#     # select columns of interest
#     select(address, type, datetime, latitude, longitude) %>%
#     # filter out NA values
#     filter(!is.na(latitude) & !is.na(longitude)) %>%
#     mutate(year = substr(datetime, 1, 4)) %>%
#     # Only use data from 2017 to 2019
#     filter(year == "2017" | year == "2018" |
#              year == "2019") %>%
#     mutate(quarter = quarters(datetime)) %>%
#     filter(quarter == seasons[as.numeric(season)]) %>%
#     # Extract data based on users choice in UI interface
#     filter(latitude > lat[1] & latitude < lat[2]) %>%
#     filter(longitude > long[2] & longitude < long[1])
# 
#   palette_fn <- colorFactor(palette = c("green", "blue", "red"),
#                             domain = df$year)
# 
#   # Make the heat map.
#   heat_map <- leaflet(df) %>%
#     addTiles() %>%
#     addHeatmap(group = ~year, lng = ~as.numeric(longitude),
#                lat = ~as.numeric(latitude), blur = 18, max = 0.1, radius = 10)
#   return(heat_map)
# }


get_heat_map <- function(fire_response_df, lat, long, season) {
  seasons <- c("Q1", "Q2", "Q3", "Q4")
  df <- fire_response_df %>%
    # select columns of interest
    select(address, type, datetime, latitude, longitude) %>%
    # filter out NA values
    filter(!is.na(latitude) & !is.na(longitude)) %>%
    mutate(year = substr(datetime, 7, 10)) %>%
    # Only use data from 2017 to 2019
    filter(year == "2017" | year == "2018" |
             year == "2019") %>%
    mutate(quarter = quarters(as.Date(substr(datetime, 1, 10), format = "%m/%d/%Y"))) %>%
    filter(quarter == seasons[as.numeric(season)]) %>%
    # Extract data based on users choice in UI interface
    filter(latitude > lat[1] & latitude < lat[2]) %>%
    filter(longitude < long[2] & longitude > long[1])
  
  # palette_fn <- colorFactor(palette = c("green", "blue", "red"),
  #                           domain = df$year)
  
  # Make the heat map.
  heat_map <- leaflet(df) %>%
    addTiles() %>%
    addHeatmap(group = ~year, lng = ~as.numeric(longitude),
               lat = ~as.numeric(latitude), blur = 18, max = 0.1, radius = 10)
  return(heat_map)
}


research_question_1 <- paste("What parts of the U-district are at higher risk",
                             "of incidents necessitating a fire call? What",
                             "about at different times of the year?")
findings_1 <- paste("Based on the heatmap, showing the incidents from 2017 to",
                    "2019. The area around University of Washington,",
                    "University Villiage and along the 45th Street. When we",
                    "look into the data by seasons, Autumn seems to be the",
                    "season with most frequent 911 fire calls")
