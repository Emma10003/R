install.packages('randomForest')
library(randomForest)

# train data와 test data 나눔
idx <- sample(seq_len(NROW(iris)), NROW(iris)*0.7)
train <- iris[idx, ]
test <- iris[-idx, ]

# randomForest 모델 생성
model <- randomForest(Species~., data=train, importance=T)
  # importance = T: 모델을 만들 때 어떤 변수가 중요한건지도 체크.
print(model)

# 예측
predict(model, newdata=test[1:3, ])
print(test[1:3, "Species"])

# 변수 중요도 확인
importance(model)
  # MeanDecreaseGini: Gini값이 떨어지는 데에 영향을 미치는 변수
  # : 그 밑의 수치가 얼만큼 영향이 있는지.
  # -> 수치가 큰 Petal.Length와 Petal.Width가 중요한 변수.
  # MeanDecreaseAccuracy도 동일하게 보면 됨.
  # 나머지 변수들은 크게 볼 필요 X.
varImpPlot(model)