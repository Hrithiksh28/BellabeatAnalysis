#Install and Load Packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("janitor")
install.packages("ggplot2")
install.packages("lubridate")

library(tidyverse)
library(dplyr)
library(janitor)
library(ggplot2)
library(lubridate)

#
daily_activity <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/dailyActivity_merged.csv")
View(head(daily_activity))
str(daily_activity)

daily_calories <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/dailyCalories_merged.csv")
View(head(daily_calories))
str(daily_calories)

daily_intensities <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/dailyIntensities_merged.csv")
View(head(daily_intensities))
str(daily_intensities)

daily_steps <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/dailySteps_merged.csv")
View(head(daily_steps))
str(daily_steps)

heartrate <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/heartrate_seconds_merged.csv")
View(head(heartrate))
str(heartrate)

hourly_calories <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/hourlyCalories_merged.csv")
View(head(hourly_calories))
str(hourly_calories)

hourly_intensities <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/hourlyIntensities_merged.csv")
View(head(hourly_intensities))
str(hourly_intensities)

hourly_steps <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/hourlySteps_merged.csv")
View(head(hourly_steps))
str(hourly_steps)

minute_steps <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/minuteStepsNarrow_merged.csv")
View(head(minute_steps))
str(minute_steps)

minute_calories <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/minuteCaloriesNarrow_merged.csv")
View(head(minute_calories))
str(minute_calories)

minute_intensities <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/minuteIntensitiesNarrow_merged.csv")
View(head(minute_intensities))
str(minute_intensities)

minute_MET <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/minuteMETsNarrow_merged.csv")
View(head(minute_MET))
str(minute_MET)

daily_sleep <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/sleepDay_merged.csv")
View(head(daily_sleep))
str(daily_sleep)

weight_log <- read.csv("D:/Data_Analysis/BellabeatAnalysis/Data/weightLogInfo_merged.csv")
View(head(weight_log))
str(weight_log)