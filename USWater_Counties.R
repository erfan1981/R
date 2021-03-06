# Per capita drinking water consumption for US Counties averages from 1995 to 2005
# Source: https://www.census.gov/support/USACdataDownloads.html#WAT
# US Counties boundary Shapefile:: https://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html

require(leaflet)
USWater <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/USWater1.geojson",   what = "sp")
pal <- colorNumeric(
  palette = "YlOrRd",
  domain = USWater$AveN
)

m <- leaflet(USWater) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 50, zoom = 3) %>% 
	addPolygons(stroke = TRUE, color = ~colorNumeric( palette = "YlOrRd", AveN, n = 9)(AveN), fill = TRUE, fillColor = ~colorNumeric( palette = "YlOrRd", AveN, n = 9)(AveN) , fillOpacity = 0.6)
m %>% addProviderTiles(providers$CartoDB.Positron) %>%

addLegend("bottomleft", pal = pal, values = ~AveN,
    title = "Per Capita Drinking Water Consumption Average 1995-2005",
    labFormat = labelFormat(suffix = " Gallons/Day"),
    opacity = 1
  )
