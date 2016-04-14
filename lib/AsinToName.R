movie_data$Asin_str="NA"
for(i in 1:nrow(movie_data)){
  movie_data[i,16]=toString(movie_data[i,1])
  
  
}

#movie_data$Asin_str
movie_sample1=sample(movie_data$Asin_str,5)
#given_movie=filter(movie_data,movie_data$Asin_str in movie_sample)
toMovieName=function(movie_sample)
{name_result=c()
for(j in 1:length(movie_sample))
{pivot=match(movie_sample[j],movie_data$Asin_str)
 name_result=c(name_result,movie_data[pivot,5])
}
return(name_result)
}

