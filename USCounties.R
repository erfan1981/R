library(geojsonio)
USCounties <- geojsonio::geojson_read("https://raw.githubusercontent.com/erfan1981/JSON/master/USCounties.geojson")
pal <- colorNumeric("viridis", NULL)
library(leaflet)
library(jsonlite)

m <- leaflet() %>% 
	addTiles() %>% 
	setView(lng = -98.583, lat = 39.833, zoom = 3) %>% 
	addTiles() %>% 
	addGeoJSON(USCounties, weight = 0.5)  #, fill = pal(USCounties$features[[1:3220]]$properties$AWATER)) #$properties$AWATER) $features[[3218]]$properties$AWATER
 	#addPolygons() # fillColor = ~pal(AWATER)
#m %>% addPolygons(lng = -98.583, lat = 39.833) #, fillColor = ~pal(features$properties$AWATER))
#m %>% addPolygons(fillColor = ~pal(features$properties$AWATER))
a <- 1:length(USCounties$features)
for (i in 1:length(USCounties$features)) (a[i] <- USCounties$features[[i]]$properties$AWATER)
m %>% addPolygons(lng = -98.583, lat = 39.833, fillColor = ~pal(a))
