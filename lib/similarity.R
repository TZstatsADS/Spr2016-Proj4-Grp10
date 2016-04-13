###############similarity based on moviecsv############
library("plyr")
library("reshape2")
setwd("E:/W4249")
#data<-read.csv("moviescsv.csv")
#matrix<-acast(data[1:200,],review_userid~product_productid,value.var="review_score")
#matrix[is.na(matrix)]<-0
#similarity <- function(u1, u2){
#  c1<-matrix[which(rownames(matrix)==u1),]
#  c2<-matrix[which(rownames(matrix)==u2),]
#  corr<-crossprod(c1,c2)/(norm(as.matrix(c1),"f")*norm(as.matrix(c2),"f"))
#  corr
#}
#user.pairs <- expand.grid(user1=rownames(matrix), user2=rownames(matrix))
#user.pairs <- subset(user.pairs, user1!=user2)
#results <- ddply(user.pairs, .(user1, user2), function(x) {
  #b1 <- beer_name_to_id(x$beer1)
  #b2 <- beer_name_to_id(x$beer2)
#  c("sim"=similarity(x$user1, x$user2))
#}, .progress="text")
load("E:/W4249/project4-team-10/output/results.RData")
load("E:/W4249/project4-team-10/output/matrix1.RData")

recursivefunction<-function(c1,b,n=5,j=1,movie){
  c2<-matrix1[which(rownames(matrix1)==b[1]),]
  for(i in 1:length(c1)){
    if (c1[i]==0 & c2[i]>1){
      if(!(names(c1)[i] %in% movie)){
        movie[j]=names(c1)[i]
        j=j+1
      }
    }
  }
  if(j<n+1){
    if(length(b)==0){
      return(movie)
    }
    else{
      b<-b[-1]
      recursivefunction(c1,b,n=5,j,movie)
    }
  }
  else{
    return(movie)
  }
} 
movie<-rep("no movie found",5)
find_similarity_movie<-function(myid,n=5){
  similar <- subset(results, user1==myid)
  similar <- similar[order(-similar$sim),]
  b<-similar[,2]
  c1<-matrix1[which(rownames(matrix1)==myid),]
  recursivefunction(c1,b,n=5,j=1,movie)
}
 
find_similarity_movie(myid)
