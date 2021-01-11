library(readxl)
library(janitor)
library(tidyverse)
library(shiny)
library(shinythemes)
library(shinydashboard)


################ PIZZA DATA ###############

# read in data
pizza <- read_csv("clean_data/pizza_clean.csv")



# remove gluten free and vegan pizzas as they are not all available in the same 
# sizes and crust types as other pizzas so it is not possible to directly
# compare their nutritional information
pizza <- pizza %>%
  filter(name != "Gluten Free Pizzas" & name != "Vegan Pizza") 



# convert the data in long format for ease of plotting
pizza_RDA <- pizza %>%
  select(name, crust, size, Calories, Protein, Fat, Saturated, Carbs, Sugar,
         Fibre, Salt) %>%
  group_by(name, crust, size) %>%
  pivot_longer(cols = c(Calories, Protein, Fat, Saturated, Carbs, Sugar, Fibre, 
                        Salt), 
               names_to = "Macros", 
               values_to = "Values")


# getting all pizza variables for menu selection
pizza_names <- unique(pizza_RDA$name)
pizza_crust <- unique(pizza_RDA$crust)
pizza_macros <- unique(pizza_RDA$Macros)
pizza_size <- unique(pizza_RDA$size)





############## SIDES DATA ####################


# read in data
sides <- read_csv("clean_data/sides_clean.csv")



# convert into long format and remove duplicates of sides that have the same RDA
# per serving, but are a bigger version of the original
sides_RDA <- sides %>%
  select(dish, type, Calories, Fat, Saturated, Carbs, Sugar, Fibre, Protein, Salt) %>%
  filter(dish != "Spicy BBQ Wings (14)" & dish != "Frank's Red Hot Wings (14)" &
           dish != "Chicken Wings (14)" & dish!= "Chicken Strippers (14)" &
           dish != "Chicken Kickers (14)" & dish != "Pop'n Chicken Double Portion" &
           dish != "BBQ Dip 100g" & dish != "Frank's Hot Dip 100g" & 
           dish != "Garlic and Herb Dip 100g") %>% 
  pivot_longer(cols = c(Calories, Fat, Saturated, Carbs, Sugar, Fibre, Protein, 
                        Salt), 
               names_to = "Macros", 
               values_to = "Values")


# getting all sides variables for menu selection
sides_names <- unique(sides_RDA$dish)
sides_type <- unique(sides_RDA$type)
sides_macros <- unique(sides_RDA$Macros)
