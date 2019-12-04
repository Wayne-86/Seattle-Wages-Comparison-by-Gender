# Interactive Visualizations
# Heat map showing the frequency of incidents
#----------------------------------------------
# install.packages("dplyr")
# install.packages("ggplot2")
#----------------------------------------------
library("dplyr")
library("tidyr")
library("ggplot2")

# source files
source("./source/fire_response_api_functions.R")
source("./source/fire_response_api_key.R")


# get the top 10 types with most frequency
top_10_types <- fire_response_df %>%
  group_by(type) %>%
  summarise(number = n()) %>%
  top_n(10) %>%
  arrange(desc(number)) %>%
  pull(type)

# Make it a list to display in the dropdown menu in UI interface
type_list <- as.list(setNames(c(1:10), top_10_types))

get_graph_df <- function(fire_response_df, type_index) {
  df <- fire_response_df %>%
    # "type" parameter is an integer passed from server.R use
    # this to get the incident type from top_10_types which
    # is created before. To extract the data of users' interest
    filter(type == top_10_types[as.numeric(type_index)]) %>%
    mutate(year = substr(datetime, 7, 10)) %>%
    # Only use data from 2017 - 2019
    filter(year == "2017" | year == "2018" |
             year == "2019") %>%
    mutate(hour = substr(datetime, 12, 13)) %>%
    mutate(`am/pm` = substr(datetime, 21, 22))
  return(df)
}


get_line_graph_am <- function(fire_response_df, type_index) {
  am_df <- get_graph_df(fire_response_df, type_index) %>%
    filter(`am/pm` == "AM") %>%
    group_by(year, hour) %>%
    mutate(num_incident = n()) %>%
    select(hour, year, num_incident) %>%
    distinct() %>%
    arrange(year, hour)
  
  line_plot <- ggplot(data = am_df, aes(x = hour, y = num_incident, 
                                        group = year)) +
    geom_line(aes(linetype=year, color=year)) +
    geom_point(aes(shape=year, color=year))
  
  return(line_plot)
}

get_line_graph_pm <- function(fire_response_df, type_index) {
  pm_df <- get_graph_df(fire_response_df, type_index) %>%
    filter(`am/pm` == "PM") %>%
    group_by(year, hour) %>%
    mutate(num_incident = n()) %>%
    select(hour, year, num_incident) %>%
    distinct() %>%
    arrange(year, hour)
  
  line_plot <- ggplot(data = pm_df, aes(x = hour, y = num_incident, 
                                        group = year)) +
    geom_line(aes(linetype=year, color=year)) +
    geom_point(aes(shape=year, color=year))
  
  return(line_plot)
}

research_question_3 <- paste("What categories of fire call incidents are most",
                             "common, and how is this changing?")

findings_3 <- paste("Based the dataset, the top 5 common type of 911 fire",
                    "calls are: Aid Response, Medic Response, Auto Fire",
                    "Alarm, Trans to AMR, Aid Response Yellow. Wihtin one",
                    "day, it seems that the time duration from 11AM to 6pm",
                    "tend to have the most frequent Aid Response calls. In",
                    "addition, based on the line graphs, it seems that there",
                    "aren't too many Fire Alarm calls from 11PM to 2AM. This",
                    "is actually pretty surprising since we would often hear",
                    "the siren of fire response during night time.")