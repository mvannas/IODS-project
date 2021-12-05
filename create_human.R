# Author: Marko Vannas
# This is data wrangling excercise 5 
# This uses dataset from United Nations Development Programme. 

library("vtable")
library("tidyverse")

# Read dataset
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore data
str(hd)
dim(hd)
st(hd)
str(gii)
dim(gii)
st(gii)

# Rename variables
hd <- rename(hd, 
       hdirank = HDI.Rank,
       country = Country,
       hdi = Human.Development.Index..HDI.,
       lifebirth = Life.Expectancy.at.Birth,
       eduyrs = Expected.Years.of.Education,
       edumean = Mean.Years.of.Education,
       gnicap = Gross.National.Income..GNI..per.Capita,
       gnicapnorank = GNI.per.Capita.Rank.Minus.HDI.Rank
       )

gii <- rename(gii,
       giirank = GII.Rank,
       country = Country,
       gii = Gender.Inequality.Index..GII.,
       mmr = Maternal.Mortality.Ratio,
       abirth = Adolescent.Birth.Rate,
       prp = Percent.Representation.in.Parliament,
       popseceduF = Population.with.Secondary.Education..Female.,
       popseceduM = Population.with.Secondary.Education..Male.,
       labrateF = Labour.Force.Participation.Rate..Female.,
       labrateM = Labour.Force.Participation.Rate..Male.
       )

gii <- gii %>% mutate(popseceduP = popseceduF / popseceduM)
gii <- gii %>% mutate(labrateP = labrateF / labrateM)

all <- inner_join(gii, hd, by = c("country"))

# Convert GNI from text to numeric value 
all$gnicap <- str_replace(all$gnicap, ",", "") %>% as.numeric

# Select only spesific rows
keep <- c("country","popseceduP","labrateP","lifebirth","mmr","abirth","prp","gnicap")
all <- select(all, one_of(keep))

# Remove rows with NA values
data.frame(all[-1], comp = complete.cases(all))
all <- filter(all, complete.cases(all))

# The last 7 are not countries, instead they are area, remove them
all <- all[1:(nrow(all) - 7), ]

# Name rows based on country
rownames(all) <- all$country

# Remove country as columns
all <- select(all, -country)

write.csv(all, "data/human.cvs")


