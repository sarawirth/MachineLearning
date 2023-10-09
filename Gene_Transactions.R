library(arules)
#install.packages("arulesViz")
library(arulesViz)
#library(RColorBrewer)
setwd("~/Documents/Machine_Learning/ARM")
st_trans <- read.transactions("Gene_Transactions_2000.csv", rm.duplicates = FALSE, format = "basket", sep = ",", cols = 1, header = TRUE)
#inspect(st_trans)

#st_rules = arules::apriori(st_trans, parameter = list(support=.8, confidence=.6, minlen=2))
#Crashed rstudio with minlen 10. decreased this and increased support and confidence. 
#Took 9 minutes to check subsets of 1,2,3
#Crashed the computer during the writing step.

#Re-run on 2000 genes. sorting and recording items = 413
#checking subsets 1,2,3,4 54s
#Error in arules::apriori(st_trans, parameter = list(support = 0.8, confidence = 0.6,  : not enough memory. Increase minimum support!
#In addition: Warning message:
#In arules::apriori(st_trans, parameter = list(support = 0.8, confidence = 0.6,  :Mining stopped (time limit reached). Only patterns up to a length of 4 returned!

#st_rules = arules::apriori(st_trans, parameter = list(support=.9, confidence=.8, minlen=2))
#checking subsets of size 1 2 3 4 5 done [26.48s]
#sorting and recoding items ... [140 item(s)] done [0.00s].
#Same error as before. change the maxlen and maxtime parameters
#st_rules = arules::apriori(st_trans, parameter = list(support=.9, confidence=.8, minlen=5, maxlen = 5, maxtime = 0))

#setting min and max length to the same value helps with running time/memory
#sorting and recoding items ... [140 item(s)] done [0.00s].
#creating transaction tree ... done [0.00s].
#checking subsets of size 1 2 3 4 done [0.63s].
#writing ... [62680660 rule(s)] done [29.14s].
#creating S4 object  ... done [12.86s].

st_rules = arules::apriori(st_trans, parameter = list(support=.93, confidence=.95, minlen=4, maxlen = 4, maxtime = 0))
top.support <- sort(st_rules, decreasing = TRUE, na.last = NA, by = "support")
inspect(head(top.support, 10))

