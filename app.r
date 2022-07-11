###---------------------------------------------------------------------------------------------------------------
###############Packages##################
#load packages
pacman::p_load(shiny,DT,plotly,ggplot2,leaflet,shinycssloaders)

###---------------------------------------------------------------------------------------------------------------


loading_icon = 
   
   function (output){
      
      shinycssloaders::withSpinner(output,color="#00ad93", size=3)
      
   }





   ###---------------------------------------------------------------------------------------------------------------
#Initialises the dashboard

ui<- fluidPage(
   title = "Dashboard template",
   tags$head(
      includeCSS("www/my_theme.css"),
      includeCSS("www/styles.css")
      
   ),
   
   div(tags$a(class = "logo",
              title = "DHSC logo",
              tags$img(src = "logo.jpg",
                       alt = "DHSC")),
       tags$h4(class = "header-statement",
               HTML("Suggest a subtitle for your app<br><br>"))
   ),
   tabsetPanel(
      shiny::navbarMenu("Start",
                        shiny::tabPanel("Landing Page",
                                        mainPanel(width=9,
                                                  HTML("<br><br><br>"),
                                                  includeMarkdown("www/landing_page.md"),
                                                  fluid=FALSE)
                        )),
      
      
      ###---------------------------------------------------------------------------------------------------------------
      #This is the code for the second tab
      shiny::navbarMenu(
         "Basic plot and data table",#Name of the tab
         
         shiny::tabPanel(
            "Plot and Table",#This is what appears in the dropdown. If you update this, make sure to update tab_descriptions.r
            
            shiny::navlistPanel(
               shiny::tabPanel(title = "Slider Plot",
                               # Sidebar with a slider input for number of bins 
                               
                               sidebarPanel(
                                  sliderInput("bins",
                                              "Number of bins:",
                                              min = 1,
                                              max = 50,
                                              value = 30)
                               ),
                               
                               # Show a plot of the generated distribution
                               mainPanel(
                                  loading_icon(plotOutput("distPlot"))
                               )
               ),
               
               
               tabPanel(title = "Table with download",
                        loading_icon(DT::dataTableOutput("cars")))# This renders a table of data with download buttons
               
            ))#tabPanel close
         
         
         
         
         
      ),
      
      ###---------------------------------------------------------------------------------------------------------------
      #This is the code for the 3rd tab
      
      navbarMenu(
         "Plotly and Leaflet",
         
         tabPanel(
            "Plotly",#If you update this, make sure to update tab_descriptions.r
            
            navlistPanel(
               
               tabPanel(title = "Example of a plotly plot",
                        loading_icon(plotly::plotlyOutput("iris")))
               
            )),#tabPanel close
         
         tabPanel(
            "Leaflet",#If you update this, make sure to update tab_descriptions.r
            
            navlistPanel(
               tabPanel(title = "Example of a leaflet map",
                        loading_icon(leaflet::leafletOutput("beer")))
               
            ))#tabPanel close
         
         
         
      )
   ),
   
   div(tags$footer(class="footer")),
   
)
   


################## Plots #############################################################################################

server <- function(input, output) {
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   
   
   output$cars <-DT::renderDataTable(
      DT::datatable(mtcars ,
                    
                    extensions = 'Buttons',
                    
                    options = list(
                       dom = 'Brflit',
                       paging = FALSE,
                       searching = TRUE,
                       fixedColumns = TRUE,
                       autoWidth = TRUE,
                       ordering = TRUE,
                       buttons = c('copy', 'csv', 'excel')
                    ),
                    
                    class = "display")
      
   )
   
   
   output$iris <- plotly::renderPlotly(
      
      plotly::ggplotly(
         ggplot2::ggplot(iris,aes(x=Sepal.Width,y=Sepal.Length))+
            geom_point(),
         tooltip = c("x","y"))
      
   )
   
   
   output$beer <- leaflet::renderLeaflet(
      
      leaflet::breweries91%>%
         leaflet::leaflet()%>%
         leaflet::addTiles()%>%
         leaflet::addCircleMarkers(clusterOptions = markerClusterOptions())%>%
         leaflet::addScaleBar()%>%
         leaflet::addControl("Map of brewery locations", position = "bottomleft")
      
   )


   
   ##end of server code
}

# Run the application 
shinyApp(ui = ui, server = server)
