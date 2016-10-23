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
  lf <- list.files(full_dest, full.names=TRUE)   
  
  # read all files at once 
  data_frame <- lapply(lf, read.csv)
  
  # convert the dataframe to a more usefull format
  # use the id to limit which ID will be present on s
  s <- do.call(rbind, data_frame[id])
  
  # using complete.cases() to remove NAs
  ok <- complete.cases(s)
  c_cases <- s[ok,]
  
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
