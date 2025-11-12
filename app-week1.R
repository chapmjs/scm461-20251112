# Week 1: Create the crisis dashboard
ui <- fluidPage(
  titlePanel("Bearington Plant Dashboard - Crisis Mode"),
  h4("90 days to save the plant!", style="color:red;"),
  selectInput("partNumber", 
              "Select Part (like order 41427):", 
              choices = c("41427", "50223", "60134"))
)
