# Marko Vannas, 9.11.2021
# This is the Week 2 exercise R script for data wrangling 
library(dplyr)

# Read data directly from URL to environment variable data
data <- read.delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt")

# Structure and dimensions
str(data)
dim(data)

# Data has 183 observations and 60 variables, mostly integer vectors
# Gender is characted vector, with F and M values 

# Create new dataset from existing data
# Select gender, Age, Attitude and Points
work_data = select(data, c("gender", "Age", "Attitude", "Points"))

# convert to lowercase all column names
colnames(work_data) <- tolower(colnames(work_data))

# Creating variables deep, surf and stra 
# instructions from 
# https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS2-meta.txt

deep_var_names <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_col <- select(data, one_of(deep_var_names))
work_data$deep <- rowMeans(deep_col)

stra_var_names <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
stra_col <- select(data, one_of(stra_var_names))
work_data$stra <- rowMeans(stra_col)

surf_var_names <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surf_col <- select(data, one_of(surf_var_names))
work_data$surf <- rowMeans(surf_col)

# Remove all observations where points is 0 
work_data <- filter(work_data, points != 0)

write.csv(work_data, "data/work_data.csv", row.names = FALSE)

test_data <- read.csv("data/work_data.csv")

head(test_data)
str(test_data)
