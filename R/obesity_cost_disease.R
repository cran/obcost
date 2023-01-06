#' @title Relevant Data for Obesity, Cost, and Diseases
#' @description This dataset gives supplementary output with all variables
#' related to individual disease groups in a given state and year.
#' \describe{
#' \item{State}{state of interest}
#' \item{Year}{year of interest}
#' \item{pi_it}{obesity prevalence in state i and year t}
#' \item{cause}{disease group}
#' \item{rr_j}{relative risk of disease group j on obesity}
#' \item{psi_jt}{national cost of disease group j in year t}
#' \item{rho_jit}{population-attributable risk percent of disease group j in state i and year t}
#' \item{DC_jit}{direct cost for disease group j in state i and year t}
#' }
"obesity_cost_disease"
