# Annual Vehicle Hours of Delay (VHD) at 35 miles per hour (mph)
# Delay data from CALTRANS: https://data.ca.gov/node/271/api
# Road Shapefile Vector data from CALTRANS: http://www.dot.ca.gov/hq/tsip/gis/datalibrary/#Highway
CARoads <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/Caltrans_Traffic_Data.geojson",   what = "sp")

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = CARoads$Hrs_Delay_)

m <- leaflet(CARoads) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 37, zoom = 6) %>% 
  	addPolylines(stroke = TRUE,  color = ~colorQuantile("YlOrRd", Hrs_Delay_, n = 9)(Hrs_Delay_))
m %>% addProviderTiles(providers$CartoDB.Positron) %>%

addLegend("bottomleft", pal = pal, values = ~Hrs_Delay_,
    title = "Annual Vehicle Hours of Delay (VHD) at 35 miles per hour (mph)",
    labFormat = labelFormat(suffix = " Hours"),
    opacity = 3
  )
