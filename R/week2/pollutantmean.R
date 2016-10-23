pollutantmean <- function (directory, pollutant, id= 1:332) {
  ## where the files were unzipd
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
  
  # calculate the mean, ignoring the NA
  mean (unlist (data_frame[pollutant], use.names=FALSE), na.rm=TRUE)
}