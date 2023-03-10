#' @note Please make sure that packages of dplyr and tidyr is applied

#' @description This database contains necessary data relevant to medical costs on obesity
#'  throughout the United States. This database, in form of an R package, could
#'  output necessary data frames relevant to obesity costs, where the clients
#'  could easily manipulate the output using difference parameters,
#'  e.g. relative risks for each illnesses.
#'
#' So far the functions included in the package are:
#' \itemize{
#'   \item \code{\link{data_load}} generate the essential four tables that concerns obesity
#'   \item \code{\link{data_produce}} load all critical values in a returned list format
#'   \item \code{\link{rel_risk_fun}} update the relative risks (or the constants) when crucial data needs updating
#' }
#'
#' The database is composed of the following main tables:
#' \itemize{
#'   \item \code{\link{constant}} Relative risks for a given disease group with a risk factor of obesity.
#'   \item \code{\link{obesity_cost_disease}} Supplementary output with all variables related to individual disease groups in a given state and year.
#'   \item \code{\link{obesity_cost_full}} Complete output with all variables used to make cost calculations, as well as cost calculations in a given state and year.
#'   \item \code{\link{obesity_cost_national_summary}} National summary cost calculations in a given year.
#'   \item \code{\link{full_data}} Necessary raw data for generating new tables with user input
#' }
#'
#' This package contributes to parts of our published journal named "Modeling
#' the Economic Cost of Obesity Risk and Its Relation to the Health Insurance
#' Premium in the United States: A State Level Analysis"
#' Please use the following citation for the journal:
#' Woods Thomas, Tatjana Miljkovic. 2022. Modeling the Economic Cost of Obesity
#' Risk and Its Relation to the Health Insurance Premium in the United States:
#' A State Level Analysis. Risks 10: 197. <doi:10.3390/risks10100197>
#'
#' \tabular{ll}{
#' Package: \tab obcost\cr
#' Type: \tab Package\cr
#' Version: \tab 0.1.0\cr
#' Date: \tab 2022-10-23\cr
#' License: \tab public\cr
#' LazyData: \tab no\cr
#' }
#'
#'
#' @examples
#if (requireNamespace("dplyr")) {
#'med_cost <- full_data$med_cost
#'med_prev <- full_data$med_prev
#'medical_data <- merge(med_cost, med_prev, by = c("Year","cause")) %>%
#'    mutate(cause = recode(cause,cancer="Neoplasms", copd_asthma="Respiratory",
#'            cvd="Cardiovascular", diabetes="Diabetes",
#'            g_p_l="Biliary",hypertension="Hypertension",
#'            osteoarthritis="Osteoarthritis", stroke="Stroke",
#'            kidney = "Kidney", cerebrovascular = "Cerebrovascular")) %>%
#'    filter(cause == "Neoplasms", State == "Ohio") %>%
#'    select(Year, prevalence)
#'plot(x=medical_data$Year, y=medical_data$prevalence, main = "Medical Prevalence of Neoplasms in 1996",
#'        xlab = "State", ylab = "Medical Prevalence")
#'lines(x=medical_data$Year, y=medical_data$prevalence, type = "l", lty = 1)
#'}

#' @import dplyr tidyr

#' @importFrom stats aggregate


#' @references {
#' State Population Totals. 2020. State Population Totals and Components of Change: 2010???2019. Suitland: U.S. Census Bureau. Available online: www.census.gov (accessed on 20 July 2021).
#'
#' Current Population Survey Annual Social and Economic Supplements. 2020. Income and Poverty in the United States: 2019. Available online: www.census.gov (accessed on 20 July 2021).
#'
#' Disability Characteristics. 2020. American Community Survey (acs). Available online: www.census.gov (accessed on 20 July 2021).
#'
#' Characteristics of the Employed. 2020. Current Population Survey (cps). Available online: www.bls.gov (accessed on 20 July 2021).
#'
#' Employer Costs for Employee Compensation. 2021. Archived News Releases. Available online: www.bls.gov (accessed on 20 July 2021).
#'
#' Table of Overweight and Obesity (BMI). 2020. Behavioral Risk Factor Surveillance System. Available online: www.cdc.gov (accessed on 21 July 2021).
#'
#' Premium, Schedule T., and Annuity Considerations. 2020. Total Health Industry Schedule T Allocated by States and Territories. Available online: www.spglobal.com (accessed on 29 October 2021).
#'
#' Murray, Christopher J. L., Aleksandr Y. Aravkin, Peng Zheng, Cristiana Abbafati, Kaja M. Abbas, Mohsen Abbasi-Kangevari, Foad Abd-Allah, Ahmed Abdelalim, Mohammad Abdollahi, Ibrahim Abdollahpour, and et al. 2020. Global burden of 87 risk factors in 204 countries and territories, 1990???2019: A systematic analysis for the global burden of disease study 2019. The Lancet 396: 1223???249. [CrossRef]
#'
#' Consumer Price Index. 2021. All Urban Consumers (Current Series). Available online: www.bls.gov (accessed on 21 July 2021).
#'}
#' @author Tianyue Zang (\email{zangt2@@miamioh.edu})(\email{zangtianyue.312@@163.com}) Thomas Woods, Tatjana Miljkovic
#'
#' Maintainer: Tianyue Zang (\email{zangt2@@miamioh.edu})(\email{zangtianyue.312@@163.com})
#' @name obcost-package
#' @aliases obcost
#' @docType package
#' @title Obesity Cost Database
#' @keywords package datasets
NULL
