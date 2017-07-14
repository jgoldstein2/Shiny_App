library(shiny)
library(ggplot2)
library(googleVis)

function(input, output) {
  output$barPlot = renderPlot({
    cost = undergrad_data %>% filter(., !is.na(avg_cost)) %>% arrange(., desc(avg_cost))
    ggplot(cost[1:20,], aes(x=college, y=avg_cost)) +
      geom_bar(stat="identity", fill="#53cfff") +
      geom_text(aes(x=college, y=avg_cost-500, hjust=0.95, label=paste0("$", avg_cost)), size=4) + 
      theme_light(base_size=16) +
      theme(axis.text.y = element_text(hjust=0, color="black"), axis.text.x=element_blank()) +
      xlab("") + ylab("") +
      coord_flip() +
      ggtitle("Most Expensive Colleges")
  })
  
  selectedDensity <- reactive({
    undergrad_data %>% select(., input$density)
  })
  
  output$densityPlot = renderPlot({
    ggplot(undergrad_data, aes(x=selectedDensity(), color=school_type, fill=school_type, group=school_type)) +
      geom_density(alpha=0.3) +
      theme_light(base_size=16) +
      xlab("") + ylab("") 
  })

  scatter_data <- undergrad_data[,c("college", "school_type", "avg_cost", "md_debt")]
  #rownames(scatter_data) = undergrad$college
  scatter_data$school_type = as.character(scatter_data$school_type)
  scatter_data[["pub"]] = ifelse(scatter_data[["school_type"]]=="1", scatter_data[["avg_cost"]], NA)
  scatter_data[["pub.tooltip"]] = scatter_data[["college"]]
  scatter_data[["priv"]] <- ifelse(scatter_data[["school_type"]]=="2", scatter_data[["avg_cost"]], NA)
  scatter_data[["priv.tooltip"]] = scatter_data[["college"]]
  scatter_data[["privprof"]] = ifelse(scatter_data[["school_type"]]=="3", scatter_data[["avg_cost"]], NA)
  scatter_data[["privprof.tooltip"]] = scatter_data[["college"]]
  scatter_data[["avg_cost"]] = NULL

  filtered_scatter = reactive({
    if (input$school_type == 'All') {
      (scatter_data)
    } else if (input$school_type == 'Public') {
      (scatter_data %>% filter(., school_type == "1"))
    } else if (input$school_type == 'Private Non-Profit') {
      (scatter_data %>%  filter(., school_type == "2"))
    } else {
      (scatter_data %>%  filter(., school_type == "3"))
    }

  })

  #scatter_data2 = scatter_data %>% select(., 2, 3, 4, 5, 7, 6, 8)
  output$scatterPlot = renderGvis({
    filtered_scatter2 = filtered_scatter() %>% select(., -1, -2)
    my_options <- list(width="900px", height="450px",
                       title="Average Cost & Debt by School Type",
                       hAxis="{title:'Median Debt'}",
                       vAxis="{title:'Average Cost'}")
    scatter = gvisScatterChart(filtered_scatter2, options = my_options)
    plot(scatter)
  })

}