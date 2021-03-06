Data Science Project Presentation
========================================================
author: jbassard
font-family:'Risque'
date: March 2018
transition: zoom
transition-speed: slow
navigation: section
autosize: true

<font size="6" color="black"> 
>Final project of Data Science Specialization at Coursera in partnership with JHU and SwiftKey</font>


<font size="3" color="black"> 
> This R-based presentation will briefly but comprehensively pitch a Shiny-application for predicting the next word of a sentence. 
> </font>

Project Overview
========================================================
type: section
font-family: 'Helvetica'
<font size="3" color="white">
- **This project is part of the Data Science Specialization on Coursera. It is the Capstone project where the main objective is to develop a data science work.**

- The final goal is to create a Shiny-application that predicts next word based on an user input sentence.
- **The application is available at [Shiny] (https://jbassard.shinyapps.io/predict/).**
- This exercise was divided into several sub-tasks like data cleaning, data exploratory analysis, creation of a predictive model and more.
- For the analysis and exploration of data, application of natural language processing (NLP) and text mining concepts was necessary and done using common R-packages.

Source Data used to create a frequency dictionary and thus to predict the next words comes from publicly available [HC Corpora] (https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) (English texts from News, Tweets and Blogs, total of about 2.4 million records).
</font>

Prediction Algorithm building
========================================================
type: prompt
font-family: 'Risque'
<font size="2" color="black">
- N-Grams [Markov Model] (https://en.wikipedia.org/wiki/Markov_model) and [Katz's back-off model] (https://en.wikipedia.org/wiki/Katz%27s_back-off_model) were used for this prediction algorithm to predict the next word in connection with the user text input of the described application and the frequencies of the underlying Ngrams tables. The modeling process used a large set of data so it was pre-computed with R. This batch process created a much smaller dataset to be used in the Shiny-application for fast real-time performance.</font>
<font size="2" color="black">
- The prediction model uses text documents collected from blogs, news articles, and twitter to statistically model language patterns.These data have been combined and reduce to 5% of their total size via a random selection of sentences to build a Sample Corpus. The Sample Corpus has been cleaned (remove numbers, hypertext links, punctuations, bad words, lowercase...) using 'TM' R-package. Then the data have been tokenized in Ngrams (Unigrams, Bigrams, Trigrams, Fourgrams and Fivegrams) which have been ordered by frequencies.Low frequency Ngrams (below 2) were reduce computation time of the Shiny-application.</font> <font size="2" color="Blue">The picture below shows the whole workflow: </font>

![Presentation](Presentation.png)


The Shiny-application
========================================================
type: sub-section
font-family: 'Risque'
<font size="4" color="black">
The Word Predict App is simple and easy to use, yet powerful!

(1) Simply start typing on the text input field and (2) up to 10 possible next words will automatically be displayed below this field.
Then (3), you can click on one predicted word to add it in the input for next words to be predicted and so on. See the screenshot below of the main appplication panel.
</font>

![Screenshot](presentation2.png)

<font size="3" color="black">The application also briefly presents the project and the building of the prediction model.</font>


Conclusions
========================================================
type: sub-section
<font size="3" color="black">
The complexity of this capstone project is rather challenging in comparison to other exercises of this Data Science Specializatoin. This project and the Data Science Program were interesting and I learned a lot from this project.

This project only scratches the surface of natural language processing and predictive analytics applications. There are many possibilities for improvement including:
- More data sources (such as books...)
- My sampled-dataset needs more validation approach to evaluate it's true representation.
- Parallel processing of data to increase volume and speed for the application (Shiny application beeing limited to 100 Mb)
- Feedback loop into the model (e.g.learn from what predictions users accept)
- Current algorithm discards contextual information past 5-grams

</font>
<font size="3" color="grey"> There is sometimes an error mentioning "An error has occurred. Check your logs or contact the app author for clarification" following a long user inputs (code to improve). I was not able to identify and correct this error since no error appears in Rstudio where the code has been written. It might be a limitation from Shiny-app.

</font>
