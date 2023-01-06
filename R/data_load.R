#' @title data_load function

#' @description The function "data_load" would load all critical values in a returned list format

#' @return a list(dataframe) of pop (population), gdp (global gdp),
#' mi (median income), bmi (body mass index), disab (disability rate),
#' employ (employment rate), med_cost (medical conditions cost),
#' med_prev (medical conditions prevalence cost),
#' natl_med_prev  (national medical conditions prevalence),
#' rel_risk (relative risk), benefits, and insurance

#' @examples
#' raw_data <- data_load()
#' population <- raw_data$pop

#' @export


#### Function
data_load<-function(){
  if(requireNamespace("dplyr")){
  } else {
    message("Please install dplyr")
  }

  if(requireNamespace("tidyr")){
  } else {
    message("Please install tidyr")
  }

  pop <- full_data$pop

  gdp <- full_data$gdp

  mi <- full_data$mi

  bmi <- full_data$bmi

  ##"Unpivots" BMI Data

  disab <- full_data$disab

  employ <- full_data$employ

  med_cost <-full_data$med_cost

  med_prev <- full_data$med_prev

  natl_med_prev <- full_data$natl_med_prev

  rel_risk <- full_data$rel_risk

  benefits <- full_data$benefits

  insurance <- full_data$insurance

  result = list(pop = pop,gdp = gdp,mi = mi,bmi = bmi,disab = disab,employ = employ,med_cost = med_cost,med_prev = med_prev,natl_med_prev = natl_med_prev,rel_risk = rel_risk,benefits = benefits,insurance = insurance)

  return(result)}

