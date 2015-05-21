data(mtcars)
data <- mtcars
data$cyl <- factor(data$cyl)
reg <- lm(mpg ~ wt + cyl + hp, data = data)

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({c(input$cylVal, input$hpVal, input$wtVal)})
    output$prediction <- renderPrint({
      newData <- data.frame("cyl" = factor(input$cylVal), "hp" = as.numeric(input$hpVal), 
                              "wt" = as.numeric(input$wtVal))
      predict(reg, newData)
    })
  }
)