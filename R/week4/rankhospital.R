# rankhospital takes three arguments: the 2-character abbreviated name of a
# state (state), an outcome (outcome), and the ranking of a hospital in that 
# state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a 
# character vector with the name of the hospital that has the ranking specified 
# by the num argument.
#
# Acoording to the data book, "Death Mortality Rates" are in columns 11, 17 and 23
#
#
# MAR, november/2016

rankhospital <- function(state, outcome, num= "best") {
  
  # Test the outcome argument
  outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  if (! (outcome %in% names(outcomes))) {
    stop ("invalid outcome")
  } 
  
  if (typeof (num)=="double")
    hrank <- num
  else if (num=="best")
      hrank <- 1
  else if (num=="worst")
      hrank <- NA
  else
    stop ("invalid num")
  
  # Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available",  stringsAsFactors=FALSE )
  
  # subset the data frame for only 3 columns: Hospital Name(column 2); State(column 7) and outcome.
  sub_df <- df[, c(2, 7, outcomes[outcome])]
  idx <- complete.cases(sub_df)
  sub_df <- sub_df[idx, ]
  
  # sort (aka order) the data frame by state (column 2); outcome (column 3) and hospital name (column 1).
  idx <- order(sub_df[2], sub_df[3], sub_df[1])
  sub_df <- sub_df[idx, ]
  
  # only the selected  state
  by_state <- sub_df[sub_df$State==state,]
  if (nrow(by_state)==0) {
    stop ("invalid state")
  } 
  # get the hospital name with the selected rank
  if (is.na (hrank))
    by_state[nrow(by_state), 1]
  else
    by_state[hrank, 1]
  
}