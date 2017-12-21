library(geojsonio)
USCounties <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/USCounties.geojson")
pal <- colorNumeric("viridis", NULL)
library(leaflet)
leaflet() %>% 
	addTiles() %>% 
	setView(lng = -98.583, lat = 39.833, zoom = 3) %>% 
	addGeoJSON(USCounties, weight = 0.5) #, fill = pal( )