# Interactiv Visualizations
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)

source("./fire_response_api_functions.R")

# The up to date dataset from the Seattle Real Time Fire 911 Calls API
fire_response_df <- get_fire_response_df()

df_for_interactive_map <- fire_response_df %>%
  select(address, type, datetime, latitude, longitude) %>%
  filter(!is.na(latitude) & !is.na(longitude)) %>%
  mutate(year = substr(datetime, 1, 4)) %>%
  filter(year == "2017" | year == "2018" |
           year == "2019") %>%
  # filter(year == "2019") %>%
  filter(latitude > 47.647 & latitude < 47.672) %>% 
  filter(longitude > -122.286 & longitude < -122.322) %>%
  mutate(marker = paste(paste("Datetime:", datetime),
                       paste("911 Call Type:", type),
                       sep = "<br>"))

palette_fn <- colorFactor(palette = c("red", "blue", "green"), domain = df_for_interactive_map$year)

m <- leaflet(df_for_interactive_map) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~as.numeric(longitude), lat = ~as.numeric(latitude), weight = 2,
    radius = 2, popup = ~marker, color = ~palette_fn(year), group = ~year
  ) %>%
  addLegend(
    position = "bottomright",
    title = "New Buildings in Seattle",
    pal = palette_fn, # the palette to label
    values = ~year, # the values to label
    opacity = 1
  ) 
  addLayersControl(m, overlayGroups = df_for_interactive_map$year)
  
  

