


data <- read.csv("sample_data.csv")


mean_score <- mean(data$Score)
cat("Mean Score:", mean_score, "\n")


treatment_data <- data[data$Group == "Treatment", ]


max_treatment <- max(treatment_data$Score)
cat("Max Score in Treatment group:", max_treatment, "\n")


png("r_task/score_boxplot.png", width = 800, height = 600)
boxplot(Score ~ Group, data = data,
        main = "Score Distribution by Group",
        xlab = "Group",
        ylab = "Score",
        col = c("lightblue", "lightgreen"),
        border = "darkblue",
        notch = FALSE)
dev.off()

cat("Boxplot saved to r_task/score_boxplot.png\n")
