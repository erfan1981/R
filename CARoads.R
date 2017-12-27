CARoads <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/Caltrans_Traffic_Data.geojson",   what = "sp")

pal <- colorNumeric("viridis", NULL)

leaflet(CARoads) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 50, zoom = 4) %>% 
  	addPolygons()# stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1) #, fillColor = ~pal(as.numeric("Hrs_Delay_")))
