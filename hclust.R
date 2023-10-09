setwd("~/Documents/Machine_Learning/Clustering")

library(tidyverse)
library(cluster)    
library(factoextra) 
library(dendextend)
library(stats)
library(stylo)
library(philentropy)

data <- read.csv("Donor1_sub_300_labels.csv", row.names = 1)
#head(df, 10)
df=data[sample(nrow(data), 30), ]

scaled_df <- scale(df)
#head(scaled_df,10)

dissimilarity <- dist(scaled_df, method = "euclidean")
hc1_CL <- hclust(dissimilarity, method = "complete")

hc_d <- as.dendrogram(hc1_CL)
plot(hc_d)

My_m <- (as.matrix(scale(t(scaled_df))))
My_cosine_dist = 1-crossprod(My_m) /(sqrt(colSums(My_m^2)%*%t(colSums(My_m^2))))
# create dist object
My_cosine_dist <- as.dist(My_cosine_dist) ## Important
HClust_Ward_Cos <- hclust(My_cosine_dist, method="ward.D")
plot(HClust_Ward_Cos, cex=.7, hang=-30,xlab="Gene ID",main = "Gene Clusters using hclust with cosine similarity")
rect.hclust(HClust_Ward_Cos, k=8)



