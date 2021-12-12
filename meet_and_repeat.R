# Author: Marko Vannas
# Data wranglind for excercise 5
library(dplyr)
library(tidyr)
library(vtable)

# Load datasets
BPRS <- read.delim("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep  = " ")
RATS <- read.delim("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

# Both datasets seem to have a object identifier (subject/ID) and some grouping (treatment/Group)
st(BPRS)
st(RATS)

# Convert categories to factors
factor(BPRS$treatment)
factor(BPRS$subject)
factor(RATS$ID)
factor(RATS$Group)

# split rows into separate cases based on observation date (aka. Longer)
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <- RATS %>% gather(key = WD, value = rats, -ID, -Group)

# Get time values from columns 
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,6)))
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

# Glimpse the data
glimpse(RATSL)
st(RATSL)

# Store the wrangled dataset
write.csv(RATSL, "data/ratsl.csv")
write.csv(BPRSL, "data/bprsl.csv")
