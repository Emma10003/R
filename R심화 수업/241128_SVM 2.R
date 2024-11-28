install.packages('e1071')
library(e1071)

# 데이터셋 만들기
x <- matrix(rnorm(200*2), ncol=2)
x[1:100, ] <- x[1:100, ] + 2
x[101:150, ] <- x[101:150, ] - 2
y <- c(rep(1, 150), rep(2, 50))
plot(x, col=y)

# 데이터프레임으로 변환
dat <- data.frame(x=x, y=as.factor(y))

# svm 모델링
m <- svm(y~., data=dat, kernel="radial", cost=1)
plot(m, dat[sample(200, 100), ])
