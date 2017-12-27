
USCounties <- geojsonio::geojson_read("http://eric.clst.org/wupl/Stuff/gz_2010_us_050_00_20m.json",   what = "sp")

pal <- colorNumeric("viridis", NULL)

leaflet(USCounties) %>%
  	addTiles() %>%
	setView(lng = -120, lat = 50, zoom = 4) %>% 
  	addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1, fillColor = ~pal(log10(as.numeric(CENSUSAREA))))
