data <- read.csv("emotall.csv", header = TRUE, sep = ";")
data$subject <- factor(data$subject)
data$condition <- factor(data$condition, levels = c(1,2,3,4,5,6,7,8,9)) 
data$sparsevar <- factor(data$sparsevar)
data$block <- factor(data$block)
data$chance <- factor(data$chance)
data$mono <- factor(data$mono, levels = c(1,2), labels = c("positive", "negative"))

#subsetting - если у значений переменной есть ярлыки - только по ярлыкам, 
#если есть только числа - по числам и ярлыки потом
sparse <- subset(data, condition %in% c(1,2,5,7,9))
dense <- subset(data, condition %in% c(3,4,6,8))

#summary statistics and plots (package Rmisk)
a <- summarySE(sparse, measurevar="accur", groupvars=c("condition","block"))

ggplot(a, aes(x=block, y=accur, group=condition, shape=condition)) + 
        geom_errorbar(aes(ymin=accur-se, ymax=accur+se), width=.2, size=0.7) +
        geom_line(size = 1) +
        geom_point(size=3) +
        ylab("accurancy, mean")  +
        xlab("block")+
        scale_shape_discrete(name="condition")+
        theme_bw()+
        theme(legend.position = "bottom")
