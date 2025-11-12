# app.R - Week 1: Crisis Visibility Dashboard
library(shiny)
library(shinydashboard)

# Actual Bearington plant data from the book
orders_data <- data.frame(
  order_number = c("41427", "41156", "41893", "40285", "41526"),
  customer = c("Bucky Burnside", "Western Corp", "Allied Signal",
               "Burnside", "General Motors"),
  due_date = c("Today", "3 days ago", "Tomorrow", "5 days", "Next week"),
  status = c("CRISIS", "Late", "At Risk", "On Track", "On Track"),
  products = c("Model 12", "P-10", "QTM-710", "Model 12", "P-10"),
  value = c(125000, 87000, 93000, 145000, 76000)
)

ui <- dashboardPage(
  dashboardHeader(title = "Bearington Plant - 90 Days to Survive"),
  dashboardSidebar(
    h4("Alert: Plant Closure Risk!", style = "color: red; padding: 10px;"),
    selectInput("orderSelect", "Track Order:",
                choices = orders_data$order_number,
                selected = "41427"),
    hr(),
    h5("Key Metrics:"),
    valueBoxOutput("daysLeft"),
    valueBoxOutput("lateOrders")
  ),
  dashboardBody(
    fluidRow(
      box(
        title = "Order 41427 - Bucky Burnside Crisis",
        status = "danger",
        width = 12,
        "This order is already late. If we don't ship today, we lose Burnside as a customer.",
        hr(),
        tableOutput("orderDetails")
      )
    )
  )
)

server <- function(input, output, session) {
  output$orderDetails <- renderTable({
    orders_data[orders_data$order_number == input$orderSelect, ]
  })

  output$daysLeft <- renderValueBox({
    valueBox(
      value = 90,
      subtitle = "Days to Save Plant",
      icon = icon("clock"),
      color = "red"
    )
  })

  output$lateOrders <- renderValueBox({
    valueBox(
      value = sum(orders_data$status %in% c("CRISIS", "Late")),
      subtitle = "Late Orders",
      icon = icon("exclamation-triangle"),
      color = "yellow"
    )
  })
}

shinyApp(ui, server)
