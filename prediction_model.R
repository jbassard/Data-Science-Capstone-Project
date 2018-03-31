#This helper file contains the diverse functions necessary to run the Shiny application (from loading the data, to cleaning the user inputs and running predictions).

## Checking for required package and install it if necessary, then load it
if (!require("tm")) {
  install.packages("tm")}

library(tm) #use for text mining

gc() ## use garbage collector to be sure to have no RAM already used by R since further files might use a lot of RAM


## Reading N-gram 'Rda' data-frame files prepared peviously
unigram <- readRDS(file = "~/CapstoneProject/unigram.Rda")
bigram <- readRDS(file = "~/CapstoneProject/bigram.Rda")
trigram <- readRDS(file = "~/CapstoneProject/trigram.Rda")
fourgram <- readRDS(file = "~/CapstoneProject/fourgram.Rda")
fivegram <- readRDS(file = "~/CapstoneProject/fivegram.Rda")

#---------------------------------------------------------
## Defining the prediction function
#---------------------------------------------------------
Predict.Next.Word <- function(Text.Input) {
  
  if(nchar(Text.Input) > 0) {
    
    # Cleaning user Inputs (remove capital letters, punctuation, numbers, ...) To keep this app quick and light, I do not remove "bad" words from the user input.
    Text.Input <- tolower(Text.Input)
    Text.Input <- removePunctuation(Text.Input)
    Text.Input <- removeNumbers(Text.Input)
    Text.Input <- stripWhitespace(Text.Input)
    
    # Splitting input strings and turned them into vectors
    InputObject <- unlist(strsplit(Text.Input, split =  " "))
    
    # Getting the length of each input vector
    Word.Count <- length(InputObject)
    
    
    #---------------------------------------------------------
    # Defining some functions for text analysis
    #---------------------------------------------------------

    # Bigram function
    Use.Bigram <- function(words)
    {
      bigram[bigram$string$one == words,]$string$two
    }
    
    # Trigram function
    Use.Trigram <- function(words)
    {
      trigram[trigram$string$one == words[1] &
                trigram$string$two == words[2],]$string$three
    }
    
    # Fourgram function
    Use.Fourgram <- function(words)
    {
      fourgram[ fourgram$string$one == words[1] &
                  fourgram$string$two == words[2] &
                  fourgram$string$three == words[3],]$string$four
    }
    
    # Fivegram function 
    Use.Fivegram <- function(words)
    {
      fivegram[ fivegram$string$one == words[1] & 
                  fivegram$string$two == words[2] &
                  fivegram$string$three == words[3] &
                  fivegram$string$four == words[4],]$string$five
    }
    
    
    #-----------------------------------------------------------
    # Using defined Ngram-function to predict the next word
    #-----------------------------------------------------------    
    #---------------------------------------
    # Description of the Back-Off Algorithm
    #---------------------------------------
    # To predict the next word of the user specified sentence, four example with a fourgram:
    # 1. first we use a FourGram; the first three words of which are the last three words of the user provided sentence
    #    for which we are trying to predict the next word. The FourGram is already sorted from highest to lowest frequency
    # 2. If no FourGram is found, we back-off to TriGram (first two words of ThreeGram last two words of the sentence)
    # 3. If no triGram is found, we back-off to biGram (first word of TwoGram last word of the sentence)
    # 4. If no biGram is found, we back-off to uniGram (the 10 most common words with highest frequency)
    #
    
    # if the input is only a single word use the bigram function
        if(Word.Count == 1) 
    {
      predicted.Words <- Use.Bigram(InputObject[1])
    }    
    
    # if the input is 2 words use the trigram function
    else if (Word.Count == 2)
    {
      word1 <- InputObject[1]
      word2 <- InputObject[2]
      predicted.Words <- Use.Trigram(c(word1, word2))
      
      if(length(predicted.Words) == 0)
      {
        # if trigram function fails, find bigram
        predicted.Words <- Use.Bigram(word2)
      }
      if(length(predicted.Words) == 0)
      {
        # if bigram function fails, find unigram
        predicted.Words <- unigram$string
      }
    }
    
    # if the input is 3 words use the fourgram function
    else if (Word.Count == 3)
    {
      word1 <- InputObject[Word.Count-2]
      word2 <- InputObject[Word.Count-1]
      word3 <- InputObject[Word.Count]
      predicted.Words <- Use.Fourgram(c(word1, word2, word3)) 
      
      if(length(predicted.Words) == 0)
      {
        # if fourgram function fails find trigram
        predicted.Words <- Use.Trigram(c(word2,word3))
      }
      if(length(predicted.Words) == 0)
      {
        # if trigram function fails find bigram
        predicted.Words <- Use.Bigram(word3)
      }
      if(length(predicted.Words) == 0)
      {
        # if bigram function fails, find unigram
        predicted.Words <- unigram$string
      }
    } 
    
    # if the input is 4 words use the fivegram function
    else {   
      word1 <- InputObject[Word.Count-3]
      word2 <- InputObject[Word.Count-2]
      word3 <- InputObject[Word.Count-1]
      word4 <- InputObject[Word.Count]
      predicted.Words <- Use.Fivegram(c(word1, word2, word3, word4))
      

      if(length(predicted.Words) == 0)
      {
        # if fivegram function fails, find fourgram
        predicted.Words <- Use.Fourgram(c(word2,word3,word4))
      }
       if(length(predicted.Words) == 0)
      {
        # if fourgram function fails, run trigram function
        predicted.Words <- Use.Trigram(word3,word4)
      }  
      if(length(predicted.Words) == 0)
      {
        # if trigram function fails, run bigram function
        predicted.Words <- Use.Bigram(word4)
      }
      if(length(predicted.Words) == 0)
      {
        # if bigram function fails, find unigram
        predicted.Words <- unigram$string
      }
    }
    
    
    #---------------------------------------------------------
    # Returning up to top 10 predicted words
    #---------------------------------------------------------
    k <- 10
    pw <- length(predicted.Words)
    if( pw >= k)
    {
      predicted.Words <- predicted.Words[1:k]
    }
    as.character(predicted.Words)
  }else{ "" }
  
}