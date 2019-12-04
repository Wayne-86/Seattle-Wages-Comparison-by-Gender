# ui.R for the Fire-Response shiny app.
#----------------------------------------------
# install.packages("shiny")
# install.packages('rsconnect')
#----------------------------------------------
library("shiny")
library("shinythemes")

# Source
source("./source/html_functions.R")
source("./source/heatmap_on_incident_frequency.R")
source("./source/barplot_top_types_by_time.R")
source("./source/line_graph_freq_day.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    theme = shinytheme('united'),
    # Application title
    titlePanel(h1("U-District Fire Responses", align = "center")),
    
    # Make a side Nav Bar
    # navlistPanel(
    #     "U-District Fire Responses",
    #     "------------------",
    tabsetPanel(
        type = "tabs", id = "nav_bar",
        tabPanel(
            "Introduction",
            htmlOutput("intro")
        ),
        tabPanel("Background & Research Questions",
                 htmlOutput("background")),
        navbarMenu("Map & Plot",
                   tabPanel("Heat Map on the Frequency of 911 Fire Calls",
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("Longitude",
                                                label = h3("Longitude Range"),
                                                min = -122.322, max = -122.286,
                                                value = c(-122.322, -122.286)),
                                    
                                    # Create a slider for user to adjust latitude
                                    sliderInput("Latitude",
                                                label = h3("Latitude Range"),
                                                min = 47.647, max = 47.672,
                                                value = c(47.647, 47.672)),
                                    
                                    radioButtons("Season", label =
                                                     h3("Select Season"),
                                                 choices = list("Sprint" = 1,
                                                                "Summer" = 2,
                                                                "Autumn" = 3,
                                                                "Winter" = 4),
                                                 selected = 1)
                                ),
                                mainPanel(
                                    leafletOutput("heatmap"),
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
                                )
                            )
                            
                   ),
                   tabPanel("Top 10 common 911 Fire Calls Through Seasons",
                            # Display the Bar Plot
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("Type1", label =
                                                    h3("Select Incident Type"),
                                                choices = type_list,
                                                selected = 1)
                                ),
                                mainPanel(
                                    plotOutput("barplot"),
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
                            )
                   ),
                   tabPanel("Incident Frequency Tendency by hours",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("Type2", label =
                                                    h3("Select Incident Type"),
                                                choices = type_list,
                                                selected = 1)
                                ),
                                mainPanel(
                                    h3("12 Hour Incident Frequency (AM)"),
                                    plotOutput("line_graph1"),
                                    h3("12 Hour Incident Frequency (PM)"),
                                    plotOutput("line_graph2"),
                                    hr(),
                                    fluidRow(
                                        strong("Research Question #2:"),
                                        textOutput("q_3")
                                    ),
                                    hr(),
                                    fluidRow(
                                        strong("Findings:"),
                                        textOutput("f_3")
                                    )
                                )
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
