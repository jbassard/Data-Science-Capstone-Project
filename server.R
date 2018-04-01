library(shiny)
if (!require("shinythemes")) {
  install.packages("shinythemes")}
library(shinythemes)

source("prediction_model.R", local = TRUE)

#----------------------------------
# Designing shiny-server functions
#----------------------------------
shinyServer(
  function(input, output, session)
  { # Using "reactive function" as input-word changes
    Word.Prediction <- reactive({
      Predict.Next.Word(input$InputText)
    })
    
    # Making reactive version of output(HTML) using ShinyUI library
    output$words <- renderUI({
      Words.predicted <- Word.Prediction()
      
      # Assigning "predicted-output-text" values to 'WordAssigned' with a "global-environment" on user-space
      assign('AssignedWords', Words.predicted, envir= globalenv()) 
      
      # Counting predicted words and matching character conditions
      k <- length(Words.predicted)       
      if( k >= 0 && nchar(Words.predicted) > 0 )
        
        #-------------------------------------- 
      {  # Displaying words inside a button, on user-space
        buttons <- list()
        for(i in 1:k) 
        { buttons <- list(buttons, list(
          actionButton(inputId = paste("word",i, sep = ""), label = Words.predicted[i])))
        }
        # listing the buttons in a tag-list
        tagList( buttons )
      } else { tagList("") }     
    })
    
    #------------------------------------------------------------------------------------------------------
    # selecting words from buttons instead of typing new words in the input-box
    #------------------------------------------------------------------------------------------------------
    
    # when first output is selected from button output
    
    observeEvent(input$word1, { updateTextInput(session, "InputText", value = paste(input$InputText,
                                                                                    get('AssignedWords', envir=globalenv())[1]))
    })
    
    # when second output is selected
    observeEvent(input$word2, { updateTextInput(session, "InputText", value = paste(input$InputText,
                                                                                    get('AssignedWords', envir=globalenv())[2]))
    })
    
    # when third output is selected
    observeEvent(input$word3, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[3]))
    })
    
    # when fourth output is selected
    observeEvent(input$word4, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[4]))
    })
    
    # when fifth output is selected
    observeEvent(input$word5, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[5]))
    })
    
    # when sixth output is selected
    observeEvent(input$word6, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[6]))
    })
    
    # when seventh output is selected
    observeEvent(input$word7, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[7]))
    })
    
    # when eighth output is selected
    observeEvent(input$word8, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[8]))
    })
    
    # when nineth output is selected
    observeEvent(input$word9, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[9]))
    })
    
    # when tenth output is selected
    observeEvent(input$word10, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                    get('AssignedWords', envir=globalenv())[10]))
    })
    
  }) # End of shiny server function