### This is a Shiny Application made to present research on the Seattle Real Time Fire 911 Calls.

### Data Source:
We are accessing the Real Time Fire 911 Calls via The Socrata Open Data API.
[Data Source](https://data.seattle.gov/Public-Safety/Seattle-Real-Time-Fire-911-Calls/kzjm-xkqj)
[API Documents](https://dev.socrata.com/foundry/data.seattle.gov/kzjm-xkqj)
**Using API could keep our Shiny Application always extract the most updated data, therefore, the mechanism of this application is available for long term use.**

### Key Components:
* **ui.R:** Front-end file for the Shiny Application. Its purpose is to format the layout of web interface and to display different elements from back-end.
* **server.R:** Back-end file for the Shiny Application. Its purpose is to render elements such as markdown files, map and plot for the ui.R to display. It also takes the input from interface and call functions from other helping R files based on the inputs.
* **fire_response_api_function.R:** Extract the most updated data from Real Time Fire 911 Calls database by using an API token, registered email address and passwords. Then generate a data frame based on extracted data.
* **html_functions.R:** R file with function to convert markdown files into html format.
* **heatmap_on_incident_frequency.R:** This file manipulates the raw data extracted from API and create a function to show a heatmap on U-District area based on the number of incidents. When manipulating the data frame, we cleaned the NA values and only filter the data from 2017 - 2019. This heatmap could should the incidents frequency in sub-area based on users choice from the application interface. In addition, the heatmap will show the incidents frequency by seasons of users' choice. 
* **barplot_top_types_by_time.R:** This file manipulates the raw data extracted from API and create a function to show a barplot of the number of incidents based on year, seasons and type. When manipulating the data frame, we cleaned the NA values and only filter the data from 2017 - 2019. This barplot would show the comparison of number of incidents of each year in each season. Users could choose which type of incident they are interested in from a dropdown menu and the barplot will change accordingly.
* **line_graph_freq_dat.R:** This file manipulates the raw data extracted from API and create a function to show two line graphs, one for AM hours and another for PM hours. Users could choose from the top 10 most frequent incident types and the line graphs will show the corresponding information based on users' choices. The line graph will show three lines indicate three different years and show you the total incident number categorized by hours.
* **Markdown files:** There are a collection of markdown files, which includes different parts of paragraphs that will be displayed in the Shiny Application.

### Key Techniques/library Being Used:
#### Libraries:
* For server.R and ui.R, we use the _"shiny"_ library to create the Shiny Application.
* For html_functions.R, we use _"knitr"_ and _"formatR"_ library in assist to convert markdown files into html formats.
* For fire_response_api_functions.R, we use _"RSocrata"_ library which is required by the Socrata Open Data API in order to extract data from the online API.
* For heatmap_on_incident_frequency.R, we use _"dplyr"_ library to make an aggregated data frame for the use of making a heatmap. Then we use _"leaflet"_ and _"leaflet.extras"_ library to create the heatmap of users' interest.
* For barplot_top_types_time.R, we use _"dplyr"_ library to make an aggregated data frame for the use of making a barplot. Then we use _"ggplot2"_ library to create a barplot of users' interest.

#### Techniques in server.R and ui.R:
* server.R uses _renderUI(), renderText(), renderLeaflet() and renderPlot()_ to render markdown file, characters, leaflet and plots for ui.R to use.
* ui.R uses _fluidPage()_ to create the overall page, _navlistPanel()_ to create the application architecture and site navigation. It uses _tabPanel()_ to specify each page, _navbarMenu()_ to create a dropdown menu for the visualizations. In addition, it uses widget functions such as _sliderInput(), radioButtons()_ and _selectInput()_ to create sliders, radio buttons and dropdown menu for the interactive use of visualization.

You can find more information about the shiny app in [Technical Report](https://github.com/Wayne-86/U-District-Fire-Responses/wiki/Technical-Report)

