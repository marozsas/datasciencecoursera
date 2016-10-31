# The function best take two arguments: the 2-character abbreviated name of a 
# state and an outcome name. The function reads the outcome-of-care-measures.csv
# file and returns a character vector with the name of the hospital that has the
# best (i.e. lowest) 30-day mortality for the specified outcome in that state. 
# The hospital name is the name provided in the Hospital.Name variable. 
# The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. 
# Hospitals that do not have data on a particular outcome should be excluded 
# from the set of hospitals when deciding the rankings.
# Handling ties. If there is a tie for the best hospital for a given outcome, 
# then the hospital names should be sorted in alphabetical order and the first 
# hospital in that set should be chosen (i.e. if hospitals “b”, “c”, and “f” 
# are tied for best, then hospital “b” should be returned).
#
# Acoording to the data book, "Death Mortality Rates" are in columns 11, 17 and 23
#
#
# MAR, november/2016

best <- function(state, outcome) {
  
  # Test the outcome argument
  outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  if (! (outcome %in% names(outcomes))) {
    stop ("invalid outcome")
  } 
  # Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available",  stringsAsFactors=FALSE )
  
  # subset the data frame for only 3 columns: Hospital Name(column 2); State(column 7) and outcome.
  sub_df <- df[, c(2, 7, outcomes[outcome])]
  idx <- complete.cases(sub_df)
  sub_df <- sub_df[idx, ]
  
  # sort (aka order) the data frame by outcome column (column 3).
  idx <- order(sub_df[2], sub_df[3], sub_df[1])
  sub_df <- sub_df[idx, ]
  
  # only the selected  state
  by_state <- sub_df[sub_df$State==state,]
  if (nrow(by_state)==0) {
    stop ("invalid state")
  } 
  # get the hospital name with the smallest outcome of a state
  by_state[1, 1]
}