library(shiny)
library(ggplot2)
library(shinydashboard)
library(googleVis)
library(shinythemes)
library(leaflet)
library(DT)
library(maps)
library(plotly)

shinyUI(dashboardPage(skin = "red",
  dashboardHeader(title = "College Scorecard Data", titleWidth = 250),
  dashboardSidebar(
    sidebarUserPanel("",
                     image = "http://dasycenter.org/wp-content/uploads/2015/01/doed-logo.gif"),
    sidebarMenu(
      menuItem("Explore Data", tabName = "table", icon = icon("table")), 
      menuItem("Data by College", tabName = "scatter", icon = icon("line-chart")),
      menuItem("Data by State", tabName = "map", icon = icon("map")),
      menuItem("Data by School Type", tabName = "data", icon = icon("area-chart"))
      )
    ),
  dashboardBody(
    tags$head(
      tags$link(rel="stylesheet", type="text/css", href="custom.css")
    ),
    tabItems(
     
       tabItem(tabName = "table",
              fluidRow(
                column(4, selectizeInput(inputId = "selected",  #add dropdown menu for user to sort table
                               label = "Show Top 25 Schools By:",
                               choices = colnames(undergrad_table)[c(-1,-2)],
                               selected = "Admission Rate")) 
                ),
              fluidRow(
                box(DT::dataTableOutput("table"), width = 12)) #add datatable to user interface
              ),
      
       
       tabItem(tabName = "scatter",
               fluidRow(
                 column(4,
                        sliderInput("adm_rate", "Filter By Rate of Admissions", #add slider input for user to filter by admission rate
                                    0, 1, value = c(0, 1), step = .05)
                 ),
                 column(4,
                        sliderInput("pop", "Filter By School Size", #add slider input for user to filter by student population
                                    0, 55000, value = c(0, 55000), step = 5000)
                 ),
                 column(4,
                        selectizeInput(inputId = "school_type", #add dropdown menu for user to select school type
                                       label = "Filter By School Type",
                                       choices = c('All','Public', 'Private Non-Profit', 'Private For-Profit'))
                 )
               ),
               fluidRow(htmlOutput("scatterPlot"), width = 12)), #add scatterplot to user interface
       
       tabItem(tabName = "map",
               fluidRow(column(4, selectizeInput(inputId = "mapval", #add dropdown menu for user to select data to map
                                       label = "Choose Value to Map:",
                                       choices = c('Cost','Debt', 'Earnings'),
                                       selected = 'Cost')),
               column(4, infoBoxOutput("maxBox")), tags$style("#maxBox {width:300px; height:50px;}"),
               column(4, infoBoxOutput("minBox")), tags$style("#minBox {width:300px;}")),
               fluidRow(leafletOutput("mymap"))), #add map to user interface)
      
      tabItem(tabName = "data",
              selectizeInput(inputId = "density", #add dropdown menu for user to select data to plot
                             label = "Choose Value to Plot:",
                             choices = c("Median Family Income", "Students on Loans (%)", "Median Debt",
                                         "Default Rate (%)", "Repayment Rate", "Median Earnings")),
              fluidRow(column(12, align = "center", box(plotlyOutput("densityPlot"), width = "auto", height = 525, background = "blue"))))  #add density chart to user interface

      )
  )
))

