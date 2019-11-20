#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Sources
source("./source/html_functions.R")
source("./source/interactive_viz2.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Introduction - read contents of markdown file
    output$intro <- renderUI({
        get_text_from_md_file("./docs/Introduction.md")
    })
    
    output$background <- renderUI({
        get_text_from_md_file("./docs/Background_and_Research_Questions.md")
    })
    
    output$about_us <- renderUI({
        get_text_from_md_file("./docs/about_us.md")
    })
    
    fire_response_df <- get_fire_response_df()
    
    output$heatMap <- renderLeaflet({
        # generate bins based on input$bins from ui.R
        # x    <- faithful[, 2]
        # bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        get_heat_map(input$Latitude, input$Longitude, fire_response_df)
    })

})
