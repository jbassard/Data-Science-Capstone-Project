library(shiny)
if (!require("shinythemes")) {
  install.packages("shinythemes")}
library(shinythemes)

shinyUI(fluidPage( navbarPage(theme = shinytheme("united"), strong("Coursera's Data Science Capstone Project: Word Prediction Algorithm")),
                   sidebarPanel(tags$style(".well {background-color: #01A9DB;}"),
                                h4( HTML("<font color=black><strong>Project Synopsis:</strong></font>")),
                                h4( HTML("<font color=white><b>This application predicts the next probable word using pre-computed N-grams.</b></font>")), 
                                
                                h4(HTML("<font color=white><b>To use this app, simply type-in words inside the text field on the right screen, and probable next word will be automatically displayed.")),
                                h4(HTML("<font color=red><b>This app will try to display up to 10 probable  words when possible.</b></font>")),
                                h4(HTML("<font color=white>For a simple exploration of the prediction capabilities, predicted words can be added to the input by clicking on them.</font>")),
                                h4(HTML("<font color=black>Each tab-panel offers detailed resources related to this app</font>"))
                   ),
                   mainPanel(
                     wellPanel(tags$style(HTML("body {background-color: grey;}")),
                               tabsetPanel(tabPanel("Application",(h2("Input for your sentence:")),
                                                    textInput("InputText", "(Type-in your words or Click on one predicted word from below:)", width = "75%"),
                                                    h3("The top-ranked 1 to 10 predicted words:"),
                                                    uiOutput("words"),
                                                    hr(),    #style = "background-color: black;"
                                                    h5 ("[Please wait for few seconds for the predicted words to appear]"),
                                                    br(),
                                                    wellPanel("This word predictor has been realized to validate the Capstone Project of the Data Science specialization on Coursera in partnership with JHU and Swiftkey")
                                                    
                               ),
                               
                               tabPanel("Project Details",
                                        tags$div(HTML("<font color=black>
                                                      <left><h4>Author: jbassard </h4>
                                                      <h4>Date: March 2018 </h4>
                                                      <hr>
                                                      <left><h4><b>Project Objectives</b> </h4><hr>
                                                      <h5>The main goal of this capstone project is to build a shiny application, which will be able to predict the next probable word.
                                                      This project exercise was divided into several tasks as data cleaning (bad words, punctuation, numbers,...), exploratory analysis, computing N-grams and creating a predictive model.
                                                      All text data used to create the Ngrams comes from a corpus called HC Corpora.
                                                      Every necessary text mining and natural language processing was done with the use of a variety of common R packages.
                                                      </h5>
                                                      <hr>
                                                      <h4><b> Applied Data processing </b> </h4>
                                                      <h5>After creating a sample Corpus from 5% of the original dataset from the HC Corpora data, it has been cleaned by conversion to lowercase, removing punctuation, removing hypertext links, removing white spaces, removing numbers, removing bad words from a list of 1500 words, removing common accronym and internet language, and removing all kinds of special characters.
                                                      Then tokenization has been applied to breaking up a stream of text into words. The list of tokens becomes input for further processing.
                                                      N-grams (unigram, bigram, trigram, fourgram, fivegram) has been computed from the tokens. Each stream of token have been sorted by frequency in the original data</h5> 
                                                      <h5>The prediction model uses these Ngrams to predict the next word in connection with the from the user input text.
                                                      </h5>
                                                      <hr>
                                                      <h4><left><b>Data source: </b></left></h4>
                                                      <h5>The corpus for this model consisted of 3 raw text files from HC Corpora :</h5>
                                                      <ol>
                                                      <li>en_US.blogs.txt</li>
                                                      <li>en_US.news.txt</li>
                                                      <li>en_US.twitter.txt</li>
                                                      </ol>
                                                      
                                                      <h5><b>The dataset has been reduced to 5% of the total and combined into a single file.</b></h5>
                                                      <hr>
                                                      <h4><b>N-Grams have been computed with the tm package:</b></h4>

                                                      <li> Tokenization of the 'Sample Corpus' with TermDocumentMatrix function. </li>
                                                      <li> Convert the tokens in to a matrix.</li>
                                                      <li> Reordering token-terms of the matrix by counting frequency (higher to lower).</li>
                                                      <li> Transforming the matrix into dataframe with token-terms in upward frequency order.</li>
                                                      <li> Separate token-terms as N-gram dataframes named unigram, bigram, trigram, fourgram and
                                                      fivegram in 'Rda' file format. </li>
                                                      <li> These Rda dataframes are loaded by the prediction model.</li>
                                                      <br>
                                                      <h4><left><b>External Data</b> </h4><hr>
                                                      <h5> The App presentation on Rpub : <a href = http://rpubs.com/jbassard/Capstone > http://rpubs.com/jbassard/Capstone</a></h5></center>
                                                      <br>
                                                      <h5> Github link were the app code is stored : <a href= https://github.com/jbassard/Data-Science-Capstone-Project> https://github.com/jbassard/Data-Science-Capstone-Project</a> </h5>
                                                      <h5> Initial presentation on Rpub showing how the original dataset have been processed: <a href = https://rpubs.com/jbassard/365490 > https://rpubs.com/jbassard/365490</a></h5></center>
                                                      <h5> Original Data used to prepare the Ngrams can be found here: <a href = https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip> https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip</a></h5>
                                                    
                                                      </ol></font>"
                                                      
                                        ))),
                               tabPanel("Prediction model building and processes",
                                        tags$div(HTML("<font color=black>
                                                      <left>
                                                      <h4><b> Model Building</b></h4>
                                                      <h5>This prediction model is base on the Markov Chain model and the Katz's Back-Off model.</h5>
                                                      <h5>In Markov Chain model, future state of a variable depends on its neighboring variables in multiple directions with which it is connected.
                                                      Thus, N-gram words combinations (bigram, trigram, fourgram and fivegram) are used to determine the most probable next word of a sting of words using this Markov Chain principle.</h5>
                                                      <h5>Katz's back-off model is a progressive N-gram language model. If no words are predictable from a certain Ngram level, it backing-off iteratively to a lower Ngram level until some words are predictable.</h5>
                                                      <br>
                                                      <h4><b>Prediction model processes</b></h4>
                                                      <ol>
                                                      <li><h5> Receive user word input through the input text box. </h5>
                                                      <li><h5> Initial processing for basic text cleaning with 'tm' R-package,</h5></li>
                                                      <li><h5> Sequential implementation of bigram, trigram, fourgram, and fivegram models with every addition
                                                      of newer input word.</h5></li> 
                                                      <li><h5> If no matching is found, the Back-Off model will search back to lower level N-grams </h5></li></ol>
                                                      <li><h5> Not every input combination matching will produce 10 predicted words.<h5></li>
                                                      <li><h5> Next word prediction choices are based on corresponding Ngrams frequencies in the 'sample corpus'.
                                                      Since the 'Sample Corpus' represents only 5% of the original data set, the predicted next word choices
                                                      may not be truly representative of the whole corpus or random user inputs.<h5></li>
                                                      "))) 
                                        ) )
                               ) 
                                        )
                               ) # shinyUI closing