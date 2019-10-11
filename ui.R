library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


shinyUI(
  dashboardPage(
    dashboardHeader(title = "Weibull Function"),
    dashboardSidebar(
      numericInput('psize', 'Plot size', 400,
                   min = 10, max = 100000),
      numericInput('dmean', 'Mean diameter (cm)', 20,
                   min = 7.5, max = 200),
      numericInput('dmx', 'Max diameter (cm)', 20,
                   min = 7.5, max = 200),
      sidebarMenu(
        menuItem("Distribution (dbh)", tabName = "Graphic", icon = icon("chart-bar")),
        menuSubItem("Table", tabName = "dbhcat",icon = icon("table"))
      )),
    dashboardBody(
      tabItems(
        tabItem("Distribution (dbh)",tabName = "Graphic",
                fluidRow(
                  box(plotOutput("plot1"))
                )),
        tabItem("Table",tabName = "dbhcat",
                DT::dataTableOutput("mytable")
        )
        
      )
    )
    
  )
)