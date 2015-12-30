library(rvest)

url <- "http://ilmatieteenlaitos.fi/havaintoasemat?p_p_id=stationlistingportlet_WAR_fmiwwwweatherportlets&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-4&p_p_col_count=1&_stationlistingportlet_WAR_fmiwwwweatherportlets_stationGroup=MAREO"

stations <- url %>%
  html() %>%
  html_nodes(xpath='//table[@id="station-list-table"]') %>%
  html_table()

mareographs <- stations[[1]]

write.table(mareographs, "mareographs.csv", row.names = F)

