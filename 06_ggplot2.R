rm(list = ls())

library(tidyverse)

interviews_plotting <- read_csv("data_output/interviews_plotting.csv")
View(interviews_plotting)

plot(x = interviews_plotting$no_membrs, y = interviews_plotting$years_liv,
     main = "Members vs Years Live",
     xlab = "Members",
     ylab = "Years Live")

library(lattice)
xyplot(liv_count ~ no_membrs | village, data = interviews_plotting,
       main = "Members vs Years Live",
       xlab = "Members",
       ylab = "Livestock Count")

interviews_plotting |>
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

interviews_plotting |>
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(color = village),
              alpha = 0.8,
              width = 0.2,
              size = 5,
              height = 0.2)

interviews_plotting |>
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_count()


## CHALLENGE

rm(list = ls())

library(tidyverse)

interviews_plotting <- read_csv("data_output/interviews_plotting.csv")
View(interviews_plotting)

interviews_plotting |>
  ggplot(aes(x=village, y=rooms)) +
  geom_jitter(aes(color=respondent_wall_type),
              alpha=0.8,
              width=0.2,
              size=5,
              height=0.2)

interviews_plotting |>
  ggplot(aes(x=respondent_wall_type, y=rooms)) +
  geom_boxplot() +
  geom_jitter(alpha=0.5,
              width=0.2,
              color = "tomato",
              size=2,
              height=0.2)

interviews_plotting |>
  ggplot(aes(x=respondent_wall_type, y=rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(aes(color=respondent_wall_type),
              alpha = 0.8, 
              width = 0.2,
              size = 3,
              height = 0.2)

interviews_plotting |>
  ggplot(aes(x=respondent_wall_type)) +
  geom_bar(aes(fill = village), position = "dodge")



