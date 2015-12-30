shinyServer(function(input, output) {
  
  output$water <- renderDygraph({
    
    dygraph(all.xts) %>%
      dySeries("value", label = "Hamina") %>%
      dySeries("value.1", label = "Helsinki") %>%
      dySeries("value.2", label = "Pori") %>%
      dySeries("value.3", label = "Kaskinen") %>%
      dySeries("value.4", label = "Kemi") %>%
      dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>%
      dyAxis("x", drawGrid = F) %>%
      dyAxis("y", label = "Level from theoretical mean (cm)") %>%
      dyOptions(colors = ZissouMod, strokeWidth = 1) %>%
      dyLegend(show = "onmouseover", width = 700, showZeroValues = FALSE, hideOnMouseOut = TRUE)
    
    
  })
  
  
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      addPopups(hamina.lon, hamina.lat, 
                paste0("<a href='https://www.instagram.com/explore/tags/pit%C3%A4j%C3%A4nsaari/' target='_blank'>Hamina Pitäjänsaari</a> (",hamina.age,")"),
                options = popupOptions(closeButton = F)) %>%
      addPopups(kaivopuisto.lon, kaivopuisto.lat, 
                paste0("<a href='https://fi.wikipedia.org/wiki/Kaivopuisto#/media/File:Kaivopuisto_-_November.JPG' target='_blank'>Helsinki Kaivopuisto</a> (", kaivopuisto.age,")"),
                options = popupOptions(closeButton = F)) %>%
      addPopups(pori.lon, pori.lat, 
                paste0("<a href='https://fi.wikipedia.org/wiki/Kallo_(saari)' target='_blank'>Pori Mäntyluoto Kallo</a> (",pori.age,")"),
                options = popupOptions(closeButton = F)) %>%
      addPopups(kaskinen.lon, kaskinen.lat, 
                paste0("<a  href='http://visitkaskinen.fi/nae-ja-koe/item/385-adskar-ulkoilualue' target='_blank'>Kaskinen Ådskär</a> (",kaskinen.age,")"),
                options = popupOptions(closeButton = F)) %>%
      addPopups(kemi.lon, kemi.lat, 
                paste0("<a href='https://fi.wikipedia.org/wiki/Ajos#/media/File:Ajos.JPG' target='_blank'>Kemi Ajos</a> (",kemi.age,")"),
                options = popupOptions(closeButton = F)) %>%
      fitBounds(19.09, 59.3, 31.59, 70.13) 
  })
  
})