# aquisicao dos dados
vinhos <- read.csv("~/Documents/aulas/bandtec/2013-1/sistemasInteligentes/Aula06-slidesAM/Aula08-arvoresDecisao/experimentos/dados/vinhos.csv", header=F)

# pre-processamento dos dados
names(vinhos) <- c("cultivars", "alcohol", "acid", "Ash", "Alcalinity", "Magnesium", "phenols", "Flavanoids", "Nonflavanoid", "Proanthocyanins", "ColorIntensity", "Hue", "OD280", "Proline")
vinhos$cultivars <- as.factor(paste(vinhos$cultivars))

# separacao do dataset
set.seed(1234)
ind <- sample(2, nrow(vinhos), replace = TRUE, prob = c(0.7, 0.3))
trainData <- vinhos[ind == 1, ]
testData <- vinhos[ind == 2, ]

#criacao do modelo
library(RWeka)
model <- J48(cultivars ~ ., data= trainData)
plot(model)

# testes com o modelo
testPred <- predict(model, newdata = testData)
table(testPred, testData$cultivars)
