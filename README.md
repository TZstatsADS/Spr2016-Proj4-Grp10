# Project 4 Collective intelligence
### Movie Recommendation Engine

Group 10: Zehao Wang, Qianyun Zhang, Yi Liu, Danmo Wang, Zhibo Wan

In this project, we attempt to use the user-based Collaborative Filtering approach to build a basic movie recommendation engine and analyze the information of the movies.There are 4 parts of the this presentation:  

* The Dataset  
* The user-based Collaborative Filtering approach  
* Movie Recommendation Engine
* Shiny App: Movie Analysis  


## The Dataset and Data Processing
We firstly use the dataset "movie.csv".In order to keep the recommender simple, we select the 5000 movies with most reviews based on ASIN and then compare the result with OMDB data, filtering out ASIN point to the same movies.  

## The user-based Collaborative Filtering approach  
### Cosine Similarity 
In this method, we only use the movie ratings of users to calculate the similarity.
We choose three columns: product id, user id and moving ratings for each user to the specific movie. And then we reshape the data and construct a big matrix where the columns are the product IDs and the rows are the User IDs.

## Movie Recommendation Engine
Our recommendation engine is user-based. We will recommend you five movies you might like based on your recent acticities (such as moving rating). 
The general ideas for the engine is: when you input you ID, we will help you find users with the similar interests and recommend the movies they like for you. Try the [APP](https://zehaowang.shinyapps.io/project4/) here!!

## Shiny App: Movie Analysis 
Furthermore, we also analyse some [interesing data](https://zehaowang.shinyapps.io/project4/) of the movies.  




