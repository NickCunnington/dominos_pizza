library(readxl)
library(janitor)
library(tidyverse)
library(shiny)
library(shinythemes)


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
