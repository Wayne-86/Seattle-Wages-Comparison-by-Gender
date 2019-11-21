# ui.R for the Fire-Response shiny app.
#----------------------------------------------
# install.packages("shiny")
# install.packages('rsconnect')
#----------------------------------------------
library("shiny")

# Source
source("./source/html_functions.R")
source("./source/heatmap_on_incident_frequency.R")
source("./source/barplot_top_types_by_time.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel(h1("U-District Fire Responses", align = "center")),

    # Make a side Nav Bar
    navlistPanel(
        "U-District Fire Responses",
        "------------------",
        tabPanel(
            "Introduction",
            htmlOutput("intro")
                 ),
        tabPanel("Background & Research Questions",
                 htmlOutput("background")),
        navbarMenu("Map & Plot",
                   tabPanel("Heat Map on the Frequency of 911 Fire Calls",
                            # Display the Heat Map
                            leafletOutput("heatmap"),
                            fluidRow(
                                # Create a slider for user to adjust longitude
                                column(6, sliderInput("Longitude",
                                        label = h3("Longitude Range"),
                                        min = -122.322, max = -122.286,
                                        value = c(-122.322, -122.286))
                                ),
                                # Create a slider for user to adjust latitude
                                column(6, sliderInput("Latitude",
                                        label = h3("Latitude Range"),
                                        min = 47.647, max = 47.672,
                                        value = c(47.647, 47.672))
                                ),
                                radioButtons("Season", label =
                                            h3("Select Season"),
                                            choices = list("Sprint" = 1,
                                                           "Summer" = 2,
                                                           "Autumn" = 3,
                                                           "Winter" = 4),
                                            selected = 1),
                            ),
                            hr(),
                            fluidRow(
                                strong("Research Question #1:"),
                                textOutput("q_1")
                            ),
                            hr(),
                            fluidRow(
                                strong("Findings:"),
                                textOutput("f_1")
                            )
                          ),
                   tabPanel("Top 10 common 911 Fire Calls Through Seasons",
                            # Display the Bar Plot
                            fluidRow(
                                plotOutput("barplot"),
                                # Create a Select Box for user to choose
                                selectInput("Type", label =
                                                h3("Select Incident Type"),
                                            choices = type_list,
                                            selected = 1)
                                ),
                            hr(),
                            fluidRow(
                                strong("Research Question #2:"),
                                textOutput("q_2")
                            ),
                            hr(),
                            fluidRow(
                                strong("Findings:"),
                                textOutput("f_2")
                            )
                           )
        ),
        tabPanel("Conclusion",
                 htmlOutput("conclusion")),
        tabPanel("About the Tech",
                 htmlOutput("about_tech")),
        tabPanel("About us",
                 htmlOutput("about_us"))
    )
))
