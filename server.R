


shinyServer(function(input, output, session) {
  
  showModal(modalDialog(
    title="Disclaimer: This is a demo version."
  ))
  #candidate drug tab ------
  #read file
  allDrugs<-read.csv("demoAllDrugListCAS.csv")
  allDrugs<-allDrugs%>%
    rename(BBBPermeable = CNSPenetrance)%>%
    rename(p_BBBPermeability = p_CNSPenetrance)
  
  
  #euler chart filter by input categories
  filteredEulerDF<-reactive({
    df<-allDrugs%>%
      mutate(BBBPermeable = ifelse(is.na(BBBPermeable), FALSE, BBBPermeable))%>%
      select(input$category)
    return(df)
  })
  
  #data frame for table of filtered drugs based on input categories
  filteredDrugsDF<-reactive({
    df<-allDrugs%>%
      select(Name, input$category)%>%
      filter(if_all(is.logical), TRUE)%>%
      select(Name)
    
    df2<-left_join(df, allDrugs)%>%
      distinct()
    
    return(df2)
    
    
  })
  
  output$euler<-renderPlot({
    plot<- plot(euler(filteredEulerDF()), quantities = TRUE, shape = "ellipse")
    plot
  })
  
  output$table<-DT::renderDataTable(filteredDrugsDF(), extensions = "Responsive")
  
  output$downloadTable<- downloadHandler(
    filename = function() { 
      paste(Sys.Date(), "DrugsSelectedGroups", ".csv", sep="")},
    content = function(file){
      write.csv(filteredDrugsDF(), file, row.names = FALSE)
    }
  )
  
})


