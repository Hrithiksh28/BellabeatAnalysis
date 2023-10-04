#Clean daily_activity
daily_activity %>% 
  drop_na() %>% 
  select(-ActivityDate) %>% 
  select(-TotalSteps) %>% 
  select(-TrackerDistance)

daily_activity <- unique(daily_activity)

#Extract day, month and year from ActivityDate (daily_activity)
daily_activity$ActivityDate <- as.Date(daily_activity$ActivityDate, format = "%m/%d/%Y")
daily_activity$day <- format(as.Date(daily_activity$ActivityDate), "%d")
daily_activity$month <- format(as.Date(daily_activity$ActivityDate), "%m")
daily_activity$day_of_week <- format(as.Date(daily_activity$ActivityDate), "%A")

str(daily_activity)
clean_names(daily_activity)

#Merge hourly data as hourly_activity
hourly_activity <- merge(hourly_calories, hourly_intensities)
hourly_activity <- merge(hourly_activity, hourly_steps)

#clean hourly_activity
hourly_activity %>% 
  drop_na() %>% 
  select(-ActivityHour) %>% 
  select(-StepTotal)

hourly_activity <- unique(hourly_activity)

#Extract day, month, year, hour, mintues, seconds from ActivityHour (hourly_activity)
hourly_activity$ActivityHour <- format(strptime(hourly_activity$ActivityHour, "%m/%d/%Y %I:%M:%S %p"), "%d/%m/%Y %H:%M:%S")
hourly_activity$ActivityHour <- as.POSIXct(hourly_activity$ActivityHour, format = "%d/%m/%Y %H:%M:%S")
hourly_activity$day <- format(as.POSIXct(hourly_activity$ActivityHour), "%d")
hourly_activity$month <- format(as.POSIXct(hourly_activity$ActivityHour), "%m")
hourly_activity$hour <- format(as.POSIXct(hourly_activity$ActivityHour), "%H")
hourly_activity$day_of_week <- format(as.POSIXct(hourly_activity$ActivityHour), "%A")

str(hourly_activity)

#Merge Minute data as minute_activity
merge_1 <- merge(minute_calories, minute_intensities)
merge_2 <- merge(minute_MET, minute_steps)
minute_activity <- merge(merge_1, merge_2)

#clean minute_activity
minute_activity %>% 
  drop_na() %>% 
  select(-ActivityMinute) %>% 
  select(-Steps)

minute_activity <- unique(minute_activity)

#Extract day, month, year, hour, mintues, seconds from ActivityMinute (minute_activity)
minute_activity$ActivityMinute <- format(strptime(minute_activity$ActivityMinute, "%m/%d/%Y %I:%M:%S %p"), "%d/%m/%Y %H:%M:%S")
minute_activity$ActivityMinute <- as.POSIXct(minute_activity$ActivityMinute, format = "%d/%m/%Y %H:%M:%S")
minute_activity$day <- format(as.POSIXct(minute_activity$ActivityMinute), "%d")
minute_activity$month <- format(as.POSIXct(minute_activity$ActivityMinute), "%m")
minute_activity$hour <- format(as.POSIXct(minute_activity$ActivityMinute), "%H")
minute_activity$minute <- format(as.POSIXct(minute_activity$ActivityMinute), "%M")
minute_activity$ampm <- format(as.POSIXct(minute_activity$ActivityMinute), "%p")
minute_activity$day_of_week <- format(as.POSIXct(minute_activity$ActivityMinute), "%A")

str(minute_activity)

#Preparing and Cleaning Sleep Data
sleep_data <- daily_sleep %>%
  select(-TotalSleepRecords) %>%
  rename(ActivityDate = SleepDay) %>%
  distinct(Id, ActivityDate, TotalMinutesAsleep, TotalTimeInBed, .keep_all = TRUE)

length(unique(sleep_data$ActivityDate))
glimpse(sleep_data)

sleep_data$ActivityDate <- as.Date(sleep_data$ActivityDate, format = "%m/%d/%Y")

daily_activity_sleep <- merge(daily_activity, sleep_data, by = c("Id", "ActivityDate"))

#Preparing and Cleaning Weight Data and merging with daily activity data
weight_data <- weight_log %>% 
  select(-WeightPounds) %>% 
  rename(ActivityDate = Date) %>% 
  distinct(Id, ActivityDate, IsManualReport, day_of_week, .keep_all = TRUE)

daily_activity_weight <- merge(daily_activity, weight_data, by = c("Id", "ActivityDate"))

heartrate_data <- flt_heartrate %>% 
  rename(ActivityMinute = Time) %>% 
  distinct(Id, ActivityMinute, Value, minute, day, month, .keep_all = TRUE)

minute_activity_hr <- merge(minute_activity, heartrate_data, by = c("Id", "ActivityMinute", "day", "month", "minute"))

#Extract seconds from Time (seconds_heartrate)
heartrate$DateandTime <- format(strptime(heartrate$Time, "%m/%d/%Y %I:%M:%S %p"), "%d/%m/%Y %H:%M:%S")
heartrate$DateandTime <- as.POSIXct(heartrate$DateandTime, format = "%d/%m/%Y %H:%M:%S")
heartrate$second <- format(as.POSIXct(heartrate$DateandTime), "%S")
heartrate$day <- format(as.POSIXct(heartrate$DateandTime), "%d")
heartrate$month <- format(as.POSIXct(heartrate$DateandTime), "%m")
heartrate$hour <- format(as.POSIXct(heartrate$DateandTime), "%H")
heartrate$minute <- format(as.POSIXct(heartrate$DateandTime), "%M")
str(heartrate) 
flt_heartrate <- heartrate[grep("00", heartrate$second), ]

#Extract date from time (weight_log)
weight_log$DateandTime <- format(strptime(weight_log$Date, "%m/%d/%Y %I:%M:%S %p"), "%d/%m/%Y %H:%M:%S")
weight_log$DateandTime <- as.POSIXct(weight_log$DateandTime, format = "%d/%m/%Y %H:%M:%S")
weight_log$Date <- as.POSIXct(weight_log$Date, format = "%m/%d/%Y")
weight_log$day <- format(as.POSIXlt(weight_log$DateandTime), "%d")
weight_log$month <- format(as.POSIXlt(weight_log$DateandTime), "%m")
weight_log$hour <- format(as.POSIXlt(weight_log$DateandTime), "%H")
weight_log$minute <- format(as.POSIXlt(weight_log$DateandTime), "%M")
weight_log$day_of_week <- format(as.POSIXlt(weight_log$DateandTime), "%A")
