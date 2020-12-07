library(readxl)
library(janitor)
library(tidyverse)
library(shiny)
library(shinythemes)



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







  pizza_RDA %>%
    filter(name == "American Hot" | name == "Americano") %>%
    filter(size == "Medium") %>%
    filter(crust == "Classic Crust") %>%
    group_by(name) %>%
    ggplot() +
    aes(x = Macros, y = Values, fill = name, group = name) +
    geom_col(position = "dodge", col = "white") +
    geom_text(aes(label = paste0(Values, "%")), position = position_dodge(0.9), vjust = 1.5) +
    theme_bw()
  
  
  pizza1 <- pizza_RDA %>%
    filter(name == "American Hot" & 
             size == "Medium" & 
             crust == "Classic Crust") %>%
    group_by(Macros) %>%
    summarise(pizza1 = Values)
  
  pizza2 <- pizza_RDA %>%
    filter(name == "Americano" &
             size == "Medium" &
             crust == "Stuffed Crust") %>%
    group_by(Macros) %>%
    summarise(pizza2 = Values)
  
  pizza_compare <- pizza1 %>%
    left_join(pizza2)
  
  pizza_joined <- pizza_compare %>%
    pivot_longer(cols = c(pizza1, pizza2),
                 names_to = "Pizza",
                 values_to = "Values")
  
  pizza_joined %>%
    ggplot() +
    aes(x = Macros, y = Values, fill = Pizza) +
    geom_col(position = "dodge", col = "white") +
    geom_text(aes(label = paste0(Values, "%")), position = position_dodge(0.9), vjust = 1.5) +
    theme_bw()