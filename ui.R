library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


shinyUI(
  dashboardPage(
    dashboardHeader(title = "Weibull Function"),
    dashboardSidebar(

      sidebarMenu(
        menuItem("Distribution (dbh)", tabName = "Graphic", icon = icon("chart-bar")),
        menuSubItem("h/d model", tabName = "hdnaslund",icon = icon("chart-bar")),
        menuSubItem("Table", tabName = "dbhcat",icon = icon("table"))
      )),
    dashboardBody(
      tabItems(
        tabItem("Distribution (dbh)",tabName = "Graphic",
                fluidRow(
                  box(plotOutput("plot1")),
                  box(numericInput('psize', 'Plot size', 400,
                                   min = 10, max = 100000)),
                  box(numericInput('dmean', 'Mean diameter (cm)', 20,
                                         min = 7.5, max = 200)),
                  box(numericInput('dmx', 'Max diameter (cm)', 40,
                                         min = 7.5, max = 200))
                  )),
        tabItem("h/d model",tabName = "hdnaslund",
                DT::dataTableOutput("plot2")),

        tabItem("Table",tabName = "dbhcat",
                DT::dataTableOutput("mytable")
        )

      )

    )
    
  )
)