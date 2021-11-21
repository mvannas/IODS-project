# Marko Vannas 
# 21.11.2021
# IODS Course Data Wrangling Exercise 2
library("dplyr")

# Read in Data from UCI Machine Learning Repository
# Downdloaded from https://archive.ics.uci.edu/ml/datasets/Student+Performance
d1=read.table("data/student-mat.csv",sep=";",header=TRUE)
d2=read.table("data/student-por.csv",sep=";",header=TRUE)

# Merge data using all other variables than
exclude <- c("failures","paid","absences", "G1", "G2", "G3")
join_by <- setdiff(colnames(d1), exclude)

j1 <- inner_join(d1,d2,by = join_by, suffix=c(".m",".p"))

# Mutate the combined table to calculate means for G1,G2,G3,absences and failures, for paid status select the one in math
j1 <- j1 %>% mutate( G1 = (G1.p + G1.m) / 2, 
              G2 = (G2.p + G2.m) / 2,
              G3 = (G3.p + G3.m) / 2,
              absences = (absences.p + absences.m) / 2,
              paid = paid.m,
              failures = (failures.p + failures.m) / 2)

# remove extra columns (.p and .m)
j1 <- select(j1, any_of(join_by), any_of(exclude))

# Mutate to create new alc_use and also alc_high variables
j1 <- j1 %>% mutate( alc_use = (Dalc + Walc) / 2)
j1 <- j1 %>% mutate( alc_high = alc_use > 2)

glimpse(j1)

write.csv(j1, "data/data_excrs2.csv", row.names = FALSE)
