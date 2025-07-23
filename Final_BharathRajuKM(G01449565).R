library("tidyverse")
library("dplyr")
library("ggplot2")

A <- read.csv("D:/AIT580/Final Project/MenT20ITeamMatchResults_Cleaned.csv")
sum(is.na(A$Margin))
table(A$Margin)
str(A)
A$Match_Month <- factor(A$Match_Month, levels = month.abb)

outcome_by_month <- A %>%
  group_by(Match_Month, Result) %>%
  summarize(Count = n()) %>%
  group_by(Match_Month) %>%
  mutate(Percentage = Count / sum(Count) * 100)


ggplot(outcome_by_month, aes(x = Match_Month, y = Percentage, fill = Result)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black") +
  geom_text(aes(y = Percentage / 2, label = sprintf("%.2f%%", Percentage)), size = 3.5,
            position = position_dodge(width = 0.8), vjust = 0.2, hjust = 0.5, angle = 90) +
  labs(title = "Percentage of Matches Won and Lost based on Month",
       x = "Month",
       y = "Percentage") +
  scale_fill_manual(values = c("lightblue", "lightgreen")) +
  theme_minimal()

outcome_by_ground <- A %>%
  group_by(Ground, Result) %>%
  summarize(Count = n()) %>%
  group_by(Ground)

ggplot(outcome_by_ground, aes(x = Ground, y = Count, fill = Result)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.5) +
  labs(title = "Number of Matches Won and Lost based on Ground",
       x = "Ground",
       y = "Count") +
  scale_fill_manual(values = c("cyan", "orange")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

outcome_by_homeaway <- A %>%
  group_by(Home.Away, Result) %>%
  summarize(Count = n()) %>%
  group_by(Home.Away)

ggplot(outcome_by_homeaway, aes(x = Home.Away, y = Count, fill = Result)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.5, color = "black") +
  geom_text(aes(y = Count / 2, label = Count), size = 3.5,
            position = position_dodge(width = 0.8), vjust = 0.2, hjust = 0.5) +
  labs(title = "",
       x = "Home/Away",
       y = "Count") +
  scale_fill_manual(values = c("chartreuse3", "cornflowerblue")) +
  theme_minimal()

A[, 'Result'] <- as.numeric(as.factor(A[, 'Result']))
A[, 'Home.Away'] <- as.numeric(as.factor(A[, 'Home.Away']))
A[, 'Ground'] <- as.numeric(as.factor(A[, 'Ground']))
A[, 'Country'] <- as.numeric(as.factor(A[, 'Country']))
A[, 'Result_cat'] <- as.numeric(as.factor(A[, 'Result_cat']))
A[, 'Match_Month'] <- as.numeric(as.factor(A[, 'Match_Month']))
str(A)

B <- A[, c('Result', 'Margin', 'Home.Away', 'Ground', 'Match_Month', 'Country', 'Result_cat')]

#install.packages("reshape2")
library(reshape2)

corr_mat <- round(cor(B),2)

melted_corr_mat <- melt(corr_mat)
# head(melted_corr_mat)

ggplot(data = melted_corr_mat, aes(x=Var1, y=Var2,fill=value)) +
  geom_tile() +geom_text(aes(label = sprintf("%.2f", value)), vjust = 1)





