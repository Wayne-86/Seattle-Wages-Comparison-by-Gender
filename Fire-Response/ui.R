#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("./source/html_functions.R")
source("./source/interactive_viz2.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel(h1("U-District Fire Responses", align = "center")),

    # # Sidebar with a slider input for number of bins
    # sidebarLayout(
    #     sidebarPanel(
    #         sliderInput("bins",
    #                     "Number of bins:",
    #                     min = 1,
    #                     max = 50,
    #                     value = 30)
    #     ),
    # 
    #     # Show a plot of the generated distribution
    #     mainPanel(
    #         plotOutput("distPlot")
    #     ),
    # ),
    
    # Make a side Nav Bar
    navlistPanel(
        "U-District Fire Responses",
        "-----",
        tabPanel(
            "Introduction",
            htmlOutput("intro")
                 ),
        tabPanel("Background & Research Questions",
                 htmlOutput("background")),
        navbarMenu("Map & Plot",
                   tabPanel("Heat Map on the Frequency of 911 Fire Calls",
                            leafletOutput("heatMap"),
                            fluidRow(
                                column(4, sliderInput("Longitude", 
                                        label = h3("Longitude Range"), 
                                        min = -122.322, max = -122.286,
                                        value = c(-122.322, -122.286))
                                ),
                                column(4, sliderInput("Latitude", 
                                        label = h3("Latitude Range"), 
                                        min = 47.647, max = 47.672, 
                                        value = c(47.647, 47.672))
                                )
                            )
                            ),
                   tabPanel("Visualization #2"),
                   tabPanel("Visualization #3")
        ),
        tabPanel("Conclusion"),
        tabPanel("About the Tech"),
        tabPanel("About us",
                 htmlOutput("about_us"))
    )
))
