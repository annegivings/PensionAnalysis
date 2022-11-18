install.packages("cpsR")
install.packages("tidycensus")
library(cpsR)
library(tidycensus)
library(dplyr)

# Source book: https://cps.ipums.org/cps/resources/codebooks/cpsmar22.pdf


# Keep only folks over 67
clean <- subset(clean, a_age>=67)

table(clean$pen_yn)
clean %>%
  group_by(pen_yn) %>%
  summarize_at(vars(a_fnlwgt), list(total=sum))
# Is this an accurate way to use weights?
194/(360+194) # 35.0%
616345/(1118051+616345) # 35.5%
# If so, weighting seems to show slightly higher incidence of 
# pensions for ages 67+ in Michigan.

clean %>%
  group_by(prdtrace, pen_yn) %>%
  summarize_at(vars(a_fnlwgt), list(total=sum))

#white  
550411/(550411+996348) # 35.6% have pension
#black
60521/(60521+92502) # 39.6% have pension

clean %>%
  group_by(pehspnon, pen_yn) %>%
  summarize_at(vars(a_fnlwgt), list(total=sum))
#hispanic, spanish, latino
4323/(4323+23933) # 15.3% have pension


# How much pension income?
clean <- subset(clean, pen_yn==1)
clean <- clean %>%
  mutate(pen_wgt = pnsn_val*a_fnlwgt)
clean %>%
  group_by(prdtrace) %>%
  summarize_at(vars(pen_wgt), list(total=sum))
clean %>%
  group_by(prdtrace) %>%
  summarize_at(vars(a_fnlwgt), list(total=sum))

#White
10606021116/550411 # $19,269
#Black
1285937176/60521 # $21,247

clean %>%
  group_by(pehspnon) %>%
  summarize_at(vars(pen_wgt), list(total=sum))
clean %>%
  group_by(pehspnon) %>%
  summarize_at(vars(a_fnlwgt), list(total=sum))
#hispanic/spanish/latino
176374320/4323 # $40,799
#It doesn't seem like the estimates for pension income are accurate





