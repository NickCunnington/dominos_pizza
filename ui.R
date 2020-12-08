
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
    
    tabItem(tabName = "info_page",
            h2("Information")
    ),
    
    tabItem(tabName = "sides_page",
            h1("Sides Menu"), 
            br(), 
            br(),

            fluidRow(
              column(width = 6,
              box(title = "Select Paramaters", status = "primary", solidHeader = TRUE,
                  radioButtons("type_side", label = h3("Side Type"),
                               choices = sides_type),
                  verbatimTextOutput("value_type"),
                  
                  selectInput("macro_side", label = h3("Choose Macro"),
                              choices = sides_macros),
                  verbatimTextOutput("value_macro"),
                  
                  actionButton("action_side", label = "Submit")
                  )
              ),
            
              
              column(width = 6,
              box(title = "Information", status = "warning", solidHeader = TRUE,
                  "Choose which type of dish you would like to see information about.",
                  br(),
                  br(),
                  "Figures are given in percent of your Daily Recommended Allowance (RDA) intake.",
                  br(),
                  br(),
                  "This is also based on per allocated serving size and not necessarily for the whole dish.")
              )
            ),
            
            fluidRow(box
                     (width = 12,
                       plotOutput("sides_plot")
                     )
            )
    ),
 
    tabItem(tabName = "pizza_page",
            h2("Pizzas Menu")
            ),

    tabItem(tabName = "sides_compare",
            h2("Compare Side Dishes")
            ),

    tabItem(tanName = "pizza_compare",
            h2("Compare Pizzas Types")
            )
  )
)













ui <- dashboardPage(
  dashboardHeader(title = "Dominos Pizza Nutritional Information"),
  sidebar,
  body
  )