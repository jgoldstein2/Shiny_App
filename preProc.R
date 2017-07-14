library(dplyr)

scorecard_data <- read.csv("~/R_Code/CollegeScorecard_Raw_Data/Most_Recent_Cohorts.csv", stringsAsFactors = FALSE)

# Filter out only schools that are predominantly bachelor's degree providing
# Get rid of mischaracterized schools - want just schools that offer bachelor's
# Get rid of non-operating schools

undergrad_full = scorecard_data %>%  filter(., PREDDEG == 3)
undergrad_full = undergrad_full %>% filter(., CCBASIC %in% seq(14,23))
undergrad_full = undergrad_full %>% filter(., CURROPER == 1)

undergrad = undergrad_full %>% select(., college = INSTNM, city = CITY, state = STABBR, region = REGION, locale = LOCALE, lat = LATITUDE, long = LONGITUDE, school_type = CONTROL, adm_rate = ADM_RATE, adm_rate_all = ADM_RATE_ALL, avg_net_pub = NPT4_PUB, avg_net_priv = NPT4_PRIV, avg_cost = COSTT4_A, avg_tuition = TUITFTE, population = UGDS, avg_fam_inc = FAMINC, md_fam_inc = MD_FAMINC, pct_loan = PCTFLOAN, pct_pell = PCTPELL, md_debt = GRAD_DEBT_MDN_SUPP, md_earnings_10 = MD_EARN_WNE_P10, pct_25k = GT_25K_P10, default_rate = CDR3, repay_rate = RPY_7YR_RT, comp_deg = PCIP11, eng_deg = PCIP14, engtech_deg = PCIP15, math_deg = PCIP27, sci_deg = PCIP40)


undergrad$avg_tuition = as.numeric(undergrad$avg_tuition)
undergrad$avg_cost = as.numeric(undergrad$avg_cost)
undergrad$md_debt = as.numeric(undergrad$md_debt)
undergrad$md_earnings_10 = as.numeric(undergrad$md_earnings_10)
undergrad$pct_25k = as.numeric(undergrad$pct_25k)
undergrad$default_rate = as.numeric(undergrad$default_rate)
undergrad$comp_deg = as.numeric(undergrad$comp_deg)
undergrad$eng_deg = as.numeric(undergrad$eng_deg)
undergrad$engtech_deg = as.numeric(undergrad$engtech_deg)
undergrad$math_deg = as.numeric(undergrad$math_deg)
undergrad$sci_deg = as.numeric(undergrad$sci_deg)
undergrad$school_type = as.factor(undergrad$school_type)

undergrad = undergrad %>% filter(., md_earnings_10 != "NULL") 
undergrad = undergrad %>% filter(., md_earnings_10 != "PrivacySuppressed")

write.csv(undergrad, file = "undergrad.csv", row.names = FALSE)