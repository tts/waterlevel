library(shiny)
library(shinyapps)
library(rsconnect)
library(dygraphs)
library(xts)
library(leaflet)

# Read in data queried from the FMI API
hamina.df <- read.table("hamina.csv", header = T, sep = " ", stringsAsFactors = F, colClasses = c("Date", "integer"))
kaivopuisto.df <- read.table("kaivopuisto.csv", header = T, sep = " ", stringsAsFactors = F, colClasses = c("Date", "integer"))
pori.df <- read.table("pori.csv", header = T, sep = " ", stringsAsFactors = F, colClasses = c("Date", "integer"))
kaskinen.df <- read.table("kaskinen.csv",  header = T, sep = " ", stringsAsFactors = F, colClasses = c("Date", "integer"))
kemi.df <- read.table("kemi.csv", header = T, sep = " ", stringsAsFactors = F, colClasses = c("Date", "integer"))

# Transform data frames to XTS objects
hamina.xts <- as.xts(as.matrix(hamina.df), order.by = hamina.df$time)
kaivopuisto.xts <- as.xts(as.matrix(kaivopuisto.df), order.by = kaivopuisto.df$time)
pori.xts <- as.xts(as.matrix(pori.df), order.by = pori.df$time)
kaskinen.xts <- as.xts(as.matrix(kaskinen.df), order.by = kaskinen.df$time)
kemi.xts <- as.xts(as.matrix(kemi.df), order.by = kemi.df$time)

# Merge all
first.xts <- merge.xts(hamina.xts, kaivopuisto.xts)
second.xts <- merge.xts(first.xts, pori.xts)
third.xts <- merge.xts(second.xts, kaskinen.xts)
all.xts <- merge.xts(third.xts, kemi.xts)

# Read info on mareographs, harvested from the FMI web site
mareographs <- read.table("mareographs.csv", header = T, sep = " ", stringsAsFactors = F)
mareographs$Lon <- gsub(",", ".", mareographs$Lon)
mareographs$Lat <- gsub(",", ".", mareographs$Lat)

hamina.lon <- mareographs[mareographs$Nimi == 'Hamina Pitäjänsaari', c("Lon")]
hamina.lat <- mareographs[mareographs$Nimi == 'Hamina Pitäjänsaari', c("Lat")]
hamina.age <- mareographs[mareographs$Nimi == 'Hamina Pitäjänsaari', c("Alkaen")]

kaivopuisto.lon <- mareographs[mareographs$Nimi == 'Helsinki Kaivopuisto', c("Lon")]
kaivopuisto.lat <- mareographs[mareographs$Nimi == 'Helsinki Kaivopuisto', c("Lat")]
kaivopuisto.age <- mareographs[mareographs$Nimi == 'Helsinki Kaivopuisto', c("Alkaen")]

pori.lon <- mareographs[mareographs$Nimi == 'Pori Mäntyluoto Kallo', c("Lon")]
pori.lat <- mareographs[mareographs$Nimi == 'Pori Mäntyluoto Kallo', c("Lat")]
pori.age <- mareographs[mareographs$Nimi == 'Pori Mäntyluoto Kallo', c("Alkaen")]

kaskinen.lon <- mareographs[mareographs$Nimi == 'Kaskinen Ådskär', c("Lon")]
kaskinen.lat <- mareographs[mareographs$Nimi == 'Kaskinen Ådskär', c("Lat")]
kaskinen.age <- mareographs[mareographs$Nimi == 'Kaskinen Ådskär', c("Alkaen")]

kemi.lon <- mareographs[mareographs$Nimi == 'Kemi Ajos', c("Lon")]
kemi.lat <- mareographs[mareographs$Nimi == 'Kemi Ajos', c("Lat")]
kemi.age <- mareographs[mareographs$Nimi == 'Kemi Ajos', c("Alkaen")]

# Dygraph line colours
# https://github.com/karthik/wesanderson/blob/master/README.md
# Replaced #3B9AB2 -> #296b7c, and #E1AF00 -> #b48c00 for better discernability
ZissouMod <- c("#296b7c","#78B7C5","#EBCC2A","#b48c00","#F21A00")