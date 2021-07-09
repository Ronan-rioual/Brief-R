library(shiny)
library(ggplot2)
library(DT)

# Define UI for app ----
ui <- fluidPage(
  titlePanel('Prédiction du prix des appartements en fonction de la surface'),
  
  sidebarLayout(
    sidebarPanel(
      helpText(h2("Bonjour,")),
      helpText(h4("Bienvenue dans l'interface de Christelle et Ronan
          concernant le Brief R, installez vous comfortablement et profitez 
          de nos fantastiques prédiction sur le Prix des immeubles à Paris,
          en fonction de la superficie du batiment"))
    ),

    mainPanel(
      tabsetPanel(
        tabPanel(
          h3("Tableau"),
          textOutput("selected_var"),
    
          
          # Create a new row for the table.
          DT::dataTableOutput("table")
        ),
        tabPanel(h3("Graphiques"),
          plotOutput("plot")
        ),
        tabPanel(
          h3('prediction'),
          sliderInput(inputId = "squareMeters",
                      label = "Surface (m)",
                      min = 1,
                      max = 100000,
                      value = 50000
          ),
          tableOutput('resultat')
        )
      )
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  
  output$plot <- renderPlot({
    plot(input_data)
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- input_data
  }))
  predictions <- reactive({
    preprocessInput = data.frame(squareMeters = as.integer(input$squareMeters))
    prediction <- preprocessInput*101.64304
    
    data.frame(
      Prediction = as.character(c(paste(round(prediction, digits=2), "€")))
    )
  })
  output$resultat <- renderTable({
    predictions()
  })
}

#Run the app ----
shinyApp(ui = ui, server = server)
