CARoads <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/Caltrans_Traffic_Data.geojson",   what = "sp")
m <- leaflet(CARoads) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 37, zoom = 7) %>% 
  	addPolylines(stroke = TRUE,  color = ~colorQuantile("YlOrRd", Hrs_Delay_)(Hrs_Delay_))
m %>% addProviderTiles(providers$CartoDB.Positron)
