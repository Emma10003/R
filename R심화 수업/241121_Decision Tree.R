install.packages("rpart.plot")
library(rpart)  # CART 알고리즘을 지원하는 패키지. (Decision Tree 생성 용도)
library(rpart.plot)  # 그래프를 그리기 위한 패키지.

head(iris)

## CART 알고리즘 --------------------------------------------------------------
# CART를 이용해 Decision Tree 만들기
model <- rpart(Species~., data=iris)
  # rpart(종속변수 ~ 독립변수, data=데이터프레임)
# Decision Tree 그리기
prp(model, type=4, extra=1)
  # rpart.plot의 함수
  # prp(모델, type='트리의 타입 설정', extra='트리의 추가적인 정보 설정')
  # extra: 각 노드별 관측값 대비 올바르게 분류된 데이터의 비율 표시
  #   -> 올바른 분류의 수 / 해당 노드 전체 수

# 새로운 데이터로 예측
predict(model, newdata = iris[101, , drop=F])


## C5.0 알고리즘 --------------------------------------------------------------
install.packages("C50")
library(C50)

model <- C5.0(Species~., data=iris)
plot(model)

predict(model, newdata = iris[61, , drop=F])
  # 결과) Levels: setosa versicolor virginica


## QUEST 알고리즘 -------------------------------------------------------------
install.packages("party")
library(party)

model <- ctree(Species~., data=iris)
plot(model)

predict(model, newdata = iris[101, , drop=F])
  # 결과) Levels: setosa versicolor virginica
  # iris[101, , drop=F] : iris 데이터셋에서 [행, 열] 선택
  #   => 101번째 행의 모든 열을 선택하는 것.
  #   => drop=F: 단일행을 선택하면 벡터로 변환될 수 있기 때문에 이를 방지.