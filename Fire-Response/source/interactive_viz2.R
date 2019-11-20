# Interactiv Visualizations
library(dplyr)
library(ggplot2)
library(ggmap)
library(plotly)
library(leaflet)
library(leaflet.extras)

source("./source/fire_response_api_functions.R")
source("./source/fire_response_api_key.R")
# source("./fire_response_api_functions.R")
# source("./fire_response_api_key.R")

# The up to date dataset from the Seattle Real Time Fire 911 Calls API
# fire_response_df <- get_fire_response_df()

get_heat_map <- function(lat, long, fire_response_df) {
  df <- fire_response_df %>%
    select(address, type, datetime, latitude, longitude) %>%
    filter(!is.na(latitude) & !is.na(longitude)) %>%
    mutate(year = substr(datetime, 1, 4)) %>%
    # filter(year == "2017" | year == "2018" |
    #          year == "2019") %>%
    filter(year == "2019") %>%
    filter(latitude > lat[1] & latitude < lat[2]) %>%
    filter(longitude > long[2] & longitude < long[1]) %>%
    mutate(marker = paste(paste("Datetime:", datetime),
                          paste("911 Call Type:", type),
                          sep = "<br>"))
  palette_fn <- colorFactor(palette = c("green", "blue", "red"),
                            domain = df$year)
  interactive_map <- leaflet(df) %>%
    addTiles() %>%
    addHeatmap(group = ~year, lng = ~as.numeric(longitude), 
               lat = ~as.numeric(latitude) ,blur = 20, max = 0.1, radius = 12)
  return(interactive_map)
}

test <- function(long, lat) {
  str <- paste(long[1], long[2], lat[1], lat[2])
  print(str)
}

# df_for_interactive_map <- fire_response_df %>%
#   select(address, type, datetime, latitude, longitude) %>%
#   filter(!is.na(latitude) & !is.na(longitude)) %>%
#   mutate(year = substr(datetime, 1, 4)) %>%
#   filter(year == "2017" | year == "2018" |
#            year == "2019") %>%
#   # filter(year == "2019") %>%
#   filter(latitude > 47.647 & latitude < 47.672) %>%
#   filter(longitude > -122.286 & longitude < -122.322) %>%
#   mutate(marker = paste(paste("Datetime:", datetime),
#                        paste("911 Call Type:", type),
#                        sep = "<br>"))
# 
# palette_fn <- colorFactor(palette = c("green", "blue", "red"),
#                           domain = df_for_interactive_map$year)

# interactive_map <- leaflet(df_for_interactive_map) %>%
#   addTiles() %>%
  # addCircleMarkers(
  #   lng = ~as.numeric(longitude), lat = ~as.numeric(latitude), weight = 3,
  #   radius = 3, popup = ~marker, color = ~palette_fn(year), group = ~year
  # ) %>%
  # addLegend(
  #   position = "bottomright",
  #   title = "New Buildings in Seattle",
  #   pal = palette_fn, # the palette to label
  #   values = ~year, # the values to label
  #   opacity = 1
  # )  %>%
  # addHeatmap(group = ~year, lng = ~as.numeric(longitude), lat = ~as.numeric(latitude) ,blur = 20, max = 0.1, radius = 12)
  # 
# 
# leaflet(quakes) %>%
#   addProviderTiles(providers$CartoDB.DarkMatter) %>%
#   setView( 178, -20, 5 ) %>%
#   addHeatmap(
#     lng = ~longitude, lat = ~latitude,
#     blur = 20, max = 0.05, radius = 15
#   )
# 
# 
# interactive_map_with_layers <- addLayersControl(interactive_map, overlayGroups = df_for_interactive_map$year)
  
# library(leaflet.extras)
# library(magrittr)
# 
# 
# register_google(key = GOOGLE_MAP_API)
# map <- get_googlemap(c(-97.14667, 31.5493))
# ggmap(map)
#   
# ggplot(df_for_interactive_map) + 
#   geom_sf(aes(fill=homic_rate_cat)) +
#   scale_fill_brewer(palette = "OrRd") 