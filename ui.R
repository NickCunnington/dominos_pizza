
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Information", tabName = "info_page", 
             icon = icon("user", lib = "glyphicon"),
             badgeLabel = "main", badgeColor = "green"),
    menuItem("Sides Menu", tabName = "sides_page", 
             icon = icon("user", lib = "glyphicon")),
    menuItem("Compare Side Dishes", tabName = "sides_compare", 
             icon = icon("send", lib = "glyphicon")),
    menuItem("Pizza Menu", tabName = "pizza_page", 
             icon = icon("send", lib = "glyphicon")),
    menuItem("Compare Pizza Types", tabName = "pizza_compare", 
             icon = icon("send", lib = "glyphicon")),
    menuItem("Source code", icon = icon("file-code-o"), 
             href = "https://github.com/NickCunnington/dominos_pizza")
  )
)


body <- dashboardBody(
  tabItems(

    
# INFO PAGE    
        
    tabItem(tabName = "info_page",
            h2("Information")
    ),
 
    
    
# SIDES PAGE    
   
    tabItem(tabName = "sides_page",
            h1("Sides Menu"), 
            br(), 
            br(),

            fluidRow(
              column(width = 4,
              box(title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                  radioButtons("type_side", label = h3("Side Type"),
                               choices = sides_type),
                  
                  selectInput("macro_side", label = h3("Choose Macro"),
                              choices = sides_macros),
                  
                  actionButton("action_side", label = "Submit")
                  )
              ),
            
              
              column(width = 4,
              box(title = "Information", status = "warning", solidHeader = TRUE,
                  "Choose which type of dish you would like to see information about.",
                  br(),
                  br(),
                  "Figures are given in percent of your Daily Recommended Allowance (RDA) intake.",
                  br(),
                  br(),
                  "This is also based on per allocated serving size and not necessarily for the whole dish.",
                  br(),
                  br()
                  )
              )
            ),
            
            fluidRow(box
                     (width = 12,
                       plotOutput("sides_plot", height = 600)
                     )
            )
    ),



# SIDES COMPARE PAGE

    tabItem(tabName = "sides_compare",
            h2("Compare Side Dishes")
    ),
 



# PIZZA PAGE

    tabItem(tabName = "pizza_page",
            h2("Pizzas Menu"),
            br(), 
            br(),
            
                                      # Crust type
            
            fluidRow(
              column(width = 4,
                     box(title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                         selectInput("macro_crust", label = h3("Choose Macro"),
                                     choices = pizza_macros),
                         )
                     ),
              
              column(width = 8,
                     box(title = "Information", status = "warning", solidHeader = TRUE,
                         "Choose which type of macro you would like to see information about.",
                         br(),
                         br(),
                         "To make direct comparison between different crust types everything is selected as medium sized.",
                         br(),
                         br(),
                         "Figures are given in a percentage of your Daily Recommended Allowance (RDA) intake per serving.",
                         br(),
                         br(),
                         "Serving size is given as 3 slices of a medium sized pizza.",
                         br(),
                         br()

                         )
                     )
            ),
            
            fluidRow(box
                     (width = 12,
                       plotOutput("crust_plot", height = 500)
                     )
            ),
            br(), 
            br(),
            
                                  # pizza type
            
            
            fluidRow(
              column(width = 4,
                     box(title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                         selectInput("macro_pizza", label = h3("Choose Macro"),
                                     choices = pizza_macros),
                     )
              ),
              
              column(width = 8,
                     box(title = "Information", status = "warning", solidHeader = TRUE,
                         "Choose which type of macro you would like to see information about.",
                         br(),
                         br(),
                         "To make direct comparison between different pizza types everything is selected as medium sized.",
                         br(),
                         br(),
                         "Figures are given in a percentage of your Daily Recommended Allowance (RDA) intake per serving.",
                         br(),
                         br(),
                         "Serving size is given as 3 slices of a medium sized pizza.",
                         br(),
                         br()
                         
                     )
              )
            ),
            
            fluidRow(box
                     (width = 12,
                       plotOutput("pizza_plot", height = 800)
                     )
            )
            
             
    ),
              



# PIZZA COMPARE PAGE
          
      tabItem(tabName = "pizza_compare",
            h2("Compare Pizzas Types"),
            br(),
            br(),
            
            
            fluidRow(
              
              column(width = 3,
                     box(title = "First Pizza", status = "warning", solidHeader = TRUE,
                         selectInput("pizza1_name", label = h3("Choose first pizza name"),
                                     choices = pizza_names),
                         radioButtons("pizza1_crust", label = h3("Choose first pizza crust type"),
                                      choices = pizza_crust),
                         radioButtons("pizza1_size", label = h3("Choose first pizza size"),
                                      choices = pizza_size)
                     )
                     
              ),
              
              column(width = 3,
                     box(title = "Second Pizza", status = "warning", solidHeader = TRUE,
                         selectInput("pizza2_name", label = h3("Choose first pizza name"),
                                     choices = pizza_names),
                         radioButtons("pizza2_crust", label = h3("Choose first pizza crust type"),
                                      choices = pizza_crust),
                         radioButtons("pizza2_size", label = h3("Choose first pizza size"),
                                      choices = pizza_size)
                     )
              ),
              
              
              column(width = 3,
                     box(title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                         selectInput("macro_crust", label = h3("Choose Macro"),
                                     choices = pizza_macros),
                         br(),
                         br(),
                         actionButton("action_pizza_compare", label = "Submit Query")
                     )
              ),
              
              
              column(width = 3,
                     box(title = "Information", status = "warning", solidHeader = TRUE,
                         "Choose which type of macro you would like to see information about.",
                         br(),
                         br(),
                         "To make direct comparison between different crust types everything is selected as medium sized.",
                         br(),
                         br(),
                         "Figures are given in a percentage of your Daily Recommended Allowance (RDA) intake per serving.",
                         br(),
                         br(),
                         "Serving size is given as 3 slices of a medium sized pizza.",
                         br(),
                         br()
                         
                     )
              )
            )
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            )
  )
)













ui <- dashboardPage(
  dashboardHeader(title = "Dominos Pizza Nutritional Information"),
  sidebar,
  body
  )