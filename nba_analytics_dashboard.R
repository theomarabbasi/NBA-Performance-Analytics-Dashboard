# NBA Analytics Dashboard - Professional Portfolio Project
library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

# Sample NBA Data
player_names <- c("LeBron James", "Stephen Curry", "Kevin Durant", "Giannis Antetokounmpo", "Luka Doncic")
teams <- c("LAL", "GSW", "PHX", "MIL", "DAL")

nba_data <- data.frame(
  player_name = player_names,
  team = teams,
  points_per_game = c(25.7, 26.4, 28.2, 31.1, 32.4),
  assists_per_game = c(7.3, 5.1, 5.0, 5.7, 8.0),
  efficiency_rating = c(58.9, 60.8, 63.0, 66.1, 68.8)
)

# Interactive Dashboard
ui <- dashboardPage(
  dashboardHeader(title = "NBA Analytics Dashboard"),
  dashboardSidebar(
    sidebarMenu(menuItem("Analytics", tabName = "main"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "main",
        box(title = "NBA Player Performance", status = "primary", width = 12,
            plotlyOutput("plot"), 
            DT::dataTableOutput("table")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    p <- ggplot(nba_data, aes(x = points_per_game, y = efficiency_rating)) +
      geom_point(size = 3, color = "blue") +
      geom_text(aes(label = player_name), vjust = -0.5) +
      theme_minimal()
    ggplotly(p)
  })
  
  output$table <- DT::renderDataTable(nba_data)
}

shinyApp(ui = ui, server = server)
