
library(readxl)
library(janitor)
library(tidyverse)


# read in data
pizza <- read_xlsx("raw_data/UKNutritionalsRegularMozzarella.xlsx")


# making column names from 2nd row
pizza_clean <- pizza %>%
  row_to_names(row_number = 2)


# adding in first 3 columns names
colnames(pizza_clean)[1] <- "name"
colnames(pizza_clean)[2] <- "crust"
colnames(pizza_clean)[3] <- "size"


# removing spaces between tables
pizza_clean <- pizza_clean %>%
  drop_na(size)


# adding in additional pizza names to overwrite NAs
pizza_clean$name <- c(rep("Gluten Free Pizzas", 5), rep("Vegan Pizza", 4), 
                      rep("American Hot", 11), rep("Americano", 11),
                      rep("Bacon Double Cheese", 11), rep("Buffalo Chicken", 11),
                      rep("Catalan Chicken and Chorizo", 11), rep("Chicken Feast", 11),
                      rep("Deluxe", 11), rep("Farmhouse", 11), 
                      rep("Fiery Vegi Sizzler", 11), rep("Four Vegi", 11),
                      rep("Full House", 11), rep("Ham & Pineapple", 11),
                      rep("Hawaiian", 11), rep("Hot & Spicy", 11),
                      rep("House Special Tandoori Chicken", 11), 
                      rep("Meateor", 11), rep("Meatilicious", 11), 
                      rep("Meat Lovers", 11), rep("Meatzza Pizza", 11),
                      rep("Mexican Hot", 11), rep("Mighty Meaty", 11),
                      rep("Mixed Grill", 11), rep("New Yorker", 11),
                      rep("Original Cheese and Tomato", 11), 
                      rep("Pepperoni Passion", 11), rep("Ranch BBQ", 11),
                      rep("Scrummy", 11), rep("Tandoori Hot", 11),
                      rep("Tandoori Sizzler", 11), rep("Texas BBQ", 11),
                      rep("The Cheeseburger", 11), rep("The Beef Doner", 11),
                      rep("The Meatfielder", 11), rep("The Sizzler", 11),
                      rep("Tuna Supreme", 11), rep("Veg-a-Roma", 11), 
                      rep("Vegi Classic", 11), rep("Vegi Sizzler", 11), 
                      rep("Vegi Supreme", 11), rep("Vegi Volcano", 11))


# adding in pizza sizes to overwrite NAs
pizza_clean$crust <- c("GF Cheese & Tomato", "GF Vegi Supreme", "GF Pepperoni Passion",
                       "GF Texas BBQ", "GF New Yorker", "Vegan Margherita", 
                       "Vegan Vegi Supreme", "Vegan Margherita - Italian Style",
                       "Vegan Vegi Supreme - Italian Style",
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2),
                       rep("Classic Crust", 4), rep("Italian Style Crust", 3),
                       rep("Stuffed Crust", 2), rep("Thin & Crispy Crust", 2))


# clean column names, convert numbers from character to numeric
pizza_clean <- pizza_clean %>%
  clean_names() %>%
  mutate_all(type.convert) %>%
  mutate_if(is.factor, as.character)


# renaming some column names
pizza_clean <- pizza_clean %>%
  rename(energy_kcal_100g = energy_kcal, energy_kj_100g = energy_k_j, 
         fat_g_100g = fat_g, sat_g_100g = sat_g, carb_g_100g = carb_g,
         sugars_g_100g = sugars_g, fibre_g_100g = fibre_g, protein_g_100g = 
           protein_g, salt_g_100g = salt_g, sodium_g_100g = sodium_g,
         energy_kcal_serv = energy_kcal_2, energy_kj_serv = energy_k_j_2,
         fat_g_serv = fat_g_2, sat_g_serv = sat_g_2, carb_g_serv = carb_g_2,
         sugars_g_serv = sugars_g_2, fibre_g_serv = fibre_g_2, protein_g_serv =
           protein_g_2, salt_g_serv = salt_g_2, sodium_g_serv = sodium_g_2)


# creating RDA macros
rda_kcal <- 2000
rda_fat <- 70
rda_sat <- 20
rda_carbs <- 260
rda_sugar <- 90
rda_protein <- 50
rda_salt <- 6
rda_sodium <- 2.4
rda_fibre <- 30


# creating %RDA columns for servings
pizza_clean <- pizza_clean %>%
  mutate(Calories = round((energy_kcal_serv / rda_kcal)*100, 0)) %>%
  mutate(Fat = round((fat_g_serv / rda_fat)*100, 0)) %>%
  mutate(Saturated = round((sat_g_serv / rda_sat)*100, 0)) %>%
  mutate(Carbs = round((carb_g_serv / rda_carbs)*100, 0)) %>%
  mutate(Sugar = round((sugars_g_serv / rda_sugar)*100, 0)) %>%
  mutate(Fibre = round((fibre_g_serv / rda_fibre)*100, 0)) %>%
  mutate(Protein = round((protein_g_serv / rda_protein)*100, 0)) %>%
  mutate(Salt = round((salt_g_serv / rda_salt)*100, 0))


# save clean data
write_csv(pizza_clean, "clean_data/pizza_clean.csv")