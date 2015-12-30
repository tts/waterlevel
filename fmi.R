library(rwfs)
library(fmi)
library(dplyr)

apiKey <- Sys.getenv("FMI_APIKEY")

getwatlev <- function(id) {
  df <- data.frame()
  
  for ( i in 1:29 ) {
    request <- FMIWFSRequest$new(apiKey=apiKey)
    if ( i <= 9 ) { day <- paste0("0",i) } else { day <- i }
    
    request$setParameters(request="getFeature",
                          storedquery_id="fmi::observations::mareograph::timevaluepair",
                          starttime=paste0("2015-12-",day,"T09:00:00Z"),
                          endtime=paste0("2015-12-",day,"T09:00:00Z"),
                          fmisid=id,
                          parameters="watlev")
    
    client <- FMIWFSClient$new(request=request)
    layers <- client$listLayers()
    response <- client$getLayer(layer=layers[1], parameters=list(splitListFields=TRUE))
    
    r <- response@data %>%
      select(time, value)
    df <- rbind(df, r)
  }
  
  df$time <- as.Date(as.POSIXct(df$time), 'Europe/Helsinki')
  return(df)
}

hamina.df <- getwatlev(mareographs[mareographs$Nimi == 'Hamina Pitäjänsaari', c("FMISID")])
hamina.df$value <- round(hamina.df$value/10)
write.table(hamina.df, "hamina.csv", row.names = F)

kaivopuisto.df <- getwatlev(mareographs[mareographs$Nimi == 'Helsinki Kaivopuisto', c("FMISID")])
kaivopuisto.df$value <- round(kaivopuisto.df$value/10)
write.table(kaivopuisto.df, "kaivopuisto.csv", row.names = F)

pori.df <- getwatlev(mareographs[mareographs$Nimi == 'Pori Mäntyluoto Kallo', c("FMISID")])
pori.df$value <- round(pori.df$value/10)
write.table(pori.df, "pori.csv", row.names = F)

kaskinen.df <- getwatlev(mareographs[mareographs$Nimi == 'Kaskinen Ådskär', c("FMISID")])
kaskinen.df$value <- round(kaskinen.df$value/10)
write.table(kaskinen.df, "kaskinen.csv", row.names = F)

kemi.df <- getwatlev(mareographs[mareographs$Nimi == 'Kemi Ajos', c("FMISID")])
kemi.df$value <- round(kemi.df$value/10)
write.table(kemi.df, "kemi.csv", row.names = F)
