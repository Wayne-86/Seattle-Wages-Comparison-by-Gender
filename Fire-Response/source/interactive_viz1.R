# Interactiv Visualizations
source("./fire_response_api_functions.R")
library(dplyr)
library(ggplot2)
library(plotly)

# The up to date dataset from the Seattle Real Time Fire 911 Calls API
fire_response_df <- get_fire_response_df()