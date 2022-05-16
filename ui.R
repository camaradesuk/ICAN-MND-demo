

header <- dashboardHeader(title = "ICAN-MND")

dashboardSidebar <- dashboardSidebar(sidebarMenu(
  menuItem("Home",
           tabName = "home",
           icon = icon("home")),
  menuItem(
    "Candidate drugs",
    tabName = "drugs",
    icon = icon("tablets"))
))


body <- dashboardBody(
  h2("DISCLAIMER: THIS IS A DEMO VERSION"),
  tabItems(
    tabItem(
      tabName = "home",
      fluidRow(box(width = 12, 
                   
                   h2("Integrated Candidate Drug List for MND Trials"),
                   h4("Aim"),
                   p("We aim to use data from different domains, namely data from (i) Repurposing Living Systematic Review-Motor Neuron Disease (ReLiSyR-MND), (ii) in vitro drug screening, (iii) pathway / network analysis and  (iv) expert opinion to identify and prioritise candidate drugs for further evaluation."),
                   p("Using the accumulating evidence from different data streams, we will inform expert panel discussions as they group drugs into:"),
                   tags$li("Group 1: For evaluation in clinical trial"),
                   tags$li("Group 2: For further evidence generation and synthesis"),
                   tags$li("Group 3: Not for further consideration"),
                   img(src = "drug selection framework lay slide.png", height = 500, align = "center")))
      


      
    ),
    tabItem(
      tabName = "drugs",
      fluidRow(
        box(width = 12,
            h4("Identifying candidate drugs"),
            p("We identify candidate drugs meeting selection criteria from each data domain, and categorise drugs based on increasingly selective subsets to aid prioritisation of drugs for further evaluation."),
            p("This section visualises the candidate drugs and the categories / subset they fulfill. To use this, select the categories of interest using the checkbox below (minimum one required) and the corresponding Euler diagram will be shown below; intersecting drugs in the selected categories will be shown in the table (csv of the table can be downloaded by clicking the download csv button).")
            
            
      )),
      fluidRow(
        box(width = 3,
            checkboxGroupInput("category", "Categories: (select at least one)",
                               c("in vitro Drug screening libraries" = "drugScreenLib",
                                 "Drug screening libraries: BBB permeable" = "BBBPermeable",
                                 "Drug screening libraries: Protein aggregation hits" = "proteinAggregation",
                                 "Drug screening libraries: Astrocyte MCB hits" = "MCBPositiveHit",
                                 "ReLiSyR: included publications" = "relisyr_list",
                                 "ReLiSyR: Meets drug disease logic" = "MNDLogic",
                                 "ReLiSyR: longlist" = "longlist",
                                 "Pathway analysis: WGCNA predictions" = "WGCNApredictions", 
                                 "Listed in BNF" = "BNF"
                                 ),
                               selected = "drugScreenLib"))

      ),
      fluidRow(
      box(width=12,
          plotOutput("euler"))),
      
      
      fluidRow(
        
        
        h3("Intersecting drugs in selected categories"),
        DT::dataTableOutput("table")%>% withSpinner(color="#0dc5c1"),
        downloadButton("downloadTable", label = "Download csv")
      )
      
    )
    
    
  )
  
  
)

shinyUI(dashboardPage(
  header,
  dashboardSidebar,
  body))





