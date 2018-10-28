library(ggplot2)
library(lattice)
credit<-read.csv("C:\\Users\\Ashutosh\\Desktop\\credit.csv")
View(credit)
set.seed(2)
id<-sample(2,nrow(credit),prob =c(0.7,0.3),replace=TRUE)
credit_train<-credit[id==1,]
credit_test<-credit[id==2,]
library(randomForest)
credit$decision<-as.factor(credit$decision)
credit_train$decision<-as.factor(credit_train$decision)
bestmtry<-tuneRF(credit_train,credit_train$decision,stepFactor = 1.2,improve = 0.01,trace = T,plot = T)
credit_forest<-randomForest(decision~.,data=credit_train)
credit_forest
varImpPlot(credit_forest)
pred<-predict(credit_forest,newdata = credit_test,type = "class")
pred
library(caret)
confusionMatrix(table(pred,credit_test$decision))
