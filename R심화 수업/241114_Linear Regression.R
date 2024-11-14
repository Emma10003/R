# 패키지 설치 & 라이브러리 불러오기
install.packages("mlbench")
install.packages("car")
install.packages("leaps")
library(mlbench)
library(car)
library(leaps)


# 데이터셋 개요 보기
data("BostonHousing")
head(BostonHousing)   # medv 칼럼이 종속변수


# 회귀분석 lm
  # lm(종속변수 ~ 독립변수1 + 독립변수2 + ..., data=데이터셋)
  # 종속변수를 제외한 모든 칼럼을 독립변수로 사용할 경우
  # lm(종속변수 ~ .)
model <- lm(medv ~ ., data=BostonHousing)
model


# vif 계산
vif(model)
  # 결과값이 4보다 작으면 다중공선성 이슈가 없는 것.
  # nox 변수가 4.39로 다중공선성이 있다.


# 다중공선성이 없는 변수들만 선택해서 다시 회귀분석
model2 <- lm(medv ~ crim+zn+chas+rm+age+ptratio+b+lstat, data=BostonHousing)
model2
  # 결과로 나오는 숫자들은 β값.
  # = 해당 독립변수가 종속변수에 미치는 영향?
  # (Intercept) = β₀(절편항)


# 회귀분석 결과 해석
summary(model2)
  # formula는 회귀분석 결과만 보여주는 것
  # Coefficients가 중요
    # Estimate: β값, (Intercept) = β₀
    # Pr(p-value): 0.05보다 작아야 함.
      # 귀무가설: 'β값이 0이다.' = '해당 변수가 종속변수에 미치는 영향이 없다.'
      # *표시가 1개 이상인 변수들은 써도 좋다 (=귀무가설이 기각된 변수들)
       # Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    # R-squared와 Adjusted R-squared의 값이 비슷하면 문제 없는 것.
    # F-statistic(F통계량)


# p-value가 0.05 이상인 독립변수만 선택해서 다시 회귀분석
model3 <- lm(medv ~ chas+rm+ptratio+b+lstat, data=BostonHousing)
model3
# model3가 최종 모형.


# 변수 선택 -------------------------------------------------------------------
  # 변수 선택 함수를 사용하면 위의 절차를 거치지 않아도 된다.

# 1. 단계적방법(stepwise selection)
model <- lm(medv ~ ., data=BostonHousing)
step(model, direction = "both")
  # 변수들을 반복적으로 넣었다가 빼보면서 AIC가 줄어들 때 해당 변수를 선택

# 2. 전진선택법 (forward selection)
  # regsubsets() 함수를 사용해서 회귀분석을 함.
mal <- regsubsets(medv~., data=BostonHousing)
summary(mal)
  # 결과 해석: *표시 되어 있는 변수만 사용하면 된다.
  # 선택된 변수들로 다시 회귀분석.
fmodel <- lm(medv ~ chas+nox+rm+dis+ptratio+lstat, data=BostonHousing)

