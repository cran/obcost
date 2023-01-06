#' @title data_produce function

#' @description The data_produce function would generate the essential four tables that
#' concerns obesity including
#' 1. Relative Risks (constant): Relative risks for a given disease group with a risk factor of obesity.
#' 2. Disease Cost (obesity_cost_disease): Supplementary output with all variables related to individual disease groups in a given state and year.
#' 3. Full Cost (obesity_cost_full): Complete output with all variables used to make cost calculations, as well as cost calculations in a given state and year.
#' 4. National Summary (obesity_cost_national_summary): National summary cost calculations in a given year.

#' @return a list (dataframe) of constant, obesity_cost_disease, obesity_cost_full, and obesity_cost_national_summary

#' @examples
#' new_data <- data_produce(rr = c(1,2,3,4,5,6,7,8,9.1))
#' cnst <- new_data$constant

#' @param rr the relative risks of diseases -- Cardiovascular disease, diabetes, cancer, Chronic obstructive pulmonary disease or asthma, osteoarthritis, hypertension, kidney diseases, (Gallbladder, Liver, Pancreatic) diseases, and strokes.

#' @export

#' @import dplyr tidyr

data_produce <- function(rr = c()){

  if(requireNamespace("dplyr")){
  } else {
    message("Please install dplyr")
  }

  if(requireNamespace("tidyr")){
  } else {
    message("Please install tidyr")
  }

  result = full_data

  pop = result$pop
  gdp = result$gdp
  mi = result$mi
  bmi = result$bmi
  disab = result$disab
  employ = result$employ
  med_cost = result$med_cost
  med_prev = result$med_prev
  natl_med_prev = result$natl_med_prev
  rel_risk = result$rel_risk
  benefits = result$benefits
  insurance = result$insurance

  if(length(rr)!=nrow(rel_risk)){
    rel_risk = result$rel_risk
    message('the data of rel_risk is original data!')
  }else{
    message('the data of rel_risk is updata!')
    rel_risk <- rel_risk_fun(rr)
  }

  gdp <- data.frame(gdp %>%
                      pivot_longer(-State, names_to = "Year", values_to = "gdp_in_millions"))

  natl_gdp <- subset(gdp, State == "United States") %>%
    select(!State) %>% rename("natl_gdp_in_millions" = "gdp_in_millions")

  medical_data <- merge(med_cost, med_prev, by = c("Year","cause")) %>%
    merge(natl_med_prev, by = c("Year","cause")) %>%
    merge(rel_risk, by = "cause")

  national_data <- merge(mi, disab, by = "Year") %>%
    merge(employ, by = "Year") %>%
    merge(benefits, by = "Year") %>%
    merge(natl_gdp, by = "Year") %>%
    rename("income" = "Estimate")

  state_data <- merge(pop, bmi, by = c("Year", "State")) %>%
    merge(gdp, by = c("Year","State"))

  obesity_data <- merge(national_data, state_data, by = "Year") %>%
    merge(medical_data, by = c("Year","State"))

  obesity_data_varnames <- obesity_data %>%
    mutate(med_cost_millions = med_cost_millions*1000000,
           perc_disability = perc_disability/100,
           perc_employed = perc_employed/100,
           perc_benefits = perc_benefits/100,
           varphi_it = gdp_in_millions/natl_gdp_in_millions) %>%
    rename("m_t" = "income",
           "d_t" = "perc_disability",
           "e_t" = "perc_employed",
           "p_it" = "pop",
           "pi_it" = "perc_obese",
           "psi_jt" = "med_cost_millions",
           "rr_j" = "rr",
           "b_t" = "perc_benefits") %>%
    mutate(rho_jit = pi_it*(rr_j-1)/(1+pi_it*(rr_j-1)),
           tau_t = ((m_t)/(1-b_t)))

  direct_cost <- obesity_data_varnames %>%
    mutate(DC_jit = psi_jt*varphi_it*rho_jit) %>%
    select(c(Year, State, cause, DC_jit))

  direct_totals <- aggregate(DC_jit ~ Year + State,direct_cost, sum) %>%
    rename("DC_it" = "DC_jit")

  mortality_cost <- obesity_data_varnames %>%
    mutate(M_it = (5.8/12)*(1/45)*tau_t*p_it*pi_it*e_t) %>%
    select(c(Year, State, M_it))%>%
    unique()

  absenteeism_cost <- obesity_data_varnames %>%
    mutate(A_it = (4/261)*p_it*pi_it*e_t*tau_t) %>%
    select(c(Year, State, A_it)) %>%
    unique()

  disability_cost <- obesity_data_varnames %>%
    mutate(D_it = 0.06*p_it*e_t*tau_t*((pi_it*0.24)/(1+(0.24*pi_it)))) %>%
    select(c(Year, State, D_it))%>%
    unique()

  total_cost <- merge(direct_totals, mortality_cost, by = c("State","Year")) %>%
    merge(absenteeism_cost, by = c("State","Year")) %>%
    merge(disability_cost, by = c("State","Year")) %>%
    mutate(IC_it = M_it + A_it + D_it,
           TC_it = IC_it + DC_it)

  disease_costs <- merge(direct_cost, mortality_cost, by = c("State","Year")) %>%
    merge(absenteeism_cost, by = c("State","Year")) %>%
    merge(disability_cost, by = c("State","Year")) %>%
    mutate(IC_it = M_it + A_it + D_it)

  summary_file <- merge(obesity_data_varnames, total_cost, by = c("State","Year")) %>%
    select(c(State,Year,DC_it, M_it, A_it, D_it, IC_it, TC_it)) %>%
    unique()

  full_flat_file <- merge(obesity_data_varnames, total_cost, by = c("State","Year")) %>%
    select(c(State,Year,m_t,d_t,e_t,b_t,p_it,pi_it,tau_t,varphi_it,DC_it, M_it, A_it, D_it, IC_it, TC_it)) %>%
    unique()

  disease_costs <- merge(obesity_data_varnames, disease_costs, by = c("State","Year","cause")) %>%
    select(c(State, Year, pi_it, cause, rr_j, psi_jt, rho_jit, DC_jit))

  direct_sum <- aggregate(total_cost[, 3], list(total_cost$Year), sum) %>%
    rename("Year" = "Group.1",
           "DC_t" = "x")
  ##Mortality
  mort_sum <- aggregate(total_cost[, 4], list(total_cost$Year), sum)%>%
    rename("Year" = "Group.1",
           "M_t" = "x")
  ##Absenteeism
  abs_sum <- aggregate(total_cost[, 5], list(total_cost$Year), sum)%>%
    rename("Year" = "Group.1",
           "A_t" = "x")
  ##Disability
  dis_sum <- aggregate(total_cost[, 6], list(total_cost$Year), sum)%>%
    rename("Year" = "Group.1",
           "D_t" = "x")
  ##Total IC
  indirect_sum <- aggregate(total_cost[, 7], list(total_cost$Year), sum)%>%
    rename("Year" = "Group.1",
           "IC_t" = "x")

  ##Total Cost
  total_sum <- aggregate(total_cost[, 8], list(total_cost$Year), sum)%>%
    rename("Year" = "Group.1",
           "TC_t" = "x")

  ##Total Population
  pop_sum <- aggregate(pop[, 3], list(pop$Year), sum)%>%
    rename("Year" = "Group.1",
           "p_t" = "pop")

  ##Total Obesity
  bmi_avg <- aggregate(bmi[, 3], list(bmi$Year), mean)%>%
    rename("Year" = "Group.1",
           "pi_t" = "perc_obese")

  obesity_national_summary <- merge(direct_sum, mort_sum, by = "Year") %>%
    merge(abs_sum, by = "Year") %>%
    merge(dis_sum, by = "Year") %>%
    merge(indirect_sum, by = "Year") %>%
    merge(total_sum, by = "Year") %>%
    merge(pop_sum, by = "Year") %>%
    merge(bmi_avg, by = "Year")

  ##Insurance
  ins_sum <- aggregate(insurance[, 3], list(insurance$Year), sum)%>%
    rename("Year" = "Group.1",
           "life_health" = "x")

  insurance_national_summary <- merge(obesity_national_summary, ins_sum, by = "Year")

  pop = result$pop
  gdp = result$gdp
  mi = result$mi
  bmi = result$bmi
  disab = result$disab
  employ = result$employ
  med_cost = result$med_cost
  med_prev = result$med_prev
  natl_med_prev = result$natl_med_prev
  benefits = result$benefits
  insurance = result$insurance

  constant  <- rel_risk
  obesity_cost_disease <- disease_costs
  obesity_cost_full <- full_flat_file
  obesity_cost_national_summary <- obesity_national_summary

  #new_result = list(pop = pop,gdp = gdp,mi = mi,bmi = bmi,disab = disab,employ = employ,med_cost = med_cost,med_prev = med_prev,natl_med_prev = natl_med_prev,rel_risk = rel_risk,benefits = benefits,insurance = insurance,rel_risk = rel_risk, summary_file = summary_file,full_flat_file = full_flat_file,disease_costs = disease_costs,obesity_national_summary = obesity_national_summary,insurance_national_summary = insurance_national_summary)
  new_result = list(constant = constant,obesity_cost_disease = obesity_cost_disease,obesity_cost_full = obesity_cost_full,obesity_cost_national_summary = obesity_cost_national_summary)
  return(new_result)
}
