install.packages('lme4')
library(mlmRev)
install.packages('lmerTest')

data("Exam")
str(Exam)
help(Exam)

ggplot(data = Exam, aes(x = standLRT, y = normexam)) +
        geom_point() +
        geom_line(data = Exam, aes(x = standLRT, y = Model1_pred, col = 'blue'))

Model1 <- lm(normexam ~ standLRT, data = Exam)
summary(Model1)

Exam$Model1_pred <- predict(Model1)

Model2 <- lmer(normexam ~ standLRT + (1|school), data=Exam) 
summary(Model2)
Exam$Model2_pred <- predict(Model2)

ggplot(data = Exam, aes(x = standLRT, y = normexam)) +
        geom_point(alpha = 0.2) +
        geom_line(data = Exam, aes(x = standLRT, y = Model2_pred, col = school))


