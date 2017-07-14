library(shiny)
library(ggplot2)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "College Scorecard"),
  dashboardSidebar(
    sidebarUserPanel("Julia Goldstein"),
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Data", tabName = "data", icon = icon("area-chart")),
      menuItem("Scatter", tabName = "scatter", icon = icon("line-chart"))
      )
    ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
              "to be replaced with map and histogram"),
      tabItem(tabName = "data",
              selectizeInput(inputId = "density",
                             label = "X-Value",
                             choices = c('md_earnings_10','md_debt', 'default_rate', 'pct_25k')),
              plotOutput("densityPlot")),
      tabItem(tabName = "scatter",
              sliderInput("adm_rate", "Rate of Admissions",
                          0, 1, value = c(0, 1), step = .1),
              sliderInput("pop", "School Size",
                          0, 55000, value = c(0, 55000), step = 5000),
              selectizeInput(inputId = "school_type",
                             label = "Type of School",
                             choices = c('All','Public', 'Private Non-Profit', 'Private For-Profit')),
              fluidRow(htmlOutput("scatterPlot")))
      )
  )
))


# fluidPage(title = "College Scorecard App",
#           navlistPanel(
#             tabPanel(title = "tab1",
#                      
#             ),
#             tabPanel(title = "tab2",
#                      selectizeInput(inputId = "test",
#                                     label = "Test Menu",
#                                     choices = c('a','b','c')),
#                      plotOutput("barPlot")
#             )
#           ))