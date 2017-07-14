library(dplyr)

undergrad_data <- read.csv("~/R_Code/Shiny_App/undergrad.csv", stringsAsFactors = FALSE)

# undergrad$avg_tuition = as.numeric(undergrad$avg_tuition)
# undergrad$avg_cost = as.numeric(undergrad$avg_cost)
# undergrad$md_debt = as.numeric(undergrad$md_debt)
# undergrad$md_earnings_10 = as.numeric(undergrad$md_earnings_10)
# undergrad$pct_25k = as.numeric(undergrad$pct_25k)
# undergrad$default_rate = as.numeric(undergrad$default_rate)
# undergrad$comp_deg = as.numeric(undergrad$comp_deg)
# undergrad$eng_deg = as.numeric(undergrad$eng_deg)
# undergrad$engtech_deg = as.numeric(undergrad$engtech_deg)
# undergrad$math_deg = as.numeric(undergrad$math_deg)
# undergrad$sci_deg = as.numeric(undergrad$sci_deg)
undergrad_data$school_type = as.factor(undergrad_data$school_type)

#undergrad = undergrad %>% filter(., !is.na(MD_EARN_WNE_P10)) 

