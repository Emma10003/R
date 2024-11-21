library(MASS)

data("Boston")
head(Boston)

# 다항 회귀모형 만들기 - Polynomial Regression
poly_model <- lm(medv ~ poly(lstat, 2), data=Boston)
  # poly(lstat, 2): 독립변수를 2차로 하여 polynomial regression을 하도록 함.
summary(poly_model)

# 실제 데이터의 산점도 그래프
plot(Boston$lstat, Boston$medv, xlab="LSTAT", ylab="MEDV",
     pch=19, col="blue")   # nolint
  # plot(x인자, y인자) - lstat이 x축, medv가 y축
  # xlab 파라미터: x축 레이블
  # ylab 파라미터: y축 레이블
  # pch 파라미터: 산점도 그래프의 점 크기
  # col 파라미터: 점 색상

# 예측 모델 그래프
points(Boston$lstat, fitted(poly_model), col="red", pch=20)
  # points(): 점 그리는 함수

# 
lines(sort(Boston$lstat), fitted(poly_model)[order(Boston$lstat)],
      col="red", lwd=2)   # nolint
  # lines(): 선 그리는 함수
  # line(x, y)
  # col 파라미터: 선 색상
  # lwd 파라미터: 선의 굵기