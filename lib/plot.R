load("/Users/yiliu/Desktop/test_data.RData")
library(dplyr)
library(tidyr)
library(hexbin)
library(rvest)
library(omdbapi)
library(splitstackshape)
library(ggplot2)
library(plotly)


#Production
test <- test_data[,c(3,14)]
test$Prodcution <- factor(unlist(test$Prodcution))
test$PReview_ave <-as.numeric(test$PReview_ave)

test$PReview_ave[( test$PReview_ave >= 0) & (test$PReview_ave <= 1)] <- "0-1"
test$PReview_ave[( test$PReview_ave > 1) & (test$PReview_ave <= 2)] <- "1-2"
test$PReview_ave[( test$PReview_ave > 2) & (test$PReview_ave <= 3)] <- "2-3"
test$PReview_ave[( test$PReview_ave > 3) & (test$PReview_ave <= 4)]<- "3-4"
test$PReview_ave[( test$PReview_ave > 4) & (test$PReview_ave <= 5)] <- "4-5"

test <- cbind(test,rep(1))
names(test)<-c('score','production','count')
test1<-aggregate(test$count,by=list(test$production,test$score),FUN=sum)
names(test1)<-c('production','score','count')

plot1 <- ggplot(data=test1, aes(x=production,y=count,  fill = factor(score))) +geom_bar(stat="identity", position = "stack")+theme(axis.text.x = element_text(angle = 22,size=8,hjust = 1),axis.title=element_blank())+guides(fill=guide_legend(title="score"))
ggplotly(plot1) %>% layout(autosize = F,width = 1200, height = 500)

#Genre
Genre <- test_data[,7]
Genre <- data.frame(cbind(test$score,Genre))
colnames(Genre) <- c("score","genre")
Genre$genre <- as.character(Genre$genre)
rownames(Genre) <- NULL
slipt.genre <- cSplit(Genre, "genre", ",", "long")

slipt.genre$score <- as.character(unlist(slipt.genre$score))
slipt.genre <- cbind(slipt.genre,rep(1))
names(slipt.genre)<-c('score','genre','count')
slipt.genre<-aggregate(slipt.genre$count,by=list(slipt.genre$score,slipt.genre$genre),FUN=sum)
names(slipt.genre)<-c('score','genre','count')
plot2 <- ggplot(data=slipt.genre, aes(x=genre,y=count,  fill = factor(score))) +geom_bar(stat="identity", position = "stack")+theme(axis.text.x = element_text(angle = 20,size=8,hjust = 1),axis.title=element_blank())+guides(fill=guide_legend(title="score"))
ggplotly(plot2) %>% layout(autosize = F,width = 1200, height = 500)

#Director
director <- test_data[,6]
Director <- data.frame(cbind(test$score,director))
colnames(Director) <- c("score","director")
Director$director <- as.character(Director$director)
rownames(Director) <- NULL
slipt.director <- cSplit(Director, "director", ",", "long")

slipt.director$score <- as.character(unlist(slipt.director$score))
slipt.director <- cbind(slipt.director,rep(1))
names(slipt.director)<-c('score','director','count')
slipt.director<-aggregate(slipt.director$count,by=list(slipt.director$score,slipt.director$director),FUN=sum)
names(slipt.director)<-c('score','director','count')
plot3 <- ggplot(data=slipt.director, aes(x=director,y=count,  fill = factor(score))) +geom_bar(stat="identity", position = "stack")+theme(axis.text.x = element_text(angle = 22,size=7.5,hjust = 1),axis.title=element_blank())
ggplotly(plot3) %>% layout(autosize = F,width = 2300, height = 500,legend = list(x = 0, y = 1))
