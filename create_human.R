library("vtable")

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

write.csv(all, "data/human.cvs")
