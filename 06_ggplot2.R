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
  geom_bar(aes(fill = village), position = "dodge") +
  labs(title = "Respondent Wall Type by Village",
       x = "Respondent Wall Type",
       y = "Count of obs.") +
  facet_wrap(~ village)

percent_wall_type <- interviews_plotting %>%
  filter(respondent_wall_type != "cement") %>%
  count(village, respondent_wall_type) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

# facet
percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title="Proportion of wall type by village",
       x="Wall Type",
       y="Percent") +
  facet_wrap(~ village) +
  theme_bw()

percent_items <- interviews_plotting %>%
  group_by(village) %>%
  summarize(across(bicycle:no_listed_items, ~ sum(.x) / n() * 100)) %>%
  pivot_longer(bicycle:no_listed_items, names_to = "items", values_to = "percent")
percent_items

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_dark()

library(ggthemes)

my_plot <- percent_items %>%
  ggplot(aes(x = village, y = percent, fill = village)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_excel_new() +
  scale_fill_excel_new()

my_plot

ggsave("fig_output/ggplot-demo.png", my_plot)
