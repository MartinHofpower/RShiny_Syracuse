# Application: "Collatz-Problem" - SERVER
# Version: 1.1.0
# Author: Martin Hofbauer
# Contact: martin@hofeder.solutions

library(shiny)
library(ggplot2)
library(stringr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Function to execute sequence:
    create_syracuse <- function(StartingNumber){
        if(is.na(StartingNumber)){
            StartingNumber <- 2
        }
        syracuse <- data.frame('Step'=0,
                               'Value'=StartingNumber)
        stop_condition <- FALSE
        while(!stop_condition){
            n_row <- nrow(syracuse)
            current_value <- syracuse[n_row,2]
            if( str_extract(current_value, "\\d$") %in% c(1,3,5,7,9)){ # odd number
                syracuse[n_row+1, ] <- c(n_row, 3*current_value + 1)
            }
            else{ # even number 
                syracuse[n_row+1, ] <- c(n_row, current_value / 2)
            }
            # check stop condition
            if(current_value==2){
                stop_condition <- TRUE
            }
        }
        return(syracuse)
    }
    
    # Create plot in UI:
    output$Plot <- renderPlot({
        # Create df with steps and values 
        df <- create_syracuse(input$StartingNumber)
        # Print result of necessary steps:
        output$StepCount <- renderText({
            paste0("Notwendige Schritte bis Algorithmus terminiert: ", max(df$Step))
        })
        # Print table:
        output$Table <- renderTable({
            create_syracuse(input$StartingNumber)
        },
        align='c', digits=0)
        # Show extra-plot (log):
        output$PlotLog <- renderPlot({
            ggplot(data=df, aes(x=Step, y=Value)) +
                scale_x_continuous(name='Steps', 
                                   limits=c(0, max(df$Step)+2)) +
                scale_y_log10(name='Value', 
                              limits=c(1, max(df$Value))) +
                geom_line(color='dodgerblue1') +
                geom_point(color='dodgerblue4') #+
            # geom_vline(xintercept=max(df$Step), color='navy')
        })
        # Plot result
        ggplot(data=df, aes(x=Step, y=Value)) +
            scale_x_continuous(name='Steps', 
                               limits=c(0, max(df$Step)+2)) +
            scale_y_continuous(name='Value', 
                               limits=c(1, max(df$Value))) +
            geom_line(color='dodgerblue1') +
            geom_point(color='dodgerblue4') #+
            # geom_vline(xintercept=max(df$Step), color='navy')
    })
})
