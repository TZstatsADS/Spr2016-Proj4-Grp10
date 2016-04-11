library(rvest)
library(tidyr)

# Install omdbapi
devtools::install_github("hrbrmstr/omdbapi")

library(omdbapi)
library(pbapply)
library(dplyr)
library(stringr)
# Example 1, not found in OMDB
# ASIN.inq="000500005X" 
# Example 2, found in OMDB
ASIN.list=product_500$product_productid

#######below is data clean part###################################################################
ASIN.str=toString(ASIN.list)
ASIN.str.left=ASIN.str

pivot=1
ASIN.GoodList=c()

while(toString(pivot)!="NA")
{
  pos=str_locate(ASIN.str.left,",")
  pivot=pos[1]
  ASIN.tmp=substr(ASIN.str.left,1,pivot-1)
  

    if(toString(as.numeric(ASIN.tmp))!="NA")
    {
      ASIN.tmp=substr(ASIN.tmp,1,str_length(ASIN.tmp)-2)
    }
  
  ASIN.GoodList=c(ASIN.GoodList,ASIN.tmp)
  ASIN.str.left=substring(ASIN.str.left,pivot+2)
  
}

ASIN.GoodList=ASIN.GoodList[1:499]

####below is feature 


features_name=c("Rated","Type")

feature_table=NULL


for(i in 1:length(ASIN.GoodList))
{
movie1=NULL
movie1.title=NULL

ASIN.inq=ASIN.GoodList[i] # this movie's title has a "("

movie1<-tryCatch( {html(paste("http://www.amazon.com/exec/obidos/ASIN/", ASIN.inq, sep=""))},error=function(e){})


if(is.null(movie1)){next}

movie1.title=
  movie1 %>% 
  html_node("title") %>%
  html_text()

movie1.title=strsplit(movie1.title, ": ")[[1]][2]
movie1.title=strsplit(movie1.title, " \\[")[[1]][1]
movie1.title=strsplit(movie1.title, " \\(")[[1]][1]

movie1.title=substr(movie1.title,1,45)



tryCatch({omdb.entry=search_by_title(movie1.title)},error=function(e){})

if(length(omdb.entry)==0){next}


movie_feature=find_by_id(omdb.entry$imdbID[1], include_tomatoes=T)

tmp_row=c(ASIN.inq,movie1.title)
feature_list=names(movie_feature)

for(j in 1:length(features_name))
{
  index=match(features_name[j],feature_list)
  tmp_row=c(tmp_row,movie_feature[index])
  
}


feature_table=rbind(feature_table,tmp_row)


}


