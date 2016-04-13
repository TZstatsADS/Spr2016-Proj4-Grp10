
library('igraph')
library("reshape2")
setwd("E:/W4249")
data<-read.csv("moviescsv.csv")
g96<-acast(data[1:50,],review_userid~product_productid,value.var="review_score")
#row.names(g96) = data$review_userid[1:50]
i96 <- graph.incidence(g96, mode=c('all') )
V(i96)$color[1:1295] <- rgb(1,0,0,.5)
V(i96)$color[1296:1386] <- rgb(0,1,0,.5)
V(i96)$label <- V(i96)$name
V(i96)$label.color <- rgb(0,0,.2,.5)
V(i96)$label.cex <- .4
V(i96)$size <- 6
V(i96)$frame.color <- NA
E(i96)$color <- rgb(.5,.5,0,.2)
plot(i96, layout=layout.fruchterman.reingold)


##########
i96 <- delete.vertices(i96, V(i96)[ degree(i96)==0 ])
V(i96)$label[1:857] <- NA
V(i96)$color[1:857] <-  rgb(1,0,0,.1)
V(i96)$size[1:857] <- 2

E(i96)$width <- .3
E(i96)$color <- rgb(.5,.5,0,.1)
plot(i96, layout=layout.fruchterman.reingold)

##########
g96e <- t(g96) %*% g96
i96e <- graph.adjacency(g96e, mode = 'undirected')
E(i96e)$weight <- count.multiple(i96e)
i96e <- simplify(i96e)
# Set vertex attributes
V(i96e)$label <- V(i96e)$name
V(i96e)$label.color <- rgb(0,0,.2,.8)
V(i96e)$label.cex <- .6
V(i96e)$size <- 6
V(i96e)$frame.color <- NA
V(i96e)$color <- rgb(0,0,1,.5)

# Set edge gamma according to edge weight
egam <- (log(E(i96e)$weight)+.3)/max(log(E(i96e)$weight)+.3)
E(i96e)$color <- rgb(.5,.5,0,egam)
plot(i96e, main = 'layout.kamada.kawai', layout=layout.kamada.kawai)
