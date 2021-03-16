# se estiver rodando no Mac, rode este comando antes
# de iniciar o script
# Sys.setenv(NOAWT=TRUE)

library(tm)
library(Snowball)

# carga do corpus
load("../data/protesto.rda")
myCorpus <- Corpus(VectorSource(df$text))
inspect(myCorpus[1:3])

# transformacoes
# removendo acentos
myCorpus <- tm_map(myCorpus, function(x) iconv(x,to="ASCII//TRANSLIT"))
# convertendo tudo para caixa baixa
myCorpus <- tm_map(myCorpus, tolower)
# removendo pontuacao
myCorpus <- tm_map(myCorpus, removePunctuation)
# removendo numeros
myCorpus <- tm_map(myCorpus, removeNumbers)
# removendo stop-words da lingua portuguesa
myCorpus <- tm_map(myCorpus, removeWords, stopwords('portuguese'))
myCorpus <- tm_map(myCorpus, removeWords, c('mim', 'alguem', 'nao', 'pra'))
inspect(myCorpus[1:3])

# construindo uma matriz documentos versus termos
myTable <- TermDocumentMatrix(myCorpus)
myTable
inspect(myTable[1:10,1:10])

# termos mais frequentes
findFreqTerms(myTable, lowfreq=20)

# que palavras sao associadas com protestosp (da #protestosp)
findAssocs(myTable, 'protestosp', 0.1)

# construindo uma matriz termos versus documentos para iniciar o 
# processo de clustering

# aplicando algoritmo de stemming
myCorpus <- tm_map(myCorpus, stemDocument, language="portuguese")
inspect(myCorpus[1:3])

docs_term <- DocumentTermMatrix(myCorpus)

set.seed(1234)
elbow <- function(dataset) {
  wss <- numeric(15)
  for (i in 1:15) wss[i] <- sum(kmeans(dataset, centers = i, nstart = 100)$withinss)
    plot(1:15, wss, type = "b", main = "Elbow method", xlab = "Number of Clusters",
          ylab = "Within groups sum of squares", pch = 8)
}
elbow(docs_term)

cluster_model <- kmeans(docs_term, centers= 12, nstart= 100)
table(cluster_model$cluster)
cluster_model$withinss

df[cluster_model$cluster == 3, c(1,10)]
df[cluster_model$cluster == 4, c(1,10)]
df[cluster_model$cluster == 12, c(1,10)]