#Order the Day of Week
daily_activity$day_of_week <- ordered(daily_activity$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

#Total Steps vs Calories graph
daily_activity %>% ggplot(aes(x = TotalSteps, y = Calories))+
  geom_jitter() + 
  geom_smooth() + 
  labs(title="Total Steps vs. Calories",
       x = "Total Steps", y = "Total Calories")

#Total Minutes Asleep vs Total Time in Bed graph
daily_activity_sleep %>% ggplot(aes(x = TotalMinutesAsleep, y = TotalTimeInBed))+
  geom_jitter(color ="darkgreen", alpha = 0.5, size = 2.25)+
  geom_smooth()+
  labs(title = "Total Minutes Asleep vs Total Time in Bed",
       x = "Total Minutes Asleep", y = "Total Time in bed")

#Average intensity per hour
add_data_1 <- hourly_activity %>%
  group_by(hour) %>%
  drop_na() %>% 
  summarise(avg_intensity = mean(TotalIntensity), 
            avg_calories = mean(Calories),
            avg_steps = mean(StepTotal))

#Average Total Intensity vs. Time
add_data_1 %>% ggplot(aes(x = hour, y = avg_intensity))+
  geom_histogram(stat = "identity", fill = "#66A61E", bins = 30)+
  labs(title="Average Intensity vs. Time",
       x = "Time (Hour 24H)", y = "Average Intensity")

#Average Calories vs. Time
add_data_1 %>% ggplot(aes(x = hour, y = avg_calories))+
  geom_histogram(stat = "identity", fill = "#66A61E")+
  labs(title="Average Calories vs. Time",
       x = "Time (Hour 24H)", y = "Average Calories")

#Average Steps vs. Time
add_data_1 %>% ggplot(aes(x = hour, y = avg_steps))+
  geom_histogram(stat = "identity", fill = "#66A61E")+
  labs(title="Average Steps vs. Time",
       x = "Time (Hour 24H)", y = "Average Steps")

#Average Calories vs. Time
add_data_1 %>% ggplot(aes(x = hour, y = avg_calories, fill = avg_intensity))+
  geom_col()+
  labs(x="Time (hour 24H)", y = "Average Calories", 
       title="Average Calories vs. Time segmented by Average Intensity", 
       fill = "Average Intensity")+
  scale_fill_gradient(low = "#FF5733", high = "#66A61E")

#Average Calories vs. Time
add_data_1 %>% ggplot(aes(x = hour, y = avg_steps, fill = avg_intensity))+
  geom_col()+
  labs(x="Time (hour 24H)", y = "Average Steps", 
       title="Average Steps vs. Time segmented by Average Intensity", 
       fill = "Average Intensity")+
  scale_fill_gradient(low = "#FF5733", high = "#66A61E")

#additional data frame from daily activity with sleep data
add_data_2 <- daily_activity_sleep %>%
  group_by(day_of_week, day, month) %>% 
  summarise(avg_steps = mean(TotalSteps),
            avg_distance = mean(TotalDistance),
            avg_vad = mean(VeryActiveDistance),
            avg_mad = mean(ModeratelyActiveDistance),
            avg_lad = mean(LightActiveDistance),
            avg_sad = mean(SedentaryActiveDistance),
            avg_vam = mean(VeryActiveMinutes),
            avg_fam = mean(FairlyActiveMinutes),
            avg_lam = mean(LightlyActiveMinutes),
            avg_sam = mean(SedentaryMinutes),
            avg_calories = mean(Calories),
            avg_sleep = mean(TotalMinutesAsleep),
            avg_bed = mean(TotalTimeInBed))

add_data_2_dis <- add_data_2 %>% 
  pivot_longer(cols = c(avg_vad, avg_mad, avg_lad, avg_sad),
               names_to = "Activity",
               values_to = "Average_Distance")

custom_colors <- c("avg_vad" = "blue", "avg_mad" = "darkgreen", "avg_lad" = "orange", "avg_sad" = "red")

add_data_2_dis %>% ggplot(aes(x = day_of_week, y = avg_distance, fill = Activity))+
  geom_col()+
  labs(x="Day", y = "Average Distance", 
       title="Average Steps vs. Time segmented by Distances", 
       fill = "Distances")+
  scale_fill_manual(
    breaks = names(custom_colors),
    values = custom_colors,
    labels = c("Very Active", "Moderately Active", "Lightly Active", "Sedentary Activity")
  )

add_data_2_min <- add_data_2 %>% 
  pivot_longer(cols = c(avg_vam, avg_fam, avg_lam, avg_sam),
               names_to = "Activity2",
               values_to = "Average_Distance")

custom_colors2 <- c("avg_vam" = "blue", "avg_fam" = "darkgreen", "avg_lam" = "orange", "avg_sam" = "red")

add_data_2_min %>% ggplot(aes(x = day_of_week, y = avg_distance, fill = Activity2))+
  geom_col()+
  labs(x="Day", y = "Average Distance", 
       title="Average Duration vs. Time segmented", 
       fill = "Duration")+
  scale_fill_manual(
    breaks = names(custom_colors2),
    values = custom_colors2,
    labels = c("Very Active", "Moderately Active", "Lightly Active", "Sedentary Active")
  )

# additional data frame from weight_log
add_data_4 <- weight_log %>% 
  group_by(DateandTime, IsManualReport) %>% 
  summarise(avg_weight = mean(WeightKg))

#Line Graph to represent Users Manually reported vs Machine reported weight
add_data_4 %>% ggplot(aes(x = DateandTime, y = avg_weight, color = IsManualReport))+
  geom_line()+
  geom_point()+
  labs(
    title = "Manually Vs Machine Reported Weight by Users",
    x = "Time", y = "Average Weight",
    color = "Weight Reported"
  )+
  scale_color_manual(
    values = c("False" = "red", "True" = "darkgreen"),
    labels = c("Manual Weight", "Machine Weight")
  )


add_data_5 <- daily_activity %>% 
  group_by(day_of_week) %>% 
  summarise(average_steps = mean(TotalSteps),
            average_distance = mean(TotalDistance),
            average_calories = mean(Calories),
            average_steps = mean(TotalSteps))
#Graph 1
add_data_5 %>% ggplot(aes(x = day_of_week, y = average_steps)) + geom_col(position = "dodge", fill = "#66A61E")

#Graph 2
add_data_5 %>% ggplot(aes(x = day_of_week, y = average_distance)) + geom_col(position = "dodge", fill = "#66A61E")

#Graph 3
add_data_5 %>% ggplot(aes(x = day_of_week, y = average_calories)) + geom_col(position = "dodge", fill = "#66A61E")


#additional data frame 6 from minute activity data with heartrate data
add_data_6 <- minute_activity_hr %>% 
  group_by(minute, ActivityMinute) %>% 
  summarise(avg_steps = mean(Steps),
            avg_calories = mean(Calories),
            avg_hr = mean(Value),
            max_hr = max(avg_hr), 
            min_hr = min(avg_hr),
            avg_met = mean(METs))

#Graph 1
add_data_6 %>% ggplot(aes(x = avg_calories, y = avg_hr))+
  geom_point(alpha = 0.5, color = "#66A61E")+
  geom_smooth()+
  labs(title = "Average Heartrate per Average Calorie Burned",
       x = "Average Calories", y = "Average Heartrate")

#Graph 2
add_data_6 %>% ggplot(aes(x = avg_steps, y = avg_hr))+
  geom_point(alpha = 0.5, color = "#66A61E")+
  geom_smooth()+
  labs(title = "Average Heartrate Vs Average Steps",
       x = "Average Steps", y = "Average Heartrate")

#Graph 3
add_data_6 %>% ggplot(aes(x = avg_met, y = avg_hr))+
  geom_point(alpha = 0.5, color = "#66A61E")+
  geom_smooth()+
  labs(title = "Average Heartrate Vs Average Metabolic Equivalent(MET)",
       x = "Average Metabolic Equivalent(MET)", y = "Average Heartrate")

#Graph 4
add_data_6 %>% ggplot(aes(x = minute, y = avg_hr))+
  geom_line()+
  geom_point(color = "#66A61E", alpha = 0.5)+
  labs(title = "Average Heartrate range per minute",
       x = "Time (Minute)", y = "Average Heartrate")+
  theme_minimal()

#Graph 5
add_data_6 %>% ggplot(aes(x = minute, y = avg_steps))+
  geom_line()+
  geom_point(color = "#66A61E", alpha = 0.5)+
  labs(title = "Average Heartrate range per minute",
       x = "Time (Minute)", y = "Average Heartrate")+
  theme_minimal() 

#Graph 6
add_data_6 %>% ggplot(aes(x = minute, y = avg_calories))+
  geom_line()+
  geom_point(color = "#66A61E", alpha = 0.5)+
  labs(title = "Average Heartrate range per minute",
       x = "Time (Minute)", y = "Average Heartrate")

#Graph 7
add_data_6 %>% ggplot(aes(x = minute, y = avg_met))+
  geom_line()+
  geom_point(color = "#66A61E", alpha = 0.5)+
  labs(title = "Average Heartrate range per minute",
       x = "Time (Minute)", y = "Average Heartrate")

#Graph 8
add_data_6 %>% ggplot(aes(x = avg_calories, y = avg_met))+
  geom_hex(bins = 20, color = "white") +
  geom_smooth()+
  labs(title = "Average Calories Vs Average METs",
       x = "Average Calories", y = "Average METs",
       fill = "Metabolic Equivalent (MET) count")+
  scale_fill_gradient(
    low = "red", high = "darkgreen"
  )+
  theme_minimal()

#Graph 9
add_data_6 %>% ggplot(aes(x = avg_steps, y = avg_met))+
  geom_hex(bins = 20, color = "white") +
  geom_smooth()+
  labs(title = "Average Steps Vs. Average METs",
       x = "Average Steps", y = "Average METs",
       fill = "Metabolic Equivalent (MET) count")+
  scale_fill_gradient(
    low = "red", high = "darkgreen"
  )+
  theme_minimal()

#Graph 10
add_data_6 %>% ggplot(aes(x = avg_hr, y = avg_met))+
  geom_hex(bins = 20, color = "white") +
  geom_smooth()+
  labs(title = "Average heartrate Vs. Average METs",
       x = "Average heartrate", y = "Average METs",
       fill = "Metabolic Equivalent (MET) count")+
  scale_fill_gradient(
    low = "red", high = "darkgreen"
  )+
  theme_minimal()

