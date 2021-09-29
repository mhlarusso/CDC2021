#read in the data
setwd("~/Downloads")
SVI_2014 <- read.csv("xn--CDCs_Social_Vulnerability_Index_(SVI)__2014_overall_SVI,_census_tract_level_-_Wake_County-7470duo.csv")

#load libraries
library(dplyr)

#roll up census tracts into county level data for Minority Status/Language (Theme 3) variable
roll_up = SVI_2014 %>% 
  filter(RPL_THEME3 > 0) %>%
  group_by(STATE, COUNTY) %>% 
  summarise(COUNTY_E_MINRTY  = sum(E_MUNIT),
            COUNTY_E_LIMENG = sum(E_LIMENG),
            COUNTY_EP_MINRTY = sum(EP_MINRTY),
            COUNTY_EP_LIMENG  = sum(EP_LIMENG),
            COUNTY_EPL_MINRTY= sum(EPL_MINRTY),
            COUNTY_EPL_LIMENG = sum(EPL_LIMENG),
            COUNTY_SPL_THEME3 =  sum(SPL_THEME3)/n())

roll_up = roll_up %>% mutate(COUNTY_RPL_THEME3 = percent_rank(COUNTY_SPL_THEME3))


            
