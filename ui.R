ui <- fluidPage(tags$head(
  
  tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
),
  theme = shinytheme("spacelab"),

navbarPage(
  title = div(img(src="pizza.png", id = "logo"), "Dominos Pizza Nutritional Information"),

tabsetPanel(
  
  # Tab 1
  
  tabPanel("Sides Menu", div(class = "separator30"),
           
           
           fluidRow(
             column(4,
                    tags$h5("Choose which type of dish you would like to see information about."),
                    div(class = "separator30"),
                    "Figures are given in percent of your Daily Recommended Allowance (RDA) intake.",
                    div(class = "separator30"),
                    "This is also based on per allocated serving size and not necessarily for the whole dish.",
                    
             ),
             
             column(4,
                    tags$div(class = "select_box",
                             radioButtons("type_side",
                                          tags$h5("Side dish type"),
                                          choices = sides_type),
                             selectInput("macro_side",
                                          tags$h5("Choose Macro"),
                                          choices = sides_macros, selected = 1),
                             div(class = "separator20"),
                             actionButton("action_side",
                                 tags$h3("Submit")
                                 ),
                             div(class = "separator20")
                    )
                    
             )
           ),
            

           fluidRow(
             column(12,
                    div(class = "separator30"),
                    div(class = "separator30"),   
                    plotOutput("sides_plot", height = 600)
             )
           )
           
           
           
  ),


 # Tab2

  tabPanel("Compare Side Dishes", div(class = "separator30"),
         
         
         fluidRow(
           column(3,
                  tags$h5("Select the both sides you wish to compare, then click SUBMIT."),
                  div(class = "separator20"),
                  "Figures as shown as percent of Recommended Daily Allowance (%RDA) per serving.",
                  div(class = "separator20"),         
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
                           
                  
                           
                  ),
           
           column(3,
                  tags$div(class = "select_box",
                           selectInput("side1_name",
                                       tags$h5("Choose First side name"),
                                       choices = sides_names, selected = 1),
                           selectInput("side2_name",
                                       tags$h5("Choose Second side name"),
                                       choices = sides_names, selected = 1),        
                           div(class = "separator20"),
                           actionButton("action_side_compare", tags$h3("Submit")
                                        ),
                           div(class = "separator20")
                           )
              )
           ),
           
         
           fluidRow(
             column(12,
                    div(class = "separator30"),
                    div(class = "separator30"),   
                    plotOutput("sides_compare_plot", height = 700)
             )
           ),
         
         fluidRow(
           column(12,
                  div(class = "separator30"),
                  div(class = "separator30"),
                  tags$h5("The data table below shows the actual macro figures in grams per serving portion (apart from KCal for Energy)."),
                  div(class = "separator30"),
                  DT::dataTableOutput("sides_DT"),
                  div(class = "separator30"))
         )
        
  ),

  # Tab 3

  tabPanel("Crust Types", div(class = "separator30"),
         
         
         fluidRow(
          column(3,
                 tags$h5("Choose which type of macro you would like to see information about."),
                 div(class = "separator20"),
                 "To make direct comparison between different crust types everything is selected as medium sized.",
                 div(class = "separator20"),
                 "Figures are given in a percentage of your Daily Recommended Allowance (RDA) intake per serving.",
                 div(class = "separator20"),
                 "Serving size is given as 3 slices of a medium sized pizza."
                  
           ),
         
         column(3,
                tags$div(class = "select_box",
                         selectInput("macro_crust",
                                     tags$h5("Choose Macro"),
                                     choices = pizza_macros),
                         div(class = "separator30")
                )
          )
         ),
         
         fluidRow(
             column(12,
                    div(class = "separator30"),
                    div(class = "separator30"),   
                    plotOutput("crust_plot", height = 500)
                  )
           )

  ),

  # Tab 4

  tabPanel("Pizza Types", div(class = "separator30"),
         
         
         fluidRow(
           
           column(3,
                  tags$h5("Choose which type of macro you would like to see information about."),
                  div(class = "separator20"),
                  "To make direct comparison between different pizza types everything is selected as medium sized.",
                  div(class = "separator20"),
                  "Figures are given in a percentage of your Daily Recommended Allowance (RDA) intake per serving.",
                  div(class = "separator20"),
                  "Serving size is given as 3 slices of a medium sized pizza."
                  
                  ),
           
           column(3,
                  tags$div(class = "select_box",
                           selectInput("macro_pizza",
                                       tags$h5("Choose Macro"),
                                       choices = pizza_macros, selected = 1),
                                        div(class = "separator30")
                  )
           )
         ),
           
           
          fluidRow(
             column(12,
                    div(class = "separator30"),
                    div(class = "separator30"),   
                    plotOutput("pizza_plot", height = 800)
                    )
           )
           
  ),

  # Tab 5

  tabPanel("Compare Pizzas Types", div(class = "separator30"),
         
         
         fluidRow(
           column(3,
                  tags$h5("Select the parameters for both pizzas you wish to compare, then click SUBMIT."),
                  div(class = "separator20"),
                  "Be aware that not all pizza types are available in every crust variety and size.",
                  div(class = "separator20"),
                  "Figures as shown as percent of Recommended Daily Allowance (%RDA) per serving.",
                  div(class = "separator30"),
                  "Serving sizes may not consitute a whole pizza.  Specified servings sizes are given as:",
                  div(class = "separator20"),
                  "* Large = 3 slices,",
                  div(class = "separator20"),
                  "* Medium = 3 slices,",
                  div(class = "separator20"),
                  "* Small = whole pizza,",
                  div(class = "separator20"),
                  "* Personal = whole pizza."
                           
           ),
           
           column(3,
                  tags$div(class = "select_box",
                           tags$h2("First Pizza"),
                           div(class = "separator20"),
                           selectInput("pizza1_name",
                                       tags$h5("Choose first pizza name"),
                                       choices = pizza_names, selected = 1),
                           radioButtons("pizza1_crust",
                                       tags$h5("Choose first pizza crust type"),
                                       choices = pizza_crust),        
                           radioButtons("pizza1_size",
                                       tags$h5("Choose first pizza size"),
                                       choices = pizza_size)
                                       
                  )
           ),
           
           column(3,
                  tags$div(class = "select_box",
                           tags$h2("Second Pizza"),
                           div(class = "separator20"),
                           selectInput("pizza2_name",
                                       tags$h5("Choose second pizza name"),
                                       choices = pizza_names, selected = 1),
                           radioButtons("pizza2_crust",
                                        tags$h5("Choose second pizza crust type"),
                                        choices = pizza_crust),        
                           radioButtons("pizza2_size",
                                        tags$h5("Choose second pizza size"),
                                        choices = pizza_size)
                           
                  )
           ),
           
           column(3,
                  tags$div(class = "select_box", status = "danger",
                           "If a red warning message about aesthetics appears below, or one of your choices doesn't appear in the plot, please try another crust type and/or size combination as what you have selected is not available for that pizza."
                  ),
                  div(class = "separator30"),
                  actionButton("action_pizza_compare",
                              tags$h3("Submit")
                                        )
                           
                  )
         ),
           
           
           fluidRow(
             column(12,
                    div(class = "separator30"),
                    div(class = "separator30"),   
                    plotOutput("pizza_compare", height = 700)
             )
           ),
         
         fluidRow(
           column(12,
                  div(class = "separator30"),
                  div(class = "separator30"),
                  tags$h5("The data table below shows the actual macro figures in grams per serving portion (apart from KCal for Energy)."),
                  div(class = "separator30"),
                  DT::dataTableOutput("pizza_compare_DT"),
                  div(class = "separator30"))
         )
           
          
         )
  )
)
)