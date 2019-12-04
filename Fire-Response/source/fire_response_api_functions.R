# filename: fire_response_api_functions.R
#----------------------------------------------
# Functions for accessing the Seattle Real Time Fire 911 Calls API
# See: https://dev.socrata.com/foundry/data.seattle.gov/kzjm-xkqj
#----------------------------------------------
# install.packages("RSocrata")
#----------------------------------------------
library("RSocrata")
#----------------------------------------------
# Get the nytime API key - used below in queries
#----------------------------------------------
source("./source/fire_response_api_key.R")
BASE_URI <- "https://data.seattle.gov/resource"
ENDPOINT <- "/kzjm-xkqj.json"
# #----------------------------------------------
# Use the Seattle API which is powered by Socrata.
get_fire_response_df <- function() {
  df <- read.socrata(
    "https://data.seattle.gov/resource/kzjm-xkqj.json",
    # use the app_token, email and password to access the API
    app_token = FIRE_RESPONSE,
    email     = E_MAIL,
    password  = PASSWORD
  )
  return(df)
}

# Extract the recently updated data from API
# fire_response_df <- get_fire_response_df()

fire_response_df <- read.csv("./docs/Seattle_Real_Time_Fire_911_Calls.csv",
                             header = TRUE,
                             stringsAsFactors = FALSE
)
