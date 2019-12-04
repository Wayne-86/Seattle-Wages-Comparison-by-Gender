#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#----------------------------------------------
# install.packages("shiny")
# install.packages('rsconnect')
#----------------------------------------------
library("shiny")

# Sources
source("./source/html_functions.R")
source("./source/heatmap_on_incident_frequency.R")
source("./source/barplot_top_types_by_time.R")
source("./source/line_graph_freq_day.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Introduction - read contents from markdown file
    output$intro <- renderUI({
        get_text_from_md_file("./docs/Introduction.md")
    })
    
    # Background - read contents from markdown file
    output$background <- renderUI({
        get_text_from_md_file("./docs/Background_and_Research_Questions.md")
    })
    
    # Conclusion - read contents from markdown file
    output$conclusion <- renderUI({
        get_text_from_md_file("./docs/conclusion.md")
    })
    
    # About_Tech - read contents from markdown file
    output$about_tech <- renderUI({
        get_text_from_md_file("./docs/about_tech.md")
    })
    
    # About_us - read contents from markdown file
    output$about_us <- renderUI({
        get_text_from_md_file("./docs/about_us.md")
    })
    
    # Render the leaflet based on UI inputs
    output$heatmap <- renderLeaflet({
        get_heat_map(fire_response_df, input$Latitude, input$Longitude,
                     input$Season)
    })
    
    # Render the plot based on UI inputs
    output$barplot <- renderPlot({
        get_bar_plot(fire_response_df, input$Type1)
    })
    
    # Render the plot based on UI inputs
    output$line_graph1 <- renderPlot({
        get_line_graph_am(fire_response_df, input$Type2)
    })
    
    output$line_graph2 <- renderPlot({
        get_line_graph_pm(fire_response_df, input$Type2)
    })
    
    
    # Render the question and findings for the heat map
    output$q_1 <- renderText({
        research_question_1
    })
    output$f_1 <- renderText({
        findings_1
    })
    
    # Render the quesiton and findings for the bar plot
    output$q_2 <- renderText({
        research_question_2
    })
    output$f_2 <- renderText({
        findings_2
    })
    
    # Render the quesiton and findings for the bar plot
    output$q_3 <- renderText({
        research_question_3
    })
    output$f_3 <- renderText({
        findings_3
    })
    
})