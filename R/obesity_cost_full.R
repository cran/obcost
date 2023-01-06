#' @title Relevant Data for Obesity, Cost, and Diseases
#' @description Complete output with all variables used to make cost
#' calculations, as well as cost calculations in a given state and year.
#' \describe{
#' \item{State}{state of interest}
#' \item{Year}{year of interest}
#' \item{m_t}{median income in year t}
#' \item{d_t}{work-impacting disability prevalence in year t}
#' \item{e_t}{employment average ration in year t}
#' \item{b_t}{employment benefit in year t}
#' \item{p_it}{population in state i and year t}
#' \item{pi_it}{obesity prevalence in state i and year t}
#' \item{tau_t}{total employee benefits in year t}
#' \item{varphi_it}{gross domestic product of state i in year t}
#' \item{DC_it}{direct cost of state i in year t}
#' \item{M_it}{excess mortality cost of state i in year t}
#' \item{A_it}{absenteeism cost of state i in year t}
#' \item{D_it}{disability cost of state i in year t}
#' \item{IC_it}{indirect cost of state i in year t}
#' \item{TC_it}{total cost of state i in year t}
#' }
"obesity_cost_full"
