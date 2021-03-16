spambase <- read.csv("../data/spambase.data", header=F)

names(spambase) <- c('word_freq_make',
'word_freq_address',
'word_freq_all',
'word_freq_3d',
'word_freq_our',
'word_freq_over',
'word_freq_remove',
'word_freq_internet',
'word_freq_order',
'word_freq_mail',
'word_freq_receive',
'word_freq_will',
'word_freq_people',
'word_freq_report',
'word_freq_addresses',
'word_freq_free',
'word_freq_business',
'word_freq_email',
'word_freq_you',
'word_freq_credit',
'word_freq_your',
'word_freq_font',
'word_freq_000',
'word_freq_money',
'word_freq_hp',
'word_freq_hpl',
'word_freq_george',
'word_freq_650',
'word_freq_lab',
'word_freq_labs',
'word_freq_telnet',
'word_freq_857',
'word_freq_data',
'word_freq_415',
'word_freq_85',
'word_freq_technology',
'word_freq_1999',
'word_freq_parts',
'word_freq_pm',
'word_freq_direct',
'word_freq_cs',
'word_freq_meeting',
'word_freq_original',
'word_freq_project',
'word_freq_re',
'word_freq_edu',
'word_freq_table',
'word_freq_conference',
'char_freq_ponto_virgula',
'char_freq_abre_parent',
'char_freq_abre_conche',
'char_freq_exclamacao',
'char_freq_dolar',
'char_freq_cerca',
'capital_run_length_average',
'capital_run_length_longest',
'capital_run_length_total', 'spam')

sapply(spambase,class)
spambase$spam <- as.factor(paste(spambase$spam))

set.seed(1234)
ind <- sample(2, nrow(spambase), replace = TRUE, prob = c(0.7, 0.3))
trainData <- spambase[ind == 1, ]
testData <- spambase[ind == 2, ]

table(trainData$spam)

library(RWeka)
spam_model_j48 <- J48(spam ~ ., data= trainData)
table(predict(spam_model_j48), trainData$spam)
print(spam_model_j48)

testPred <- predict(spam_model_j48, newdata = testData)
table(testPred, testData$spam)

library(randomForest)
spam_model_randomForest <- randomForest(spam ~ ., data=trainData, importance=TRUE, do.trace=100)

spam_model_randomForest

t <- table(predict(spam_model_j48), trainData$spam)
acuracia_treinamento <- (t[1,1] + t[2,2]) / sum(t)
t
acuracia_treinamento

plot(spam_model_randomForest, lty=c(1,1,1), main="Erro estimado baseado na quantidade de árvores utilizadas")
legend("top", c("OOB", "Não spam", "Spam"),
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black", "red", "green"))

varImpPlot(trainForest, main="Importância dos atributos ao classificar as observações")

pred <- predict(spam_model_randomForest, newdata=testData)
t<- table(pred, testData$classe)
acuracia_teste <- (t[1,1] + t[2,2]) / (sum(t))