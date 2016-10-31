# rankall takes two arguments: an outcome name (outcome) and a hospital 
# ranking (num). The function reads the outcome-of-care-measures.csv file and 
# returns a 2-column data frame containing the hospital in each state that has 
# the ranking specified in num.
# The function should return a value for every state (some may be NA). 
# The first column in the data frame is named hospital, which contains
# the hospital name, and the second column is named state, 
# which contains the 2-character abbreviation for the state name. 
# Hospitals that do not have data on a particular outcome should be excluded 
# from the set of hospitals when deciding the rankings.
#
# Acoording to the data book, "Death Mortality Rates" are in columns 11, 17 and 23
#
#
# MAR, november/2016

rankall <- function(outcome, num= "best") {
  
  # Test the outcome argument
  outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  if (! (outcome %in% names(outcomes))) {
    stop ("invalid outcome")
  } 
  
  # Test the num argument. 
  # Initialize hrank if num is a number or it is "best"
  # defer the hrank when num is worst
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
  
  # create a data frame from a split on state
  df_by_state <- split(sub_df, sub_df$State)
  
  # initialize hospital and state that will build an output data frame later
  hospital <- character()
  state <- character()
  
  # loop over each state
  for (st in names(df_by_state)) {
    # if num is worst, evaluate hrank as the last row of set
    if (is.na (hrank))
      hrank <- nrow(df_by_state[[st]])
    # get the hospital and state at specified rank (aka num)
    hospital <- c (hospital, df_by_state[[st]][hrank, 1])
    state <- c(state, df_by_state[[st]][hrank, 2])
  }
  data.frame (hospital, state)
}