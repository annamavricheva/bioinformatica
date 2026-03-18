
genes <- c("BRCA1", "TP53", "EGFR")
expression <- c(12.5, 45.2, 30.1)
condition <- c("Control", "Treatment", "Treatment")


exp_data <- data.frame(genes, expression, condition)


str(exp_data)


barplot(expression, 
        names.arg = genes,
        main = "Gene Expression Levels",
        xlab = "Genes",
        ylab = "Expression Value",
        col = c("blue", "red", "red"),
        ylim = c(0, 50))


dev.copy(png, filename = "r_task/expression_plot.png")
dev.off()


