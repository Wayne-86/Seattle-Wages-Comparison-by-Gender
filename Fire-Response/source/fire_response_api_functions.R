# filename: fire_response_api_functions.R
#----------------------------------------------
# Functions for accessing the Seattle Real Time Fire 911 Calls API
# See: https://dev.socrata.com/foundry/data.seattle.gov/kzjm-xkqj
#
# install.packages("httr")
# install.packages("jsonlite")
#----------------------------------------------
library("httr")
library("jsonlite")
library("stringr")

#----------------------------------------------
# Get the nytime API key - used below in queries
#----------------------------------------------
source("./source/fire_response_api_key.R")
BASE_URI <- "https://data.seattle.gov/resource"
ENDPOINT <- "/kzjm-xkqj.json"

#----------------------------------------------
# Make call to a URI and process the data. This 
# function should work for any API.
# See: https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html
#----------------------------------------------
# call_uri <- function(base_uri, endpoint, query_params) {
call_uri <- function(query_params) {
  # Make the uri string
  resource_uri <- paste0(BASE_URI, ENDPOINT)
  
  # Send the query off with uri string and the query paramters. We assume
  # that everything works - which is a very big assumption. The network 
  # could time out, the query could fail, etc. Ideally a lot of error-handing
  # is required here. These functions are likey to be helpful
  #    warn_for_status(response)
  #    stop_for_status(response)
  #    http_status(response)
  #
  # See: https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html
  #
  response <- GET(resource_uri, query = query_params)
  warn_for_status(response)
  
  # Get the response back - as a long character string
  response_text <- content(response, type = "text", encoding = "UTF-8")
  
  # Convert the text string into an R object that can be processed in R
  response_data <- fromJSON(response_text)
  return(response_data)
}

fire_response_df <- call_uri("")


