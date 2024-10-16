library(arules)

# Sample binary matrix data (replace this with your actual data)
data1961 <- read.csv('binary_matrix1961.csv', row.names = 1)
data2022 <- read.csv('binary_matrix2022.csv', row.names = 1)
data_all <- read.csv('binary_matrix_all.csv', row.names = 1)

head(data1961)

# Convert the binary data frame to a transaction object
# Remove the Country column and convert to a matrix
binary_matrix <- as.matrix(data1961[,-1])  # Exclude the Country column
head(binary_matrix)
nrow(binary_matrix)

binary_matrix <- as(binary_matrix, "transactions")
head(binary_matrix)
nrow(binary_matrix)

summary(binary_matrix)

# Apply the Apriori algorithm to find frequent itemsets
frequent_itemsets <- apriori(binary_matrix, parameter = list(support = 1, 
                                                             target = "frequent itemsets",
                                                             confidence = 0.2, 
                                                             minlen = 7,
                                                             maxlen = 10))

head(frequent_itemsets)
quality(frequent_itemsets)
################################################################
################################################################
################################################################

rules <- apriori(binary_matrix, 
                 parameter = list(supp = 0.1, 
                                  conf = 0.9,
                                  minlen = 2,
                                  maxlen = 5),
                                  appearance = list(default="lhs", rhs="Fat.of.pigs"),
                                  control=list(verbose=FALSE))

#rules_with_high_lift <- subset(rules, lift > 1)
#nrow(rules_with_high_lift)
#head(rules_with_high_lift)

#sorted <- sort(rules_with_high_lift, by = "lift", decreasing = TRUE)
sorted <- sort(rules, by = "lift", decreasing = TRUE)

inspect(sorted)

itemFrequencyPlot(binary_matrix, topN=20, type="absolute")

################################################################
################################################################
################################################################

# Generate association rules from the frequent itemsets
#rules <- apriori(binary_matrix, parameter = list(support = 0.8, confidence = 0.8))


# Print the association rules
#inspect(rules)

# Optionally, filter rules based on lift or other metrics
filtered_rules <- subset(frequent_itemsets, support < 1)
inspect(filtered_rules)

##########################################

trans1961 <- read.transactions('binary_matrix1961.csv', 
                              rm.duplicates = FALSE,
                              format = "basket",
                              sep = ",",
                              cols = 0)


nrow(trans1961)
head(trans1961)



data2022 <- read.csv('binary_matrix2022.csv', row.names = 1)
data_all <- read.csv('binary_matrix_all.csv', row.names = 1)

head(data1961)

foods <- read.transactions("binary_matrix1961")

################################################################
################################################################
################################################################

FoodsKumar <- read.transactions("KumarGroceriesAS_Transactions.csv",
                                rm.duplicates = FALSE, 
                                format = "basket",  ##if you use "single" also use cols=c(1,2)
                                sep=",",  ## csv file
                                cols=1) ## The dataset HAS row numbers
inspect(FoodsKumar)

##### Use apriori to get the RULES
FrulesK = arules::apriori(FoodsKumar, parameter = list(support=.35, 
                                                       confidence=.5, minlen=2))
inspect(FrulesK)

## Plot of which items are most frequent
itemFrequencyPlot(FoodsKumar, topN=20, type="absolute")

## Sort rules by a measure such as conf, sup, or lift
SortedRulesK <- sort(FrulesK, by="confidence", decreasing=TRUE)
inspect(SortedRulesK[1:10])
(summary(SortedRulesK))

## Selecting or targeting specific rules  RHS
BeerRules <- apriori(data=FoodsKumar,parameter = list(supp=.001, conf=.01, minlen=2),
                     appearance = list(default="lhs", rhs="Beer"),
                     control=list(verbose=FALSE))
BeerRules <- sort(BeerRules, decreasing=TRUE, by="confidence")
inspect(BeerRules[1:4])

## Selecting rules with LHS specified
BreadRules <- apriori(data=FoodsKumar,parameter = list(supp=.001, conf=.01, minlen=2),
                      appearance = list(default="rhs", lhs="Bread"),
                      control=list(verbose=FALSE))
BreadRules <- sort(BreadRules, decreasing=TRUE, by="support")
inspect(BreadRules[1:4])

## Visualize
## tcltk

subrulesK <- head(sort(SortedRulesK, by="lift"),10)
plot(subrulesK)

plot(subrulesK, method="graph", engine="interactive")

################################################################
################################################################
################################################################

library(arules)
data1961 <- read.csv('binary_matrix1961.csv', row.names = 1)

nrow(data1961)

trans1961 <- read.transactions('binary_matrix1961.csv', 
                               rm.duplicates = FALSE,
                               format = "basket",
                               sep = ",",
                               cols = 1)


nrow(trans1961)
head(data1961)
head(trans1961)

rules <- apriori(binary_matrix, 
                 parameter = list(supp = 0.6, 
                                  conf = 1,
                                  minlen = 3,
                                  maxlen = 5),
                 appearance = list(default="lhs", rhs="Fat.of.pigs"),
                 control=list(verbose=FALSE))

#rules_with_high_lift <- subset(rules, lift > 1)
#nrow(rules_with_high_lift)
#head(rules_with_high_lift)

#sorted <- sort(rules_with_high_lift, by = "lift", decreasing = TRUE)
sorted <- sort(rules, by = "lift", decreasing = TRUE)

inspect(sorted[1:10])

itemFrequencyPlot(trans1961, topN=20, type="absolute")


