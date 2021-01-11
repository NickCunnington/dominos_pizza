
server <- function(input, output) {
  
  # pizza menu
  
  output$pizza_plot <- renderPlot({
    pizza_RDA %>%
      filter(size == "Medium") %>%
      filter(Macros == input$macro_pizza) %>%
      group_by(name) %>%
      summarise(avg_percent_RDA = round(mean(Values),0)) %>%
      ggplot() +
      aes(reorder(x = name, avg_percent_RDA), y = avg_percent_RDA) +
      geom_col(fill = "darkblue", col = "white") +
      geom_text(aes(label = paste0(avg_percent_RDA, "%")), hjust = 1.2, col = "red") +
      coord_flip() +
      xlab("Pizza Type\n") +
      ylab("\nRDA (%)") +
      ggtitle(paste0("Average %RDA of ", input$macro_pizza, " per Pizza Type (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold")) +
      theme(axis.title.x = element_text(size = 16)) +
      theme(axis.title.y = element_text(size = 16)) +
      theme(axis.text = element_text(size = 12))
  })

  # crust type
  
  output$crust_plot <- renderPlot({
    pizza_RDA %>%
      filter(size == "Medium") %>%
      filter(Macros == input$macro_crust) %>%
      group_by(crust) %>%
      summarise(avg_percent_RDA = round(mean(Values),0)) %>%
      ggplot() +
      aes(reorder(x = crust, avg_percent_RDA), y = avg_percent_RDA) +
      geom_col(fill = "darkblue", col = "white") +
      geom_text(aes(label = paste0(avg_percent_RDA, "%")), hjust = 1.2, col = "red") +
      coord_flip() +
      xlab("Crust Type\n") +
      ylab("\nRDA (%)") +
      ggtitle(paste0("Average %RDA of ", input$macro_crust, " per Crust Type (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold")) +
      theme(axis.title.x = element_text(size = 16)) +
      theme(axis.title.y = element_text(size = 16)) +
      theme(axis.text = element_text(size = 12))
    
  })
  
  
  
  
  
  # sides menu - reactive
  
  sides_filtered <- eventReactive(input$action_side,{
     sides_RDA %>%
       filter(type == input$type_side) %>%
       filter(Macros == input$macro_side) %>%
       group_by(dish) %>%
       summarise(percent_RDA = round(Values)) 
       
  })
  
  # sides plot
  
  output$sides_plot <- renderPlot({
    
      ggplot(sides_filtered()) +
      aes(reorder(x = dish, percent_RDA), y = percent_RDA) +
      geom_col(fill = "darkblue") +
      geom_text(aes(label = paste0(percent_RDA, "%")), hjust = 1.2, col = "red") +
      coord_flip() +
      xlab(paste0(input$type_side, " Type\n")) +
      ylab("\nRDA (%)") +
      ggtitle(paste0("%RDA of ", input$macro_side, " per ",
                     input$type_side, " type (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold")) +
      theme(axis.title.x = element_text(size = 16)) +
      theme(axis.title.y = element_text(size = 16)) +
      theme(axis.text = element_text(size = 12))
  })
 
  # sides compare reactive
  
  sides_compare <- eventReactive(input$action_side_compare,{
    
    sides_RDA %>%
      filter(dish == input$side1_name | dish == input$side2_name)
  
  })
  
  # sides compare plot
  
  output$sides_compare_plot <- renderPlot({
    
      ggplot(sides_compare()) +
      aes(x = Macros, y = Values, fill = dish) +
      geom_col(position = "dodge", col = "white") +
      geom_text(aes(label = paste0(Values, "%")), position = position_dodge(0.9), vjust = 1.5) +
      xlab("\nSide Types") +
      ylab("RDA (%)\n") +
      ggtitle(paste0("Comparison of ", input$side1_name, "  VS.  ", input$side2_name, " (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold")) +
      theme(axis.title.x = element_text(size = 16)) +
      theme(axis.title.y = element_text(size = 16)) +
      theme(axis.text = element_text(size = 12)) +
      theme(legend.text = element_text(size = 12)) +
      theme(legend.title = element_text(size = 14))
  })
  
  
  # sides compare reactive for datatable
  
  sides_DT <- eventReactive(input$action_side_compare,{
    
    sides%>%
      select(dish, type, energy_kcal_serv, carb_g_serv, fat_g_serv, fibre_g_serv,
             protein_g_serv, salt_g_serv, sat_g_serv, sugars_g_serv) %>%
      filter(dish == input$side1_name | dish == input$side2_name)
    
  })
    

  output$sides_DT <- DT::renderDataTable({
    
     sides_DT()  
    
  })
  

  # pizza compare reactive
  
  pizza1 <- eventReactive(input$action_pizza_compare,{

    pizza_RDA %>%
      filter(name == input$pizza1_name &
             size == input$pizza1_size &
             crust == input$pizza1_crust) %>%
     group_by(Macros) %>%
     summarise(!!input$pizza1_name := Values)
  })
  
 
  pizza2 <- eventReactive(input$action_pizza_compare,{

    pizza_RDA %>%
      filter(name == input$pizza2_name &
             size == input$pizza2_size &
             crust == input$pizza2_crust) %>%
      group_by(Macros) %>%
      summarise(!!input$pizza2_name := Values)
  })

  
  pizza_long <- reactive({
    
    as_tibble(pizza1()) %>%
    left_join(as_tibble(pizza2())) %>%
    pivot_longer(cols = c(input$pizza1_name, input$pizza2_name),
                  names_to = "Pizza",
                  values_to = "Values")
  })


  # pizza compare plot
  
  output$pizza_compare <- renderPlot({

      ggplot(pizza_long()) +
      aes(x = Macros, y = Values, fill = Pizza) +
      geom_col(position = "dodge", col = "white") +
      geom_text(aes(label = paste0(Values, "%")), position = position_dodge(0.9), vjust = 1.5) +
      xlab("\nPizza Types") +
      ylab("RDA (%)\n") +
      ggtitle(paste0("Comparison of a ", input$pizza1_size, " size, ", input$pizza1_crust,
                     ", ", input$pizza1_name, "  VS.  a ", input$pizza2_size, " size, ", 
                     input$pizza2_crust, ", ", input$pizza2_name, " (per serving)\n")) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold")) +
      theme(axis.title.x = element_text(size = 16)) +
      theme(axis.title.y = element_text(size = 16)) +
      theme(axis.text = element_text(size = 12)) +
      theme(legend.text = element_text(size = 12)) +
      theme(legend.title = element_text(size = 14))

  })
  
  # pizza compare reactive for datatable

  pizza1_DT <- eventReactive(input$action_pizza_compare,{
    
    pizza%>%
      select(name, crust, size, energy_kcal_serv, carb_g_serv, fat_g_serv, fibre_g_serv,
             protein_g_serv, salt_g_serv, sat_g_serv, sugars_g_serv) %>%
      filter(name == input$pizza1_name &
               size == input$pizza1_size &
               crust == input$pizza1_crust)
      
  })
  
  pizza2_DT <- eventReactive(input$action_pizza_compare,{
    
    pizza%>%
      select(name, crust, size, energy_kcal_serv, carb_g_serv, fat_g_serv, fibre_g_serv,
             protein_g_serv, salt_g_serv, sat_g_serv, sugars_g_serv) %>%
      filter(name == input$pizza2_name &
               size == input$pizza2_size &
               crust == input$pizza2_crust)
    
  })
  
  output$pizza_compare_DT <- DT::renderDataTable({
    
    pizza1_DT() %>%
      rbind(pizza2_DT())  
    
  })
  
}
