knitr::opts_chunk$set(echo = TRUE)

library(dplyr)
library(tidyr)
library(hexbin)

movies.raw=read.csv("moviescsv.csv")

movies.raw=movies.raw%>%
  separate(review_helpfulness, 
           c("helpful.v", "total.v"), sep = "/", 
           remove=FALSE)



movies.raw=movies.raw%>%mutate(review_h=as.numeric(helpful.v)/as.numeric(total.v))

sample_n(movies.raw, 3)


user.table=movies.raw%>%
  #sample_n(100000)%>%
  group_by(review_userid)%>%
  summarize(
    user.count=n(),
    UReview_ave=mean(review_score, na.rm=T),
    UReview_read=mean(as.numeric(total.v), na.rm=T),
    UReview_help=mean(review_h, na.rm=T)
  )

head(user.table, n=3)




product.table=movies.raw%>%
  #sample_n(100000)%>%
  group_by(product_productid)%>%
  summarize(
    prod.count=n(),
    PReview_read=sum(as.numeric(total.v)),
    PReview_ave=mean(review_score, na.rm=F)
  )

head(product.table, n=3)


product.table_sort=product.table[with(product.table,order(-product.table$prod.count)),]

product_500=head(product.table_sort,n=500)
