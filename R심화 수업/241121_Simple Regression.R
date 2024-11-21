# 선형회귀분석 하고 시각화, 검정하기 (단순회귀분석)
library(car)

head(cars)   # cars 데이터는 변수가 2개(컬럼 2개)
str(cars)
(m <- lm(dist ~ speed, data=cars))
# 생성한 객체를 ()로 묶어서 실행하면 실행 결과까지 보여줌.
# speed: 자동차 속도
# dist: 브레이크를 밟았을 때 생기는 흔적의 길이

# 회귀계수 - 종속변수에 speed 변수가 미치는 영향(Coefficient)
coef(m)
# Intercept: β₀(절편항)
# speed: β1

# 적합된 값 - 선형회귀 모델을 가지고 예측된 값.(y hat)
fitted(m)
# 잔차 - 실제값과 예측값의 차이 (y - y hat)
residuals(m)

# 회귀모형에 새로운 데이터를 넣어서 확인 (학습에 참여하지 않은 새로운 데이터)
predict(m, newdata=data.frame(speed=5))
# speed의 값이 5일 때, speed mark의 길이(dist)는 어느 정도인가 출력
# 결과: 2.082949 만큼 생긴다.

# 모델 평가
summary(m)
# Std. Error
# t-value(t통계량)
# p-value가 0.05보다 작은지 확인.(*표시 있는 걸 쓰면 된다.)
# 0.05보다 작으면 해당 변수가 통계적으로 유의미하다.
# Multiple R-squared: 0.65 -> m이라는 모형이 데이터의 65%를 설명한다.
# F-statistic(f통계량)

plot(cars$speed, residuals(m))   # 잔차 산점도
plot(m, which=2)   # 오차항의 정규정 검정(QQ도)
# 1~2 구간에 모형에서 크게 벗어난 데이터들이 존재.
#   => tuning 과정을 통해서 맞추는 과정이 필요하다.

dwt(m)   # 오차항의 Durbin Watson 독립성 검정 {car}
# D-W Statistic값이 1.5~2.5이면 잔차의 값이 독립
# 귀무가설: 잔차의 값이 독립이다. -> p-value가 0.05보다 커야 좋은 모델.


# 완전모델
full <- lm(dist ~ speed, data=cars)
# 축소모델 - 왜 독립변수가 1?
reduced <- lm(dist ~ 1, data=cars)

anova(reduced, full)   # H0: 두 모델간 차이가 없다.

## 변수선택법 -----------------------------------------------------------------
library(mlbench)
library(leaps)

data("BostonHousing")
m <- lm(medv~., data=BostonHousing)
summary(m)
step(m, direction="both")  # 단계적방법
# AIC=1585.76 이후로는 AIC가 증가해서 멈춘 것.
# medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio 를 사용.
step(m, direction="backward")  # 후진제거법
step(m, direction="forward")  # 전진선택법

mal <- regsubsets(medv~., data=BostonHousing)
summary(mal)
# 변수의 개수를 n개만 가지고 사용하고 싶은 경우 위의 결과에서 '*' 표시된
# 변수를 사용하면 된다.
summary(mal)$bic
summary(mal)$adjr2
