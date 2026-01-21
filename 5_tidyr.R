library(gapminder)

data <- gapminder

wide_data <- data |>
  select(country, lifeExp, year) |>
  spread(year, lifeExp)

rm(list = ls())

library(tidyverse)
library(here)

path <- here("data", "SAFI_clean.csv")

interviews <- read_csv(path, na = "NULL")

interviews_items_owned <- interviews %>%
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) |>
  mutate(items_owned_logical = T)
View(interviews_items_owned)

interviews_items_owned <- interviews %>%
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  group_by(key_ID) %>%
  mutate(items_owned_logical = TRUE,
         number_items = if_else(items_owned == "no_listed_items", 0, n())) %>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical = FALSE))

View(interviews_items_owned)

interviews_items_owned |>
  filter(bicycle == T) |>
  group_by(village) |>
  count(bicycle)

interviews_items_owned |>
  filter(motorcyle == T) |>
  group_by(village) |>
  count(motorcyle)


interviews_plotting <- interviews %>%
  ## pivot wider by items_owned
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  ## Use of grouped mutate to find number of rows
  group_by(key_ID) %>% 
  mutate(items_owned_logical = TRUE,
         number_items = if_else(items_owned == "no_listed_items", 0, n())) %>% 
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical = FALSE)) %>% 
  ## pivot wider by months_lack_food
  separate_longer_delim(months_lack_food, delim = ";") %>%
  mutate(months_lack_food_logical = TRUE,
         number_months_lack_food = if_else(months_lack_food == "none", 0, n())) %>%
  pivot_wider(names_from = months_lack_food,
              values_from = months_lack_food_logical,
              values_fill = list(months_lack_food_logical = FALSE))

interviews_plotting |> View()

write_csv(interviews_plotting, file = "data_output/interviews_plotting.csv")


