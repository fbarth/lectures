setwd("~/Documents/palestras/webMiningWithR/scripts")

dados_navegacao_livraria <- read.csv("../data/dados_navegacao_livraria.csv", sep=";")
sapply(dados_navegacao_livraria, class)
dados_navegacao_livraria$user <- NULL
dim(dados_navegacao_livraria)

# reducao do numero de secoes para demonstrar o conceito
set.seed(1234)
ind <- sample(2, nrow(dados_navegacao_livraria), replace = TRUE, prob = c(0.1, 0.9))
dados_navegacao_livraria <- dados_navegacao_livraria[ind==1,]

#convertendo para o tipo necessario
for(i in 1:101) dados_navegacao_livraria[,i] <- ifelse(dados_navegacao_livraria[,i] > 1, TRUE, FALSE)
#for(i in 1:101) dados_navegacao_livraria[,i] <- as.factor(paste(dados_navegacao_livraria[,i]))

# utilizando algoritmos indutores de regras
library(arules)
rules <- apriori(dados_navegacao_livraria, 
                 parameter= list(supp = 0.9, conf = 1, minlen=2, maxlen=3))
