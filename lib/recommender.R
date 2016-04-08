setwd("E:/W4249")
data<-read.csv("moviescsv.csv")
#Finding Similarities

common_reviewers_by_id <- function(movie1, movie2) {
  reviews1 <- subset(data, product_productid==movie1)
  reviews2 <- subset(data, product_productid==movie2)
  reviewers_sameset <- intersect(reviews1[,'review_userid'],
                                 reviews2[,'review_userid'])
  if (length(reviewers_sameset)==0) {
    NA
  } else {
    reviewers_sameset
  }
}

#beer_lookup <- data[,c("product_productid")]
#beer_lookup <- beer_lookup[duplicated(beer_lookup)==FALSE,]

#common_reviewers_by_name <- function(name1, name2) {
#  beer1 <- subset(beer_lookup, beer_name==name1)$beer_id
#  beer2 <- subset(beer_lookup, beer_name==name2)$beer_id
#  common_reviewers_by_id(beer1, beer2)
#}

#common_reviewers_by_id("B000059XY5","B000059XY6")
#common_reviewers_by_name("Founders Double Trouble", "Coors Light")


features <- c("review_score")

get_review_metrics <- function(movie, userset) {
  movie.data <- subset(data, product_productid==movie & review_userid %in% userset)
  o <- order(movie.data$review_userid)
  movie.data <- movie.data[o,]
  dups <- duplicated(movie.data$review_userid)==FALSE
  movie.data <- movie.data[dups,]
  #this can return more than 1 type of metric
  movie.data[,features]
}
#head(reviews)

########
##Quantifying Our Beliefs

calc_similarity <- function(m1, m2) {
  common_users <- common_reviewers_by_id(m1, m2)
  if (is.na(common_users)) {
    return (NA)
  }
  movie1.reviews <- get_review_metrics(m1, common_users)
  movie2.reviews <- get_review_metrics(m2, common_users)
  #this can be more complex; we're just taking a weighted average
  weights <- 1
  #corrs <- sapply(names(movie1.reviews), function(metric) {
  #  cor(movie1.reviews[metric], movie2.reviews[metric])
  #})
  corrs<-cor(movie1.reviews,movie2.reviews)
  sum(corrs * weights, na.rm=TRUE)
}

#m1 <- movie_name_to_id("Fat Tire Amber Ale")
#m2 <- movie_name_to_id("Dale's Pale Ale")
#calc_similarity(m1, m2)
# [1] 0.7295
#b2 <- beer_name_to_id("Michelob Ultra")
#calc_similarity(b1, b2)
###########
#Computing Similarity Across All 2-Beer-Pairs


movie.counts <- ddply(data, .(product_productid), nrow)
o <- order(-movie.counts$V1)
# get the 20 most commonly reviewed beers
all.movies <- head( movie.counts[o,], 20)$product_productid
movie.pairs <- expand.grid(movie1=all.movies, movie2=all.movies)
movie.pairs <- subset(movie.pairs, movie1!=movie2)
results <- ddply(movie.pairs, .(movie1, movie2), function(x) {
  #b1 <- beer_name_to_id(x$beer1)
  #b2 <- beer_name_to_id(x$beer2)
  c("sim"=calc_similarity(x$movie1, x$movie2))
}, .progress="text")

save(results, file="E:/W4249/project4-team-10/output/results.RData")

find_similar_beers <- function(mymovie, style=NULL, n=5) {
  similar <- subset(results, movie1==mymovie)
  #similar <- merge(movies, similar, by.x="product_productid", by.y="movie2")
  if (!is.null(style)) {
    similar <- subset(similar, movie_style==style)
  }
  similar <- similar[order(-similar$sim),]
  n <- min(n, nrow(similar))
  #similar <- similar[1:n,c("brewery", "beer_name", "beer_style", "sim")]
  similar
}
