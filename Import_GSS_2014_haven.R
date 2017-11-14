#require(foreign)
require(haven)
gss <- read_spss(file="GSS2014merged_R7.sav")


require(tigerstats)
require(plyr)
require(dplyr)

#use dplyr after making gss a tbl
gss <- tbl_df(gss)

#Use select to get the variables of interest

n2014<- select(gss,cappun,owngun,bible,polviews,partyid,region,god,race,owngun,educ,sex,degree)

#now convert from class "labelled to factor"
n2014$cappun <- as_factor(n2014$cappun)
n2014$owngun <- as_factor(n2014$owngun)
n2014$bible <- as_factor(n2014$bible)
n2014$polviews <- as_factor(n2014$polviews)
n2014$partyid <- as_factor(n2014$partyid)
n2014$region <- as_factor(n2014$region)
n2014$god <- as_factor(n2014$god)
n2014$race <- as_factor(n2014$race)
n2014$owngun <- as_factor(n2014$owngun)
n2014$educ <- as_factor(n2014$educ)
n2014$sex <- as_factor(n2014$sex)
n2014$degree <- as_factor(n2014$degree)
#here we use mutate to create 3 education levels


n2014 <- mutate(n2014,edlevel=ifelse(educ %in% (0:10),"JRHIGH",ifelse(educ %in% (11:14),"JrCOL",ifelse(educ %in% (15:20),"COLege",NA))))

#now we deploy the revalue command from the plyr package to collapse the number of
#levels in these categorical variables

n2014$partyid <- revalue(n2014$partyid,c(
  "STRONG DEMOCRAT" = "dem",
  "NOT STR DEMOCRAT" = "dem",
  "IND,NEAR DEM"="Indep",
  "IND,NEAR REP"="Indep",
  "INDEPENDENT"="Indep",
  "NOT STR REPUBLICAN"="rep",
  "STRONG REPUBLICAN"="rep",
  "OTHER PARTY"="NA",
    "DK"="NA"
))

n2014$god <- revalue(n2014$god,c(
  "DONT BELIEVE" = "no",
  "NO WAY TO FIND OUT" = "no",
  "SOME HIGHER POWER" = "maybe",
  "BELIEVE SOMETIMES" = "maybe",
  "BELIEVE BUT DOUBTS" = "maybe",
  "DK" = "maybe",
  "KNOW GOD EXISTS"="yes",
  "IAP"="NA"
))

n2014$owngun <- revalue(n2014$owngun,c(
  "YES" = "YES",
  "NO" = "NO",
  "IAP" = "NA",
  "REFUSED" = "NA",
  "DK" = "NA"
))

n2014$polviews <- revalue(n2014$polviews,c(
  "IAP" = "NA",
  "DK" = "NA",
  "EXTREMELY LIBERAL"="LIBERAL",
  "SLIGHTLY LIBERAL"="LIBERAL",
  "SLGHTLY CONSERVATIVE"="CONSERVATIVE",
  "EXTRMLY CONSERVATIVE"="CONSERVATIVE"
 ))

n2014$cappun <- revalue(n2014$cappun,c(
  "IAP" = "NA",
  "DK" = "NA"))



n2014$bible <- revalue(n2014$bible,c(
  "IAP" = "NA",
  "OTHER" = "NA",
  "DK" = "NA",
  "INSPIRED WORD" = "WORD OF GOD"
))

n2014$race <- revalue(n2014$race,c(
  "IAP" = "NA"))


n2014$degree <- revalue(n2014$degree,c("IAP"="NA",
 "DK" = "NA"))


