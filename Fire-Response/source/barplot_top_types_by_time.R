# Interactiv Visualizations
# source("./fire_response_api_functions.R")
#----------------------------------------------
# install.packages("dplyr")
# install.packages("ggplot2")
#----------------------------------------------
library("dplyr")
library("ggplot2")

source("./source/fire_response_api_functions.R")

# get the top 10 types with most frequency
top_10_types <- fire_response_df %>%
  group_by(type) %>%
  summarise(number = n()) %>%
  top_n(10) %>%
  arrange(desc(number)) %>%
  pull(type)

# Make it a list to display in the dropdown menu in UI interface
type_list <- as.list(setNames(c(1:10), top_10_types))

# Create a function called get_bar_plot for the server.R to use
# get_bar_plot <- function(fire_response_df, type_index) {
#   df <- fire_response_df %>%
#     # "type" parameter is an integer passed from server.R use
#     # this to get the incident type from top_10_types which
#     # is created before. To extract the data of users' interest
#     filter(type == top_10_types[as.numeric(type_index)]) %>%
#     mutate(year = substr(datetime, 1, 4)) %>%
#     # Only use data from 2017 - 2019
#     filter(year == "2017" | year == "2018" |
#              year == "2019") %>%
#     mutate(quarter = quarters(datetime)) %>%
#     group_by(quarter) %>%
#     mutate(num_incident = n()) %>%
#     select(year, quarter, num_incident) %>%
#     distinct() %>%
#     arrange(year, quarter)
# 
#   # Create the bar_plot based on quarter, year and the number of incident.
#   bar_plot <- ggplot(df, aes(fill = quarter, y = num_incident, x = year)) +
#     geom_bar(position = "dodge", stat = "identity") +
#     xlab("Year") +
#     ylab("Number of 911 Fire Calls") +
#     scale_fill_discrete(name = "Quarter", labels = c("Spring", "Summer",
#                                                      "Autumn", "Winter"))
# 
#   return(bar_plot)
# }

get_bar_plot <- function(fire_response_df, type_index) {
  df <- fire_response_df %>%
    # "type" parameter is an integer passed from server.R use
    # this to get the incident type from top_10_types which
    # is created before. To extract the data of users' interest
    filter(type == top_10_types[as.numeric(type_index)]) %>%
    mutate(year = substr(datetime, 7, 10)) %>%
    # Only use data from 2017 - 2019
    filter(year == "2017" | year == "2018" |
             year == "2019") %>%
    mutate(quarter = quarters(as.Date(substr(datetime, 1, 10), format = "%m/%d/%Y"))) %>%
    group_by(quarter) %>%
    mutate(num_incident = n()) %>%
    select(year, quarter, num_incident) %>%
    distinct() %>%
    arrange(year, quarter)
  
  # Create the bar_plot based on quarter, year and the number of incident.
  bar_plot <- ggplot(df, aes(fill = quarter, y = num_incident, x = year)) +
    geom_bar(position = "dodge", stat = "identity") +
    xlab("Year") +
    ylab("Number of 911 Fire Calls") +
    scale_fill_discrete(name = "Quarter", labels = c("Spring", "Summer",
                                                     "Autumn", "Winter"))
  
  return(bar_plot)
}

research_question_2 <- paste("What categories of fire call incidents are most",
                             "common, and how is this changing?")

findings_2 <- paste("Based the dataset, the top 5 common type of 911 fire",
                    "calls are: Aid Response, Medic Response, Auto Fire",
                    "Alarm, Trans to AMR, Aid Response Yellow. Among the",
                    "four seasons, Autumn seems to be the season of a year",
                    "with most frequent calls in the top 5 fire call types.",
                    "On the other hand, Winter tends to have least frequent",
                    "calls in the top 5 fire call types")
