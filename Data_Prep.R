setwd("~/Desktop/Georgetown/542 Machine Learning/project")
options(stringsAsFactors = FALSE)
library(dplyr)
library(readr)
library(data.table)
library(stringr)


files = list.files(pattern="*.txt")

#Origniation data
orig <- do.call(rbind, lapply(files, function(x) read.csv(x, sep='|', skipNul = T, na.strings='', header=F, quote = '')))
dim(orig)
names(orig) <- names(read.csv('orig_header_file.csv'))
head(orig)

#Export data
write.table(orig, "~/Desktop/Georgetown/542 Machine Learning/project/orig.txt", sep="\t")


#Monthly performance data
perform <- do.call(rbind, lapply(files, function(x) read.csv(x, sep='|', skipNul = T, na.strings='', header=F, quote = '')))
dim(perform)
names(perform) <- names(read.csv('perform_header_file.csv'))
head(perform)

#Export data
write.table(perform, "~/Desktop/Georgetown/542 Machine Learning/project/perform.txt", sep="\t")

table(perform$CURRENT_LOAN_DELINQUENCY_STATUS)
head(perform)



length(unique(perform[["CURRENT_LOAN_DELINQUENCY_STATUS"]]))
dim(perform)

perform %>%
  filter(!str_detect(CURRENT_LOAN_DELINQUENCY_STATUS, "XX"))->perform1

perform %>%
  filter(str_detect(CURRENT_LOAN_DELINQUENCY_STATUS, "R"))->performR

perform0 %>%
  filter(CURRENT_LOAN_DELINQUENCY_STATUS=="0")->perform0

table(perform0$CURRENT_LOAN_DELINQUENCY_STATUS)

perform0sample<-sample_n(perform0, 25141)

dim(perform0sample)

combined <- rbind(perform0sample, performR)

head(combined)

combined %>%
  select(LOAN_SEQUENCE_NUMBER, CURRENT_LOAN_DELINQUENCY_STATUS, LOAN_AGE, REPURCHASE_FLAG,  MODIFICATION_FLAG, CURRENT_INTEREST_RATE, MI_RECOVERIES, DEFERRED_PAYMENT_MODIFICATION )->combined
head(combined)

head(orig)
orig %>%
  select(CREDIT_SCORE,FIRST_PAYMENT_DATE,FIRST_TIME_HOMEBUYER_FLAG,MORTGAGE_INSURANCE_PERCENTAGE, NUMBER_OF_UNITS,OCCUPANCY_STATUS,ORIGINAL_CLTV,ORIGINAL_DTI_RATIO, ORIGINAL_LTV, ORIGINAL_INTEREST_RATE, PRODUCT_TYPE, LOAN_SEQUENCE_NUMBER, SUPER_CONFORMING_FLAG, PROPERTY_STATE) ->origcleaned

head(origcleaned)

combined %>%
  inner_join(origcleaned, by= "LOAN_SEQUENCE_NUMBER")->df
head(df)
dim(df)

df %>%
  select(LOAN_SEQUENCE_NUMBER, CURRENT_LOAN_DELINQUENCY_STATUS, CURRENT_INTEREST_RATE, CREDIT_SCORE, FIRST_PAYMENT_DATE, FIRST_TIME_HOMEBUYER_FLAG, MORTGAGE_INSURANCE_PERCENTAGE,NUMBER_OF_UNITS, OCCUPANCY_STATUS, ORIGINAL_DTI_RATIO, SUPER_CONFORMING_FLAG, PROPERTY_STATE) -> df

head(df)

df %>%
  rename( loan_num = LOAN_SEQUENCE_NUMBER,
          inter_rt = CURRENT_INTEREST_RATE,
          credit_sc = CREDIT_SCORE,
          firts_pay = FIRST_PAYMENT_DATE,
          first_home_buy = FIRST_TIME_HOMEBUYER_FLAG,
          insur_perc = MORTGAGE_INSURANCE_PERCENTAGE,
          num_units = NUMBER_OF_UNITS,
          ocup_status = OCCUPANCY_STATUS,
          dtiratio=ORIGINAL_DTI_RATIO,
          conforming=SUPER_CONFORMING_FLAG,
          state=PROPERTY_STATE) -> df

head(df)

table(df$CURRENT_LOAN_DELINQUENCY_STATUS)
df$CURRENT_LOAN_DELINQUENCY_STATUS <- ifelse(df$CURRENT_LOAN_DELINQUENCY_STATUS =="R",1,0)

summary(df)

df %>%
  rename( default = CURRENT_LOAN_DELINQUENCY_STATUS) ->df

table(origcleaned$FIRST_TIME_HOMEBUYER_FLAG)
df$conforming <- ifelse(df$conforming =="Y",1,0)
df$conforming <- ifelse(is.na(df$conforming),0,df$conforming)
head(df)
#9 not applicable
sum(is.na(df$state))

library(lubridate)


df %>%
  mutate(first_pay=as.Date(paste0(as.character(firts_pay), '01'), format='%Y%m%d') ) %>%
  select(-firts_pay)->df2

head(df2)
#Export data
write.table(df2, "~/Desktop/Georgetown/542 Machine Learning/project/df2.txt", sep="\t")

