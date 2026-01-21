rm(list = ls())

library(tidyverse)
library(here)

path <- here("data", "SAFI_clean.csv")

interviews <- read_csv(path, na = "NULL")

names(interviews)

select(interviews, village, interview_date, no_membrs)
interviews[, c("village", "interview_date", "no_membrs")]

select(interviews, village:respondent_wall_type)

select(interviews, -c(1:3))

filter(interviews, village == "Chirodzo", 
       no_membrs > 4,
       years_liv > 30)




# pipe
interviews |>
  filter(village == "Chirodzo" & 
           no_membrs > 4 &
           years_liv > 30) |>
  select(village:respondent_wall_type)


interviews |>
  filter(village == "Chirodzo") |>
  select(village:respondent_wall_type) |>
  arrange(no_membrs)

interviews |>
  filter(village == "Chirodzo") |>
  select(village:respondent_wall_type) |>
  arrange(desc(no_membrs)) |>
  filter(respondent_wall_type == "burntbricks")

interviews |>
  filter(memb_assoc == "yes") |>
  select(affect_conflicts, liv_count, no_meals)



interviews |>
  filter(!is.na(memb_assoc)) |>
  group_by(village, memb_assoc) |>
  summarize(mean_no_membrs = mean(no_membrs),
            min_no_membrs = min(no_membrs)) |>
  arrange(desc(min_no_membrs))

##
interviews |>
  group_by(village) |>
  summarize(count = n()) |>
  arrange(desc(count))

interviews |>
  count(village, sort = T)

interviews_total_meals <- interviews %>%
  mutate(total_meals = no_membrs * no_meals) %>%
  filter(total_meals > 20) %>%
  select(village, total_meals)
interviews_total_meals
