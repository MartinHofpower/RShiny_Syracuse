# Application: "Collatz-Problem" - UI
# Version: 1.1.0
# Author: Martin Hofbauer
# Contact: martin@hofeder.solutions

library(shiny)
library(bslib)

# Define UI:
shinyUI(navbarPage(
    theme=bs_theme(version=4, bootswatch="spacelab", font_scale=0.8),
    footer=tags$small('V 1.1.0'), 
    
    # Application title
    title="Collatz-Problem",
    
    # First tab:
    tabPanel('Erläuterung des Problems', 
    wellPanel(
        p('Das Collatz-Problem, oft auch als (3n+1)-Vermutung oder syracuse-conjecture bekannt, beschreibt eines der am leichtesten zu verstehenden, aber trotzdem ungelösten Problemen der Mathematik. 
           Der berühmte Mathematiker Paul Erdos soll einmal resümiert haben "Mathematics is not ready for such problems". 
           Aber was macht das Problem so besonders und wie kann man es formulieren?'),
        h4('Formulierung des Problems'),
        p('Zu Beginn wählt man eine natürliche Zahl n. Nun wiederholt man immer wieder das gleiche (iterative) Muster:'),
        tags$ul('Ist die aktuelle Zahl eine ungerade Zahl, so wird sie mit 3 multipliziert und anschließend mit 1 addiert.'),
        tags$ul('Ist die Zahl eine gerade Zahl, so wird sie durch 2 geteilt.'),
        p('Auf den ersten Blick ist es überraschend, dass diese Folge nicht automatisch immmer größer wird und divergiert. 
           Bei genauerer Betrachtung jedoch wird klar, dass nach einer ungeraden Zahl nach diesem Schema immer eine gerade Zahl und somit eine nachfolgende Halbierung folgt. 
           Dadurch entstehen nicht-triviale Verläufe, die (scheinbar) immer bei 1 enden.'),
        h4('Ein Beispiel'),
        p('Startet man etwa mit 13, so erhält man die Folge '),
        tags$ul('13, 40, 20, 10, 5, 16, 8, 4, 2, 1'),
        p('Für 28 erhält man '),
        tags$ul('28, 14, 7, 22, 11 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1'),
        p('Bei der Zahl 1 würde es mit dem Zyklus "1, 4, 2, 1, 4, 2, 1, ..." weitergehen. 
           Daher ist diese Zahl als Endpunkt der Folge definiert.'),
        h4('Das Problem'),
        p('Besser gesagt die Probleme: es sind nämlich zwei Teilprobleme, die für diesen Algorithmus noch nicht gelöst sind. 
           Die Vermutung liegt nahe, dass jede so konstruierte Zahlenfolge in dem Zyklus "4, 2, 1" terminiert. 
           Ebendiese Vermutung ist jedoch nicht bewiesen. Wie für viele andere ungelöste Probleme der Mathematik sind auch in diesem Fall hohe Preisgelder für einen Beweis der Richtigkeit oder ein Gegenbeispiel und somit den Beweis des Gegenteils ausgeschrieben.'),
        p('Sollte es tatsächlich möglich sein ein Gegenbeispiel zu finden, stellt sich zusätzlich die Frage, ob es eine Zahlenfolge ist, die divergiert, also immer größer wird, oder ob vielleicht ein weiterer Zyklus, analog zu "4, 2, 1" existiert. ') 
        ),
    wellPanel(
        h4('Kontakt'),
        p("Martin Hofbauer", br("Mail: ", a("martin@hofeder.solutions"), 
                             br("Web: ", a("www.hofeder.solutions/martin"))))
    )
    ),
    # Second tab:
    tabPanel("Visualisierung von Pfaden",
    wellPanel(h4('Was kann hier visualisiert werden?'),
              p('Dieser Bereich dient der Visualisierung einer Zahlenfolge nach dem Schema von Collatz als Pfad ausgehend von einer beliebigen Startnummer und soll zum Ausprobieren und Nachdenken einladen.'),
              p('Die Visualisierung findet dabei einerseits klassisch linear statt, andererseits auch logarithmisch, da für große Werte eine logarithmierte y-Achse oft informativer ist.')),
    # Sidebar:
    sidebarLayout(
        sidebarPanel(
            h4('Wählen Sie die Startnummer*:'),
            tags$small('*Aus Gründen der Performance ist die Eingabe auf 20 Stellen limitiert.'),
            numericInput(inputId='StartingNumber',
                         label=NULL,
                         value=4,
                         min=1, max=10^20, step=1),
            tags$hr(),
            textOutput('StepCount'),
            tags$hr(),
            fluidRow(
                column(12, align='center',
                    tableOutput('Table')
                )
            )
            
        ),
        # Main:
        mainPanel(
            # Einbau eines Switches ob Darstellung linear oder logarithmisch erfolgen soll
            h4('Ergebnis als Graph:'),
            plotOutput('Plot', height='500px'), 
            h4('Ergebnis als logarithmischer Graph:'), 
            plotOutput('PlotLog', height='500px')
        )
    ))
))
