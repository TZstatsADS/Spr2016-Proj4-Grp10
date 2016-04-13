Project4: Movie Recommendation Engine
=======================================================
author:Qianyun Zhang, Yi Liu, Danmo Wang, Zehao Wang, Zhibo Wan
date: 04/13/2016
autosize: true

Introduction
========================================================
In this project, we attempt to use the Collaborative Filtering approach to build a basic movie recommendation engine and analyze the information of the movies.
- The Dataset
- The Collaborative Filtering approach
- Movie Recommendation Engine and Movie Analysis

The Dataset
========================================================
We firstly use the dataset "movie.csv".In order to keep the recommender simple, we select the 5000 movies with most reviews based on ASIN and then compare the result with OMDB data, filtering out ASINs point to the same movies.

Data Process
========================================================

```r
knitr::opts_chunk$set(echo = TRUE)

library(dplyr)
library(tidyr)
library(hexbin)

##Parsing the helpfuness votes

movies.raw=read.csv("~/Desktop/project4/moviescsv.csv")

movies.raw=movies.raw%>%
  separate(review_helpfulness, 
           c("helpful.v", "total.v"), sep = "/", 
           remove=FALSE)
movies.raw=movies.raw%>%mutate(review_h=as.numeric(helpful.v)/as.numeric(total.v))
sample_n(movies.raw, 3)
```

```
        product_productid  review_userid review_helpfulness helpful.v
7740282        B000AP04KQ A3UF6OQ3CLCD3S                3/3         3
7429934        B002D755AI A1YGNF8LAJ922H                1/1         1
808998         B000H7I6CU  AHY9FT07RILZM                2/2         2
        total.v review_score review_h
7740282       3            5        1
7429934       1            5        1
808998        2            5        1
```

```r
##Compute some user summaries
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
```

```
Source: local data frame [3 x 5]

       review_userid user.count UReview_ave UReview_read UReview_help
              (fctr)      (int)       (dbl)        (dbl)        (dbl)
1                            12        4.25     2.833333    0.8785714
2 #oc-R1FQ7AEZE601ZD          1        1.00     8.000000    0.3750000
3 #oc-R2ZIMCXX9A2H0D          1        1.00    44.000000    0.2727273
```

```r
##compute some movie summaries
product.table=movies.raw%>%
  #sample_n(100000)%>%
  group_by(product_productid)%>%
  summarize(
    prod.count=n(),
    PReview_read=sum(as.numeric(total.v)),
    PReview_ave=mean(review_score, na.rm=F)
  )

head(product.table, n=3)
```

```
Source: local data frame [3 x 4]

  product_productid prod.count PReview_read PReview_ave
             (fctr)      (int)        (dbl)       (dbl)
1                           12           34        4.25
2        000500005X          3           43        5.00
3        000500411X          1            2        5.00
```

```r
product.table_sort=product.table[with(product.table,order(-product.table$prod.count)),]

product_5000=head(product.table_sort,n=5000)
```
OMDB
========================================================






```
Error in eval(expr, envir, enclos) : 找不到对象'product_500'
```
