# using Google Char Demo @ RStudio's Shiny Gallery as template
# http://shiny.rstudio.com/gallery/google-charts.html

library(googleCharts)

# Use global max/min for axes so the view window stays
# constant as the user moves between years
xlim <- list(
  min = min(data$eth5olvl) - 5,
  max = max(data$eth5olvl) + 5
)
ylim <- list(
  min = min(data$ethtfr) - 0.5,
  max = max(data$ethtfr) + 0.5
)

shinyUI(fluidPage(
  # This line loads the Google Charts JS library
  googleChartsInit(),
  
  # Use the Google webfont "Source Sans Pro"
  tags$link(
    href=paste0("http://fonts.googleapis.com/css?", "family=Source+Sans+Pro:300,600,300italic"),
    rel="stylesheet", type="text/css"),
  tags$style(type="text/css", "body {font-family: 'Source Sans Pro'}"
  ),
  
  h2("Singapore: Education Achievement vs Fertility Rate"),

  googleBubbleChart("chart",
                    width="100%", height = "475px",
                    # Set the default options for this chart; they can be
                    # overridden in server.R on a per-update basis. See
                    # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                    # for option documentation.
                    options = list(
                      fontName = "Source Sans Pro",
                      fontSize = 13,
                      
                      # Set axis labels and ranges
                      hAxis = list(title = "Student Passing 5 or more GCE O-Levels (%)", viewWindow = xlim),
                      vAxis = list(title = "Total Fertility Rate (TFR)", viewWindow = ylim),
          
                      # The default padding is a little too spaced out
                      chartArea = list(top = 50, left = 75, height = "75%", width = "75%"),
                      
                      # Allow pan/zoom
                      explorer = list(),
                      
                      # Set bubble visual props
                      bubble = list(opacity = 0.9, stroke = "none",
                                    # Hide bubble label
                                    textStyle = list(color = "none")),
                      
                      # Set fonts
                      titleTextStyle = list(fontSize = 16),
                      tooltip = list(textStyle = list(fontSize = 12))
                    )
  ),
  
  
  fluidRow(
    shiny::column(4, offset = 4,
                  sliderInput("year", "Select the Year of the data ..or Click Play for timelapse:",
                              min = min(data$year), max = max(data$year),
                              value = min(data$year), animate = TRUE)
    )
  ),
  
  fluidRow(
    shiny::column(width=4, strong('eth5olvl'), ": ethnic specific >5 GCE O-Lvl pass. Year's Overall:", verbatimTextOutput('tot5olvl')),
    shiny::column(width=4, strong('ethtfr'), ": ethnic specific TFR (Replacement rate=2.1). Year's Overall:", verbatimTextOutput('tottfr')),
    shiny::column(width=4, strong('ethnatincr'), ": ethnic specific Natural Incr. Year's Grand Total:", verbatimTextOutput('totnatincr'))
  )
  
))  

                      
                      