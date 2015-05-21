shinyUI(
  pageWithSidebar(
    # How does a 2015 Automobile compare to a make from 1974 with similar specs?
    headerPanel("How does a 2015 Automobile compare to a make from 1974 with similar specs?"),
    sidebarPanel(
      h3("Description"),
      p("Find the specs for your favorite 2015 automobile at"),
      a("Motor Trend", href = "http://www.motortrend.com/new_cars/specifications/"),
      p("Input the value for number of cylinders, horsepower and weight below. The output to the right gives the
            expected mpg of an automobile with these specifications in 1974. Check back on motor trend for the models
            actual mpg. How much has mpg improved?"),
      radioButtons("cylVal", "Cylinder", c(4, 6, 8)),
      numericInput("hpVal", "HorsePower", 500, min = 0, max = 1000, step = 1),
      numericInput("wtVal", "Weight, lb/1000", 6, min = 0, max = 20, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of Prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which gives 1974 predicted mpg of '),
      verbatimTextOutput("prediction")
    )
  )
)