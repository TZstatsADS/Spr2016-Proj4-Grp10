# Project 4 Collective intelligence
### Mining Amazon Movies Reviews

Term: Spring 2016
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



Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.

