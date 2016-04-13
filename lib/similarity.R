###############similarity based on moviecsv############
library("plyr")
library("reshape2")
setwd("E:/W4249")
data<-read.csv("moviescsv.csv")
matrix<-acast(data[1:200,],review_userid~product_productid,value.var="review_score")
matrix[is.na(matrix)]<-0
similarity <- function(u1, u2){
  c1<-matrix[which(rownames(matrix)==u1),]
  c2<-matrix[which(rownames(matrix)==u2),]
  corr<-crossprod(c1,c2)/(norm(as.matrix(c1),"f")*norm(as.matrix(c2),"f"))
  corr
}
user.pairs <- expand.grid(user1=rownames(matrix), user2=rownames(matrix))
user.pairs <- subset(user.pairs, user1!=user2)
results <- ddply(user.pairs, .(user1, user2), function(x) {
  #b1 <- beer_name_to_id(x$beer1)
  #b2 <- beer_name_to_id(x$beer2)
  c("sim"=similarity(x$user1, x$user2))
}, .progress="text")

recursivefunction<-function(myid,b,n=5,j=1){
  c1<-matrix[which(rownames(matrix)==myid),]
  c2<-matrix[which(rownames(matrix)==b[1]),]
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
      recursivefunction(myid,b,n=5,j)
    }
  }
  else{
    return(movie)
  }
} 

find_similarity_movie<-function(myid,n=5){
  similar <- subset(results, user1==myid)
  similar <- similar[order(-similar$sim),]
  b<-similar[,2]
  movie<-rep(NA,n)
  recursivefunction(myid,b,n=5,j=1)
}
 
