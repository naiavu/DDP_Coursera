library(shiny)
shinyUI(pageWithSidebar(
    
    headerPanel("Body Mass Index (BMI) Calculator"),
    sidebarPanel(
        h5('Please check measurement unit, then select your height and weight:'),
       
        radioButtons("heightUnit","",c("m"="m","feet"="f")),
        conditionalPanel(
            condition = "input.heightUnit == 'm'",
            sliderInput('height', 'Height (m)',value = 1, min = 1, max = 2, step = 0.01)
        ),  
        conditionalPanel(
            condition = "input.heightUnit == 'f'",
            sliderInput('heightFeet', 'Height (feet)',value = 4, min = 4, max = 7, step = 1),
            sliderInput('heightInch', 'Height (inches)',value = 0, min = 0, max = 11, step = 0.5)
        ),
       
        radioButtons("weightUnit","",c("kg"="kg","pounds"="pounds")),
        conditionalPanel(
            condition = "input.weightUnit == 'kg'",
            sliderInput('weight', 'Weight (kg)',value = 22, min = 22, max = 150, step = 1)
        ),  
        conditionalPanel(
            condition = "input.weightUnit == 'pounds'",
            sliderInput('weightPounds', 'Weight (pounds)',value = 50, min = 50, max = 330, step = 1)
        )
    ),
    mainPanel(
        tabsetPanel(id="tabs",
                    tabPanel("Result", value="result", 
                              h3('Your BMI:'),
                              textOutput('bmi'),
                              h3('Category:'),
                              textOutput('result')),
                    tabPanel("Documentation", value="Table",     
                              h3('Instructions'),
                              p('Select measurement unit for height and weight using radiobuttons'),
                              p('Use the top slider to indicate your height (meters or feet and inches)'),
                              p('Use the bottom slider to indicate your weight (kilos or pounds)'),
                              p('Result tab shows your BMI and the BMI category you currently belong to'),
                              h3('Metric BMI Formula'),
                              p('BMI = ( Weight in Kilograms / ( Height in Meters x Height in Meters ))'),
                              helpText('Conversion to Imperial system: 1 kg = 2.204 pounds, 1 inch = 0.0254 m'),
                              h3('BMI Categories'),
                              p('Underweight: BMI < 18.5'),
                              p('Normal weight: BMI is in the range 18.5 - 24.9'),    
                              p('Overweight: BMI is in the range 25 - 29.9'),
                              p('Obese: BMI >= 30')
                              
                            # Had to remove the reference below: while it is working with <Run App> in RStudio, it doesn't work on shiny server for some reason
                            # h4("Reference:", a("CDC", href="http://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html?s_cid=tw_ob064"))
                     ) 
        )   
    )
))