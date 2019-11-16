#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("U-District Fire Responses"),

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
        tabPanel("Introduction",
                 h2("Whatwarwara")
                 ),
        tabPanel("Background & Research Questions"),
        navbarMenu("Interactive Visualizations",
                   tabPanel("Visualization #1"),
                   tabPanel("Visualization #2"),
                   tabPanel("Visualization #3")
        ),
        tabPanel("Conclusion"),
        tabPanel("About the Tech"),
        tabPanel("About us")
    )
))
