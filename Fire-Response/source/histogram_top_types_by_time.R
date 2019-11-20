# Interactiv Visualizations
# source("./fire_response_api_functions.R")
source("./source/interactive_viz2.R")
library(dplyr)
library(ggplot2)
library(plotly)

# The up to date dataset from the Seattle Real Time Fire 911 Calls API
# fire_response_df <- get_fire_response_df()

get_hist <- fire_response_df %>%
  group_by(address) %>%
  summarise(n = n())