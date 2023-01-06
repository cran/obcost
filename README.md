# obcost

## Description
obcost is a database contains necessary data relevant to medical costs on obesity 
throughout the United States. This database, in form of an R package, could
output necessary data frames relevant to obesity costs, where the clients
could easily manipulate the output using difference parameters,
e.g. relative risks for each illnesses.

## Functions
So far the functions included in the package are:

### data_load
generate the essential four tables that concerns obesity

### data_produce 
load all critical values in a returned list format

### rel_risk_fun 
update the relative risks (or the constants) when crucial data needs updating

## Details
Package:	obcost
Type:	Package
Version:	0.1.0
Date:	2022-10-23
License:	public
LazyData:	no

## Tables
The database is composed of the following main tables:

### constant Relative 
Risks for a given disease group with a risk factor of obesity.

### obesity_cost_disease 
Supplementary output with all variables related to individual disease groups in a given state and year.

### obesity_cost_full 
Complete output with all variables used to make cost calculations, as well as cost calculations in a given state and year.

### obesity_cost_summary 
National summary cost calculations in a given year.

### fun_data Necessary 
Raw data for generating new tables with user input

## Import
Please make sure that packages of dplyr and tidyr is applied

## Authors
Tianyue Selina Zang (zangt2@miamioh.edu)(zangtianyue.312@163.com) Thomas Woods, Tatjana Miljkovic

Maintainer: Tianyue Selina Zang (zangt2@miamioh.edu)(zangtianyue.312@163.com)

## Contribute/ Source
This package contributes to parts of our published journal named "Modeling the Economic Cost of Obesity Risk and Its Relation to the Health 
Insurance Premium in the United States: A State Level Analysis" Please use the following citation for the journal: Woods Thomas, 
Tatjana Miljkovic. 2022. Modeling the Economic Cost of Obesity Risk and Its Relation to the Health Insurance Premium in the United States: 
A State Level Analysis. Risks 10: 197. https://doi.org/10.3390/risks 10100197

## References
State Population Totals. 2020. State Population Totals and Components of Change: 2010–2019. Suitland: U.S. Census Bureau. Available online: www.census.gov (accessed on 20 July 2021).

Current Population Survey Annual Social and Economic Supplements. 2020. Income and Poverty in the United States: 2019. Available online: www.census.gov (accessed on 20 July 2021).

Disability Characteristics. 2020. American Community Survey (acs). Available online: www.census.gov (accessed on 20 July 2021).

Characteristics of the Employed. 2020. Current Population Survey (cps). Available online: www.bls.gov (accessed on 20 July 2021).

Employer Costs for Employee Compensation. 2021. Archived News Releases. Available online: www.bls.gov (accessed on 20 July 2021).

Table of Overweight and Obesity (BMI). 2020. Behavioral Risk Factor Surveillance System. Available online: www.cdc.gov (accessed on 21 July 2021).

Premium, Schedule T., and Annuity Considerations. 2020. Total Health Industry Schedule T Allocated by States and Territories. Available online: www.spglobal.com (accessed on 29 October 2021).

Murray, Christopher J. L., Aleksandr Y. Aravkin, Peng Zheng, Cristiana Abbafati, Kaja M. Abbas, Mohsen Abbasi-Kangevari, Foad Abd-Allah, Ahmed Abdelalim, Mohammad Abdollahi, Ibrahim Abdollahpour, and et al. 2020. Global burden of 87 risk factors in 204 countries and territories, 1990–2019: A systematic analysis for the global burden of disease study 2019. The Lancet 396: 1223–249. [CrossRef]

Consumer Price Index. 2021. All Urban Consumers (Current Series). Available online: www.bls.gov (accessed on 21 July 2021).

