library(markdown)

shinyUI(fluidPage(
  
  titlePanel("Sea water level along the Finnish coastline"),
  
  fluidRow(
    column(12,
           dygraphOutput("water"),
           br()
    ),
    column(7,
           leafletOutput("map", 
                         width = "98%",
                         height = "900px")
    ),
    column(5,
           includeHTML("include.html")
    )
  )
))
