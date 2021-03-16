Classificação de Spam usando o algoritmo J48
========================================================

O objetivo deste script é demonstrar a criação de um modelo preditivo no formato de árvore de decisão para identificar spam. Para tanto, será utilizado o dataset disponibilizado em __http://archive.ics.uci.edu/ml/datasets/Spambase__

Carga dos dados:


```r
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
'char_freq_;',
'char_freq_(',
'char_freq_[',
'char_freq_!',
'char_freq_$',
'char_freq_#',
'capital_run_length_average',
'capital_run_length_longest',
'capital_run_length_total', 'spam')

sapply(spambase,class)
```

```
##             word_freq_make          word_freq_address 
##                  "numeric"                  "numeric" 
##              word_freq_all               word_freq_3d 
##                  "numeric"                  "numeric" 
##              word_freq_our             word_freq_over 
##                  "numeric"                  "numeric" 
##           word_freq_remove         word_freq_internet 
##                  "numeric"                  "numeric" 
##            word_freq_order             word_freq_mail 
##                  "numeric"                  "numeric" 
##          word_freq_receive             word_freq_will 
##                  "numeric"                  "numeric" 
##           word_freq_people           word_freq_report 
##                  "numeric"                  "numeric" 
##        word_freq_addresses             word_freq_free 
##                  "numeric"                  "numeric" 
##         word_freq_business            word_freq_email 
##                  "numeric"                  "numeric" 
##              word_freq_you           word_freq_credit 
##                  "numeric"                  "numeric" 
##             word_freq_your             word_freq_font 
##                  "numeric"                  "numeric" 
##              word_freq_000            word_freq_money 
##                  "numeric"                  "numeric" 
##               word_freq_hp              word_freq_hpl 
##                  "numeric"                  "numeric" 
##           word_freq_george              word_freq_650 
##                  "numeric"                  "numeric" 
##              word_freq_lab             word_freq_labs 
##                  "numeric"                  "numeric" 
##           word_freq_telnet              word_freq_857 
##                  "numeric"                  "numeric" 
##             word_freq_data              word_freq_415 
##                  "numeric"                  "numeric" 
##               word_freq_85       word_freq_technology 
##                  "numeric"                  "numeric" 
##             word_freq_1999            word_freq_parts 
##                  "numeric"                  "numeric" 
##               word_freq_pm           word_freq_direct 
##                  "numeric"                  "numeric" 
##               word_freq_cs          word_freq_meeting 
##                  "numeric"                  "numeric" 
##         word_freq_original          word_freq_project 
##                  "numeric"                  "numeric" 
##               word_freq_re              word_freq_edu 
##                  "numeric"                  "numeric" 
##            word_freq_table       word_freq_conference 
##                  "numeric"                  "numeric" 
##                char_freq_;                char_freq_( 
##                  "numeric"                  "numeric" 
##                char_freq_[                char_freq_! 
##                  "numeric"                  "numeric" 
##                char_freq_$                char_freq_# 
##                  "numeric"                  "numeric" 
## capital_run_length_average capital_run_length_longest 
##                  "numeric"                  "integer" 
##   capital_run_length_total                       spam 
##                  "integer"                  "integer"
```

```r
spambase$spam <- as.factor(paste(spambase$spam))
```


Divisão entre conjunto de treinamento e conjunto de teste.


```r
set.seed(1234)
ind <- sample(2, nrow(spambase), replace = TRUE, prob = c(0.7, 0.3))
trainData <- spambase[ind == 1, ]
testData <- spambase[ind == 2, ]

table(trainData$spam)
```

```
## 
##    0    1 
## 1944 1297
```


Criação do modelo:


```r
library(RWeka)
spam_model_j48 <- J48(spam ~ ., data = trainData)
print(spam_model_j48)
```

