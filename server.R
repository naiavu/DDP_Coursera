library(shiny)

poundsToKilos <<- 2.204  # 1 kg = 2.204 pounds
inchesToMeters <<- 0.0254 # 1 inches = 0.0254 m

# Metric BMI formula where weight is in kg, and height is in meters
calculateBMI <- function(w,h) w/(h^2)  
# Check the measurement units and convert to metric if it is imperial system 
calculate <- function(wUnit,hUnit,hFeet,hInch,wPound,h,w){ 
    wConv <<- w
    hConv <<- h
    if(wUnit=='pounds'){ 
        wConv <<- wPound/poundsToKilos 
    }
    if(hUnit=='f'){
        hConv <<- (hFeet*12+hInch)*inchesToMeters
    }
    calculateBMI(wConv,hConv)
}

shinyServer(
    function(input, output){
        
        bmiVal <- reactive({calculate(input$weightUnit,input$heightUnit,as.numeric(input$heightFeet),as.numeric(input$heightInch),input$weightPounds,input$height,input$weight)}) 
        output$bmi <- renderText({bmiVal()})
        
        # Assign BMI category according to calculation result
        observe({
            bmi <- bmiVal()
            
            if(bmi>=30)
                output$result <- renderText('Obese')
            else if(bmi>=25)
                output$result <- renderText('Overweight')
            else if(bmi>=18.5)
                output$result <- renderText('Normal weight')
            else
                output$result <- renderText('Underweight')
          
        })
        
    }  
)