pollutantmean <- function (directory, pollutant, id= 1:332) {
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
  
  # calculate the mean, ignoring the NA
  mean (unlist (s[pollutant], use.names=FALSE), na.rm=TRUE)
}