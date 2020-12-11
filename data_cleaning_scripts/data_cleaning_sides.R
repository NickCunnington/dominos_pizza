library(readxl)
library(janitor)
library(tidyverse)



# read in sides data
sides <- read_xlsx("raw_data/SidesDessertsNutritionals.xlsx", skip = 4, col_names = FALSE)


# move first row to column names, use clean_names function, drop spaces in between 
# tables, remove repeated column names in all tables so only appears at top.
sides_clean <- sides %>% 
  row_to_names(row_number = 1) %>%
  clean_names() %>%
  drop_na()


# add 'type' column in
sides_clean <- add_column(sides_clean, type = NA, .after = 1)


# populate 'type' column with data to describe dish type.
sides_clean$type <- c((rep("side", 32)), (rep("dip", 10)), (rep("wrapzz", 6)), 
                      (rep("dessert", 4)))


# changing the first column name from 'NA' to 'dish'
colnames(sides_clean)[1] <- "dish"


# renaming columns to differentiate between per 100g and per serving
sides_clean <- sides_clean %>%
  rename(energy_kcal_100g = energy_kcal, energy_kj_100g = energy_k_j, 
         fat_g_100g = fat_g, sat_g_100g = sat_g, carb_g_100g = carb_g,
         sugars_g_100g = sugars_g, fibre_g_100g = fibre_g, protein_g_100g = 
           protein_g, salt_g_100g = salt_g, sodium_g_100g = sodium_g,
         energy_kcal_serv = energy_kcal_2, energy_kj_serv = energy_k_j_2,
         fat_g_serv = fat_g_2, sat_g_serv = sat_g_2, carb_g_serv = carb_g_2,
         sugars_g_serv = sugars_g_2, fibre_g_serv = fibre_g_2, protein_g_serv =
           protein_g_2, salt_g_serv = salt_g_2, sodium_g_serv = sodium_g_2)


# make sure all columns are numeric, remove the "<" from fibre and protein columns
sides_clean <- sides_clean %>% 
  mutate_all(type.convert) %>%
  mutate_if(is.factor, as.character) %>%
  mutate(fibre_g_serv = as.numeric(gsub("<", "", fibre_g_serv))) %>%
  mutate(protein_g_serv = as.numeric(gsub("<", "", protein_g_serv))) %>%
  mutate(serves = as.factor(serves))


# defining UK recommended daily allowances of nutrients
rda_kcal <- 2000
rda_fat <- 70
rda_sat <- 20
rda_carbs <- 260
rda_sugar <- 90
rda_protein <- 50
rda_salt <- 6
rda_sodium <- 2.4
rda_fibre <- 30


# add columns for %RDA per servings
sides_clean <- sides_clean %>%
  mutate(Calories = round((energy_kcal_serv / rda_kcal)*100, 0)) %>%
  mutate(Fat = round((fat_g_serv / rda_fat)*100, 0)) %>%
  mutate(Saturated = round((sat_g_serv / rda_sat)*100, 0)) %>%
  mutate(Carbs = round((carb_g_serv / rda_carbs)*100, 0)) %>%
  mutate(Sugar = round((sugars_g_serv / rda_sugar)*100, 0)) %>%
  mutate(Fibre = round((fibre_g_serv / rda_fibre)*100, 0)) %>%
  mutate(Protein = round((protein_g_serv / rda_protein)*100, 0)) %>%
  mutate(Salt = round((salt_g_serv / rda_salt)*100, 0))



# save clean data
write_csv(sides_clean, "clean_data/sides_clean.csv")