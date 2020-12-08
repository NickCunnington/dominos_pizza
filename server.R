
server <- function(input, output) {
  
  output$pizza <- eventReactive(input$macro_pizza, input$type_pizza{
    pizza_RDA %>%
      filter(size == "Medium") %>%
      filter(Macros == input$macro_pizza) %>%
      group_by(input$type_pizza) %>%
      summarise(avg_percent_RDA = round(mean(Values),0)) %>%
      ggplot() +
      aes(x = input$type_pizza, y = avg_percent_RDA) +
      geom_col(fill = "darkblue") +
      geom_text(aes(label = paste0(avg_percent_RDA, "%")), hjust = 1.2, col = "white") +
      coord_flip() +
      xlab(paste0(input$type_pizza, " Type\n")) +
      ylab("\nRDA (%)") +
      ggtitle(paste0("%RDA of ", input$macro_pizza, " per ,", 
                     input$type_pizza, " Type (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold")) +
      theme(axis.title.x = element_text(size = 14)) +
      theme(axis.title.y = element_text(size = 14))
  })

  output$sides <- eventReactive(input$macro_side, input$type_side{
    sides_RDA %>%
      filter(Macros == input$macro_side) %>%
      filter(type == input$type_side) %>%
      group_by(dish) %>%
      summarise(percent_RDA = round(Values),0) %>%
      ggplot() +
      aes(x = dish, y = percent_RDA) +
      geom_col(fill = "darkblue") +
      geom_text(aes(label = paste0(avg_percent_RDA, "%")), hjust = 1.2, col = "white") +
      coord_flip() +
      xlab(paste0(input$type_side, " Type\n")) +
      ylab("\nRDA (%)") +
      ggtitle(paste0("%RDA of ", input$macro_side, " per ,", 
                     input$type_side, " Type (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold")) +
      theme(axis.title.x = element_text(size = 14)) +
      theme(axis.title.y = element_text(size = 14))
  })
  
  pizza1 <- eventReactive(input$pizza1_name, input$pizza1_crust, input$pizza1_size{
    
    pizza_RDA %>%
      filter(name == input$pizza1_name & 
               size == input$pizza1_size & 
               crust == input$pizza1_crust) %>%
      group_by(Macros) %>%
      summarise(input$pizza1_name = Values)
  })
  
  pizza2 <- eventReactive(input$pizza2_name, input$pizza2_crust, input$pizza2_size{
    
    pizza_RDA %>%
      filter(name == input$pizza2_name & 
               size == input$pizza2_size & 
               crust == input$pizza2_crust) %>%
      group_by(Macros) %>%
      summarise(input$pizza2_name = Values)
  })
  
  pizza_long <- pizza1 %>%
    left_join(pizza2) %>%
    pivot_longer(cols = c(input$pizza1_name, input$pizza2_name),
                 names_to = Pizza,
                 values_to = Values)
  
  
  output$compare <- renderPlot({
    pizza_long %>%
      ggplot() +
      aes(x = Macro, y = Values, fill = Pizza) +
      geom_col(position = "dodge", col = "white") +
      geom_text(aes(label = paste0(Values, "%")), position = position_dodge(0.9), vjust = 1.5) +
      xlab("\nPizza Types") +
      ylab("RDA (%)\n") +
      ggtitle(paste0("Comparison ", input$pizza1_name, " vs ", 
                     input$pizza2_name, " (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold")) +
      theme(axis.title.x = element_text(size = 14)) +
      theme(axis.title.y = element_text(size = 14))
      
  })
 
  output$table <- DT::renderDataTable({
    
    pizza_long
      
  })
  
}
  


