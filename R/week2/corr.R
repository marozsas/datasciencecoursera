corr <- function (directory, thresold= 0) {
  # I could call complete() as below, but since I have to replicate all code from 
  # complete.R to use the vector c, there is no point to call a function and redo 
  # all steps again.
  #c <- complete("specdata")
  #tids <- c[c$nobs>thresold, "ID"]
  
  id <-  1:332
  # where the files were unzipd
  base_dir <- "/home/miguel/spec_data"
  
  #create a list to access the files regardless the current working dir
  full_dest <- paste(base_dir, directory, sep="/")
  
  # creates a list of files that matches the id 
  lf <- list.files(full_dest, full.names=TRUE)[id]
  
  # load data in a data_frame from the csv file
  data_frame <- data.frame()
  for (i in 1:length(id)) {
    data_frame <- rbind (data_frame, read.csv(lf[i]))
  }
  
  # uses complete cases to remove NAs
  ok <- complete.cases(data_frame)
  c_cases <- data_frame[ok,]
  
  # initialize ID, nobs
  ID <- numeric()
  nobs <- numeric()
  # use nrows to count data for each ID specified
  for (i in id) {
    # append id from i and nobs from nrows
    ID <- c(ID, i)
    nobs <- c(nobs, nrow (c_cases[c_cases$ID==i,]))
  }
  
  # taa daa !
  df <- data.frame(ID, nobs)
  
  # tids is a list of IDs where nobs > thresold
  tids <- df[df$nobs>thresold, "ID"]
  
  # calculate correlation for each ID in tids
  out <- numeric()
  for (i in tids) {
    out <- c(out, cor (c_cases[c_cases$ID==i, "sulfate"], c_cases[c_cases$ID==i, "nitrate"]))
  }
  out
}
