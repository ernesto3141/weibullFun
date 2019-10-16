library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)

fda<-function(x,shape,scale,thres){
  prop = 1-(exp(-(((x)/scale)^(shape))))
  prop
}
bins<-seq(7.5,75, by=5)
bins10a<-seq(7.5,125, by=5);length(bins10a)
bins10b<-seq(12.5,130, by=5);length(bins10b)
xxlim<-dput(factor(seq(10,120,5)))

nadf <- data.frame(claseA = bins10a, claseB = bins10b)
nadf$clasesL <- paste(nadf$claseA,"-",nadf$claseB, sep = "")
nadf$clases <- dput(factor(seq(10,125,5)))

shinyServer(function(input,output){
  selectedData1 <- reactive({
    nadf[, c("claseB","claseA","clases")]
  })
  shapeReact <- reactive({3.3053+input$dmean*0.2878+input$dmx*-0.1498})
  scaleReact <- reactive({-0.03754+input$dmean*1.02484+input$dmx*0.04672})
  prop <- reactive({
    fda(selectedData1()$claseB, shapeReact(), scaleReact(), thres = 7.2)-fda(selectedData1()$claseA, shapeReact(), scaleReact(), thres = 7.2)
  })
  dataff<-reactive({
    data.frame(clases = selectedData1()$clases, prop = prop(), naha = round(prop()*input$psize))
  })
  output$plot1 <- renderPlot({
    p = ggplot(dataff(),aes(dataff()$clases,dataff()$naha,group=1))+
      ggtitle("Diametric Distribution")+
      ylab("Number of trees per hectare")+
      xlab("Diameter Class (cm)")+
      geom_bar(stat="identity")+
      xlim(c("10", "15", "20", "25", "30", "35",
             "40", "45", "50","60"))+
      theme_classic()+
      theme(axis.text.x = element_text(size=14),
            axis.text.y = element_text(size=14))+
      theme(
        plot.title = element_text(size=18),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14)
      )
    p
  })
  tableOne<-reactive({
    data.frame(Class = selectedData1()$clases, proportion = round(prop(),3), Naha = round(prop()*input$psize))
  })
  output$mytable = DT::renderDataTable({
    tableOne()
  },rownames = FALSE, filter = 'bottom', options = list(searchHighlight = TRUE,
    initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
      "}")
  ))
})