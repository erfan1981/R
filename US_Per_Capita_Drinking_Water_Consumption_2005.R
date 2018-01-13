# Per capita driniking water consumption in selected US cities 2005
# Source: https://www.census.gov/support/USACdataDownloads.html#WAT
# Coordinates for cities: https://simplemaps.com/data/us-cities

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = USWater$WAT330205D
)

require(leaflet)
USWater <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/US_Drinking_Water_Per_Capita.geojson",   what = "sp")
m <- leaflet(USWater) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 50, zoom = 3) %>% 
	addCircles(stroke = TRUE,  color = ~colorNumeric( palette = "YlOrRd", WAT330205D, n = 9)(WAT330205D))
m %>% addProviderTiles(providers$CartoDB.Positron) %>%

addLegend("bottomleft", pal = pal, values = ~WAT330205D,
    title = "Est. Per Capita Drinking Water Consumption 2005",
    labFormat = labelFormat(suffix = " Gallons/Day"),
    opacity = 1
  )
