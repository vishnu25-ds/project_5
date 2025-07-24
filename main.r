

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

```{r}
df <- scale(fast_food_num)

k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)
```


```{r}

if (length(unique(k2$cluster)) < 2) {
  stop("Only one cluster was formed. Try adjusting the number of centers or check your data.")
}

aggregate(fast_food_num, by=list(cluster=k2$cluster), mean)
df_final <- cbind(fast_food1, cluster = k2$cluster)
head(df_final)

df_final$cluster <- as.factor(df_final$cluster)

```


```{r}
#####################Decision tree###############################
set.seed(42)
library(modelr)
split <- resample_partition(df_final, c(train=0.75, test = 0.25))
train_df <- data.frame(split$train)
test_df <- data.frame(split$test)





library(rpart)
library(rpart.plot)


#Run the model
fit <- rpart(cluster~., data = train_df, method = 'class')
rpart.plot(fit, extra = 106)
#Predict on test data:
predict_unseen <-predict(fit, test_df, type = 'class')
```


```{r}
table_mat <- table(test_df$cluster, predict_unseen)
table_mat
```

```{r}

#Confusion matrix
predict_unseen

```




```{r}
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
accuracy_Test
print(paste('Accuracy for test', round(accuracy_Test,3)))

```

