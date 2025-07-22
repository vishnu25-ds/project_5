

```{r}
setwd("C:/Users/vishn/an/Desktop/ALL CSV FILES - 2nd Edition")
fast_food=read.csv("fastfood.csv",stringsAsFactors = T)
summary(fast_food)
names(fast_food)
dim(fast_food)
sum(is.na(fast_food))
colSums(is.na(fast_food))
fast_food1=na.omit(fast_food)
dim(fast_food1)
```


```{r}
library(ClusterR)
library(cluster)
library(factoextra)


```


```{r}
fast_food_num=fast_food1[,-c(1,2,17)]
summary(fast_food_num)
```
