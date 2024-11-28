install.packages('e1071')
library(e1071)

# 데이터셋 생성
x <- matrix(rnorm(20*2), ncol=2)
  # rnorm: 정규분포를 따르는 무작위 숫자 40개 생성
  # y에는 컬럼이 2개이고 데이터가 40개인인 matrix 생성
y <- c(rep(-1, 10), rep(1, 10))
  # y에는 -1 10개, 1 10개가 들어간 벡터를 생성함.
x[y==1, ] <- x[y==1, ] + 1
  # y가 1인 11~20까지 X의 값에 1을 더하는 것.
  # 벡터 y에서 y==1인 건 [11] ~ [20]
plot(x, col=(3-y))


# 데이터프레임 생성
dat <- data.frame(x=x, y=as.factor(y))
  # as.factor: y를 범주형 데이터로 형변환.


# svm 모델링
model <- svm(y~., data=dat, kernel='linear', cost=10, scale=F)
  # 직선 형태, cost(데이터가 섞이는 정도의 허용범위)는 10
  # scale: 정규화 여부 결정. (False: 정규화하지 않음.)
plot(model, dat)
