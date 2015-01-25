# using Google Char Demo @ RStudio's Shiny Gallery as template
# http://shiny.rstudio.com/gallery/google-charts.html

library(shiny)
library(dplyr)

shinyServer(function(input, output, session) {
  
  # Provide explicit colors for regions, so they don't get recoded when the
  # different series happen to be ordered differently from year to year.
  # http://andrewgelman.com/2014/09/11/mysterious-shiny-things/
  defaultColors <- c("#3366cc", "#dc3912", "#109618")
  series <- structure(
    lapply(defaultColors, function(color) { list(color=color) }),
    names = levels(data$ethnic)
  )

  yearData <- reactive({
    # Filter to the desired year, and put the columns
    # in the order that Google's Bubble Chart expects
    # them (name, x, y, color, size). Also sort by region
    # so that Google Charts orders and colors the regions
    # consistently.
    df <- data %>%
      filter(year == input$year) %>%
      select(name, eth5olvl, ethtfr, ethnic, ethnatincr) %>% #, tottfr, tot5olvl, totnatincr) %>%
      arrange(ethnic)
  })

  output$chart <- reactive({
    # Return the data and options
    list(
      data = googleDataTable(yearData()),
      options = list(
        title = sprintf("Educational Achievement vs. Total Fertility Rate (Year %s)", input$year),
        series = series
      )
    )
  })
  
  output$tot5olvl   <- renderPrint({ subset(data, year==input$year)[1,'tot5olvl'] })
  output$tottfr     <- renderPrint({ subset(data, year==input$year)[1,'tottfr'] })
  output$totnatincr <- renderPrint({ subset(data, year==input$year)[1,'totnatincr'] })
})