
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Information", tabName = "info_page", 
             icon = icon("user", lib = "glyphicon"),
             badgeLabel = "main", badgeColor = "green"),
    menuItem("Sides Menu", tabName = "sides_page", 
             icon = icon("user", lib = "glyphicon")),
    menuItem("Compare Side Dishes", tabName = "sides_compare", 
             icon = icon("send", lib = "glyphicon")),
    menuItem("Crust Types", tabName = "crust_page", 
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
              box(width = 14, title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                  radioButtons("type_side", label = h3("Side Type"),
                               choices = sides_type),
                  
                  selectInput("macro_side", label = h3("Choose Macro"),
                              choices = sides_macros),
                  
                  actionButton("action_side", label = "Submit")
                  )
              ),
            
              
              column(width = 4,
              box(width = 14, title = "Information", status = "warning", solidHeader = TRUE,
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
            h2("Compare Side Dishes"),
        br(),
        br(),
        
        
        fluidRow(
          
          column(width = 3,
                 box(width = 14, title = "Information", status = "warning", solidHeader = TRUE,
                     "Select the both sides you wish to compare, then click SUBMIT.",
                     br(),
                     br(),
                     "Figures as shown as percent of Recommended Daily Allowance (%RDA) per serving.",
                     br(),
                     br(),
                     "Serving sizes may not consitute a whole side.  Specified servings sizes are given as:",
                     br(),
                     "* Chick 'n' Mix = 1/2 of dish,",
                     br(),
                     "* Chicken Kickers = 1/2 of dish,",
                     br(),
                     "* Chicken Kickers Combo = 1/4 of dish,",
                     br(),
                     "* Chicken Strippers = 1/2 of dish,",
                     br(),
                     "* Chicken Strippers Combo = 1/4 of dish,",
                     br(),
                     "* Chicken Wings = 1/2 of dish,",
                     br(),
                     "* Chicken Wings Combo = 1/4 of dish,",
                     br(),
                     "* Chilli Flakes = whole dish,",
                     br(),
                     "* Coleslaw = 1/2 of dish,",
                     br(),
                     "* Frank's Red Hot Wings = 1/2 of dish,",
                     br(),
                     "* Garlic Dippers = 1/2 of dish,",
                     br(),
                     "* Garlic Pizza Bread = 1/2 of dish,",
                     br(),
                     "* Nachos (no Jalapenos) = 1/2 of dish,",
                     br(),
                     "* Nachos (with Jalapenos) = 1/2 of dish,",
                     br(),
                     "* Pop'n Chicken = 1/2 of dish,",
                     br(),
                     "* Pop'n Chicken Combo = 1/4 of dish,",
                     br(),
                     "* Potato Wedges = 1/2 of dish,",
                     br(),
                     "* Spicy BBQ Wings = 1/2 of dish,",
                     br(),
                     "* Twisted Dough Balls (all types) = 1/2 of dish,",
                     br(),
                     "* 25g Dips (all types) = whole pot,",
                     br(),
                     "* Wrappz (all types) = whole wrap,",
                     br(),
                     "* Desserts (all types) = 1/4 of dish."

                 )
                 
          ),
          
          column(width = 3,
                 box(width = 14, title = "Choose Sides", status = "primary", solidHeader = TRUE,
                    selectInput("side1_name", label = h3("Choose First side name"),
                                 choices = sides_names), 
                    br(),
                    selectInput("side2_name", label = h3("Choose Second side name"),
                                 choices = sides_names),
                    br(),
                    br(),
                    actionButton("action_side_compare", label = "Submit Query")
                 )
          )
          
          
          
        ),
        
        fluidRow(box
                 (width = 12, plotOutput("sides_compare_plot", height = 700)

                 )

        )
),




# CRUST PAGE

    tabItem(tabName = "crust_page",
            h2("Crust Types"),
            br(), 
            br(),
            
                                      # Crust type
            
            fluidRow(
              column(width = 4,
                     box(width = 14, title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                         selectInput("macro_crust", label = h3("Choose Macro"),
                                     choices = pizza_macros)
                         )
                     ),
              
              column(width = 4,
                     box(width = 14, title = "Information", status = "warning", solidHeader = TRUE,
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
                     (width = 12, plotOutput("crust_plot", height = 500)
                     )
            )
    ),
      
                 
# PIZZA PAGE
            
      tabItem(tabName = "pizza_page",
              h2("Pizza Types"),
              br(), 
              br(),            

            
            fluidRow(
              column(width = 4,
                     box(width = 14,title = "Select Paramaters", status = "primary", 
                         solidHeader = TRUE,
                         selectInput("macro_pizza", label = h3("Choose Macro"),
                                     choices = pizza_macros)
                     )
              ),
              
              column(width = 4,
                     box(width = 14, title = "Information", status = "warning", 
                         solidHeader = TRUE,
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
                     (width = 12, plotOutput("pizza_plot", height = 800)
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
                     box(width = 14, title = "Information", status = "warning", solidHeader = TRUE,
                         "Select the parameters for both pizzas you wish to compare, then click SUBMIT.",
                         br(),
                         br(),
                         "Be aware that not all pizza types are available in every crust variety and size.",
                         br(),
                         br(),
                         "Figures as shown as percent of Recommended Daily Allowance (%RDA) per serving.",
                         br(),
                         br(),
                         "Serving sizes may not consitute a whole pizza.  Specified servings sizes are given as:",
                         br(),
                         "* Large = 3 slices,",
                         br(),
                         "* Medium = 3 slices,",
                         br(),
                         "* Small = whole pizza,",
                         br(),
                         "* Personal = whole pizza."
                         
                     ),
                     box(width = 14, title = "Warning", status = "danger", solidHeader = TRUE,
                         "If a red warning message about aesthetics appears below, or one of your choices doesn't appear in the plot, please try another crust type and/or size combination as what you have selected is not available for that pizza."
                     )
                     
              ),
              
              column(width = 3,
                     box(width = 14, title = "First Pizza", status = "primary", solidHeader = TRUE,
                         selectInput("pizza1_name", label = h3("Choose first pizza name"),
                                     choices = pizza_names),
                         radioButtons("pizza1_crust", label = h3("Choose first pizza crust type"),
                                      choices = pizza_crust),
                         radioButtons("pizza1_size", label = h3("Choose first pizza size"),
                                      choices = pizza_size)
                     )
                     
              ),
              
              column(width = 3,
                     box(width = 14, title = "Second Pizza", status = "primary", solidHeader = TRUE, 
                         selectInput("pizza2_name", label = h3("Choose first pizza name"),
                                     choices = pizza_names),
                         radioButtons("pizza2_crust", label = h3("Choose first pizza crust type"),
                                      choices = pizza_crust),
                         radioButtons("pizza2_size", label = h3("Choose first pizza size"),
                                      choices = pizza_size)
                     )
              ),
              
              
              column(width = 3,
                     box(width = 14, title = "SUBMIT", status = "success", solidHeader = TRUE,
                         actionButton("action_pizza_compare", label = "Submit Query")
                     )
              )
            ),
            
            
      
            fluidRow(box
                    (width = 12, plotOutput("pizza_compare", height = 700)
                
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
