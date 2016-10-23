# Exercices for week 2
### initial release 
For this initial release I followed a reference material provided by the instrutors, and I build my code using functions that where not teached yet, although it is in a advanced link in that reading. They are lapply and do.call functions.

### memory optmized
In this release I follow the suggestiion one of instructors posted on the week 2 forum, mainly using list.files[id] to only use files that maatch the id provided as argument.
This only works because the file name matches the id number, and there is no "holes" in the stations numbers. So the file "001.csv" comes to the lf[1] and the file "100.csv" comes to lf[100]. If a file in this sequence is absent, or a station has a different name, this schieme will not work.

Also, this method loads on memory, only data which ID matches with the id argument.
