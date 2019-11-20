library(dplyr)
library(ggplot2)
library(ggmap)
library(plotly)
library(leaflet)
# library(leaflet.extras)
# library(magrittr)


leaflet(quakes) %>%
  addProviderTiles(providers$CartoDB.DarkMatter) %>%
  setView( 178, -20, 5 ) %>%
  addHeatmap(
    lng = ~long, lat = ~lat, intensity = ~mag,
    blur = 20, max = 0.05, radius = 15
  )
View(quakes)


london.crimes.files <- Sys.glob(
  paste0(system.file('examples/data/London-Crimes', package='leaflet.extras'),
         '/*/*-city-of-london-street.csv.zip'))
london.crimes <- suppressMessages(
  purrr::map(
    london.crimes.files,
    ~readr::read_csv(.) %>%
      dplyr::select(Latitude, Longitude) %>%
      dplyr::filter(!is.na(Latitude))) %>%
    magrittr::set_names(basename(Sys.glob(
      paste0(system.file('examples/data/London-Crimes', package='leaflet.extras'),
             '/2016*')))))

leaf <- leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron)

purrr::walk(
  names(london.crimes),
  function(month) {
    leaf <<- leaf %>%
      addHeatmap(
        data = london.crimes[[month]],
        layerId = month, group = month,
        lng=~Longitude, lat=~Latitude,
        blur = 20, max = 0.05, radius = 15)
  })

leaf %>%
  setView(-0.094106, 51.515, 14) %>%
  addLayersControl(
    baseGroups = names(london.crimes),
    options = layersControlOptions(collapsed = FALSE)
  )