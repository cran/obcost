#' @title rel_risk_fun function

#' @description The "rel_risk_fun" could update the relative risks (or the constants) when crucial data needs updating

#' @return a list (dataframe) of relative risks

#' @examples
#' key <- rel_risk_fun(rr = c(1,2,3,4,5,6,7,8,1.2))
#' key$rr

#' @param rr the relative risks of diseases -- Cardiovascular disease, diabetes, cancer, Chronic obstructive pulmonary disease or asthma, osteoarthritis, hypertension, kidney diseases, (Gallbladder, Liver, Pancreatic) diseases, and strokes.

#' @export

rel_risk_fun <- function(rr){
  if(requireNamespace("dplyr")){
  } else {
    message("Please install dplyr")
  }

  if(requireNamespace("tidyr")){
  } else {
    message("Please install tidyr")
  }
  rel_risk <- full_data$rel_risk
  if(length(rr)!=nrow(rel_risk)){
    return('wrong, the length of rr is not equal to nrow of rel_risk')
  }else{
    rel_risk_new = rel_risk
    rel_risk_new$rr = rr
    # constant = rel_risk_new
    full_data$rel_risk = rel_risk_new
    return(rel_risk_new)
  }
}
