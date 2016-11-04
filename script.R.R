values <- read.csv("sa_values.txt", header = T, row.names = NULL, sep = "?", stringsAsFactors = F)
issues <- read.csv("sa_issues.txt", header = T, row.names = NULL, sep = "}", stringsAsFactors = F)

value_stop_words <- c("low", "can", "around", "know", "location")
issue_stop_words <- c("sometimes", "end", "people", "safe", "bootleggers", "cove", "lack")
library(tidyverse); library(tm); library(SnowballC); library(wordcloud)

jeopCorpus <- Corpus(VectorSource(values$values))
#jeopCorpus <- Corpus(VectorSource(issues$issues))
jeopCorpus <- tm_map(jeopCorpus, content_transformer(tolower))
jeopCorpus <- tm_map(jeopCorpus, removePunctuation)
jeopCorpus <- tm_map(jeopCorpus, PlainTextDocument)
jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('english'))
#jeopCorpus <- tm_map(jeopCorpus, removeWords, issue_stop_words)
jeopCorpus <- tm_map(jeopCorpus, removeWords, value_stop_words)
#jeopCorpus <- tm_map(jeopCorpus, stemDocument)
wordcloud(jeopCorpus,  scale=c(5,0.2),
          max.words = 50, random.order = FALSE, colors=brewer.pal(8, "Dark2"))