```
## J48 pruned tree
## ------------------
## 
## word_freq_remove <= 0
## |   char_freq_$ <= 0.058
## |   |   word_freq_000 <= 0.25
## |   |   |   char_freq_! <= 0.355
## |   |   |   |   word_freq_money <= 0.06
## |   |   |   |   |   word_freq_free <= 0.1
## |   |   |   |   |   |   word_freq_george <= 0
## |   |   |   |   |   |   |   word_freq_hp <= 0
## |   |   |   |   |   |   |   |   word_freq_business <= 0.05
## |   |   |   |   |   |   |   |   |   capital_run_length_longest <= 10: 0 (505.0/20.0)
## |   |   |   |   |   |   |   |   |   capital_run_length_longest > 10
## |   |   |   |   |   |   |   |   |   |   word_freq_our <= 0.71
## |   |   |   |   |   |   |   |   |   |   |   word_freq_re <= 0.05
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_you <= 3.67
## |   |   |   |   |   |   |   |   |   |   |   |   |   capital_run_length_average <= 7.836
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_you <= 0.03
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_font <= 0.07
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_address <= 0.16
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   char_freq_! <= 0.139
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_650 <= 0.32: 0 (50.0/4.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_650 > 0.32: 1 (9.0/2.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   char_freq_! > 0.139: 1 (4.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_address > 0.16: 1 (5.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_font > 0.07: 1 (4.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_you > 0.03
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_over <= 0.54: 0 (72.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_over > 0.54
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_over <= 0.78: 0 (2.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_over > 0.78: 1 (2.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   capital_run_length_average > 7.836: 1 (7.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_you > 3.67
## |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_edu <= 0.54: 1 (12.0/2.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   word_freq_edu > 0.54: 0 (2.0)
## |   |   |   |   |   |   |   |   |   |   |   word_freq_re > 0.05: 0 (66.0)
## |   |   |   |   |   |   |   |   |   |   word_freq_our > 0.71
## |   |   |   |   |   |   |   |   |   |   |   word_freq_re <= 0.16
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_will <= 1.25: 1 (12.0)
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_will > 1.25: 0 (3.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   word_freq_re > 0.16: 0 (2.0)
## |   |   |   |   |   |   |   |   word_freq_business > 0.05
## |   |   |   |   |   |   |   |   |   word_freq_650 <= 0.6
## |   |   |   |   |   |   |   |   |   |   char_freq_; <= 0.069
## |   |   |   |   |   |   |   |   |   |   |   char_freq_! <= 0.067: 0 (14.0)
## |   |   |   |   |   |   |   |   |   |   |   char_freq_! > 0.067: 1 (5.0/1.0)
## |   |   |   |   |   |   |   |   |   |   char_freq_; > 0.069: 1 (4.0)
## |   |   |   |   |   |   |   |   |   word_freq_650 > 0.6: 1 (2.0)
## |   |   |   |   |   |   |   word_freq_hp > 0: 0 (402.0/5.0)
## |   |   |   |   |   |   word_freq_george > 0: 0 (465.0)
## |   |   |   |   |   word_freq_free > 0.1
## |   |   |   |   |   |   word_freq_george <= 0.02
## |   |   |   |   |   |   |   word_freq_our <= 1.14
## |   |   |   |   |   |   |   |   word_freq_will <= 1
## |   |   |   |   |   |   |   |   |   word_freq_receive <= 0.24
## |   |   |   |   |   |   |   |   |   |   word_freq_email <= 0.25
## |   |   |   |   |   |   |   |   |   |   |   word_freq_you <= 0.25: 1 (20.0/4.0)
## |   |   |   |   |   |   |   |   |   |   |   word_freq_you > 0.25
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_credit <= 0.6
## |   |   |   |   |   |   |   |   |   |   |   |   |   capital_run_length_average <= 3.816: 0 (56.0/8.0)
## |   |   |   |   |   |   |   |   |   |   |   |   |   capital_run_length_average > 3.816: 1 (8.0/1.0)
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_credit > 0.6: 1 (3.0)
## |   |   |   |   |   |   |   |   |   |   word_freq_email > 0.25: 0 (20.0/1.0)
## |   |   |   |   |   |   |   |   |   word_freq_receive > 0.24: 1 (8.0/1.0)
## |   |   |   |   |   |   |   |   word_freq_will > 1: 0 (18.0)
## |   |   |   |   |   |   |   word_freq_our > 1.14
## |   |   |   |   |   |   |   |   char_freq_! <= 0.279: 1 (23.0/1.0)
## |   |   |   |   |   |   |   |   char_freq_! > 0.279: 0 (2.0)
## |   |   |   |   |   |   word_freq_george > 0.02: 0 (27.0)
## |   |   |   |   word_freq_money > 0.06
## |   |   |   |   |   word_freq_hp <= 0.05
## |   |   |   |   |   |   word_freq_edu <= 0.2
## |   |   |   |   |   |   |   capital_run_length_longest <= 9: 0 (9.0/1.0)
## |   |   |   |   |   |   |   capital_run_length_longest > 9: 1 (20.0)
## |   |   |   |   |   |   word_freq_edu > 0.2: 0 (6.0)
## |   |   |   |   |   word_freq_hp > 0.05: 0 (7.0)
## |   |   |   char_freq_! > 0.355
## |   |   |   |   capital_run_length_total <= 49
## |   |   |   |   |   word_freq_free <= 2.32
## |   |   |   |   |   |   word_freq_money <= 0.23
## |   |   |   |   |   |   |   char_freq_! <= 1.501
## |   |   |   |   |   |   |   |   capital_run_length_longest <= 8: 0 (63.0/1.0)
## |   |   |   |   |   |   |   |   capital_run_length_longest > 8
## |   |   |   |   |   |   |   |   |   capital_run_length_average <= 3.26
## |   |   |   |   |   |   |   |   |   |   capital_run_length_longest <= 9
## |   |   |   |   |   |   |   |   |   |   |   word_freq_85 <= 1.51
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_will <= 1.61: 1 (3.0)
## |   |   |   |   |   |   |   |   |   |   |   |   word_freq_will > 1.61: 0 (3.0)
## |   |   |   |   |   |   |   |   |   |   |   word_freq_85 > 1.51: 0 (2.0)
## |   |   |   |   |   |   |   |   |   |   capital_run_length_longest > 9: 0 (15.0)
## |   |   |   |   |   |   |   |   |   capital_run_length_average > 3.26: 1 (3.0)
## |   |   |   |   |   |   |   char_freq_! > 1.501
## |   |   |   |   |   |   |   |   word_freq_re <= 0.47
## |   |   |   |   |   |   |   |   |   char_freq_! <= 3.333
## |   |   |   |   |   |   |   |   |   |   capital_run_length_total <= 6: 0 (3.0)
## |   |   |   |   |   |   |   |   |   |   capital_run_length_total > 6
## |   |   |   |   |   |   |   |   |   |   |   word_freq_you <= 2.17
## |   |   |   |   |   |   |   |   |   |   |   |   char_freq_! <= 1.765: 1 (2.0)
## |   |   |   |   |   |   |   |   |   |   |   |   char_freq_! > 1.765: 0 (2.0)
## |   |   |   |   |   |   |   |   |   |   |   word_freq_you > 2.17: 1 (2.0)
## |   |   |   |   |   |   |   |   |   char_freq_! > 3.333: 1 (7.0)
## |   |   |   |   |   |   |   |   word_freq_re > 0.47: 0 (4.0)
## |   |   |   |   |   |   word_freq_money > 0.23
## |   |   |   |   |   |   |   word_freq_all <= 0.23: 1 (4.0)
## |   |   |   |   |   |   |   word_freq_all > 0.23: 0 (2.0)
## |   |   |   |   |   word_freq_free > 2.32: 1 (11.0)
## |   |   |   |   capital_run_length_total > 49
## |   |   |   |   |   word_freq_pm <= 0.19
## |   |   |   |   |   |   char_freq_! <= 0.564
## |   |   |   |   |   |   |   word_freq_hp <= 0.22
## |   |   |   |   |   |   |   |   word_freq_meeting <= 0.09
## |   |   |   |   |   |   |   |   |   word_freq_re <= 0.47: 1 (35.0/6.0)
## |   |   |   |   |   |   |   |   |   word_freq_re > 0.47: 0 (5.0/1.0)
## |   |   |   |   |   |   |   |   word_freq_meeting > 0.09: 0 (3.0/1.0)
## |   |   |   |   |   |   |   word_freq_hp > 0.22: 0 (3.0)
## |   |   |   |   |   |   char_freq_! > 0.564: 1 (96.0/5.0)
## |   |   |   |   |   word_freq_pm > 0.19: 0 (8.0/1.0)
## |   |   word_freq_000 > 0.25
## |   |   |   word_freq_re <= 0.3
## |   |   |   |   word_freq_technology <= 0.09
## |   |   |   |   |   word_freq_our <= 0.83: 1 (40.0/1.0)
## |   |   |   |   |   word_freq_our > 0.83
## |   |   |   |   |   |   word_freq_all <= 0.56: 0 (2.0)
## |   |   |   |   |   |   word_freq_all > 0.56: 1 (2.0)
## |   |   |   |   word_freq_technology > 0.09: 0 (3.0/1.0)
## |   |   |   word_freq_re > 0.3: 0 (4.0/1.0)
## |   char_freq_$ > 0.058
## |   |   word_freq_hp <= 0.4
## |   |   |   capital_run_length_average <= 1.987
## |   |   |   |   word_freq_meeting <= 0.35
## |   |   |   |   |   word_freq_1999 <= 0.16
## |   |   |   |   |   |   char_freq_; <= 0.227
## |   |   |   |   |   |   |   char_freq_( <= 0.28
## |   |   |   |   |   |   |   |   word_freq_george <= 0.32
## |   |   |   |   |   |   |   |   |   word_freq_receive <= 0.45: 1 (37.0/4.0)
## |   |   |   |   |   |   |   |   |   word_freq_receive > 0.45: 0 (3.0/1.0)
## |   |   |   |   |   |   |   |   word_freq_george > 0.32: 0 (2.0)
## |   |   |   |   |   |   |   char_freq_( > 0.28: 0 (4.0)
## |   |   |   |   |   |   char_freq_; > 0.227: 0 (3.0)
## |   |   |   |   |   word_freq_1999 > 0.16: 0 (6.0)
## |   |   |   |   word_freq_meeting > 0.35: 0 (7.0)
## |   |   |   capital_run_length_average > 1.987
## |   |   |   |   word_freq_1999 <= 0.06: 1 (335.0/7.0)
## |   |   |   |   word_freq_1999 > 0.06
## |   |   |   |   |   word_freq_edu <= 0.26
## |   |   |   |   |   |   char_freq_$ <= 0.097: 0 (2.0)
## |   |   |   |   |   |   char_freq_$ > 0.097: 1 (13.0/1.0)
## |   |   |   |   |   word_freq_edu > 0.26: 0 (3.0)
## |   |   word_freq_hp > 0.4: 0 (41.0/1.0)
## word_freq_remove > 0
## |   word_freq_85 <= 0.07
## |   |   word_freq_edu <= 0.07: 1 (522.0/19.0)
## |   |   word_freq_edu > 0.07
## |   |   |   word_freq_over <= 0.15: 0 (5.0)
## |   |   |   word_freq_over > 0.15: 1 (29.0)
## |   word_freq_85 > 0.07
## |   |   char_freq_! <= 0.079: 0 (9.0)
## |   |   char_freq_! > 0.079: 1 (17.0)
## 
## Number of Leaves  : 	79
## 
## Size of the tree : 	157
```


Validação do modelo usando o próprio conjunto de treinamento:


```r
t <- table(predict(spam_model_j48), trainData$spam)
acuracia_treinamento <- (t[1, 1] + t[2, 2])/sum(t)
t
```

```
##    
##        0    1
##   0 1886   49
##   1   58 1248
```

```r
acuracia_treinamento
```

```
## [1] 0.967
```


Validação do modelo usando o conjunto de testes:


```r
testPred <- predict(spam_model_j48, newdata = testData)
t <- table(testPred, testData$spam)
acuracia_teste <- (t[1, 1] + t[2, 2])/sum(t)
t
```

```
##         
## testPred   0   1
##        0 789  54
##        1  55 462
```

```r
acuracia_teste
```

```
## [1] 0.9199
```


Este material faz parte do curso sobre [Web Data Mining com R](http://fbarth.net.br/materiais/webMiningR.html)
