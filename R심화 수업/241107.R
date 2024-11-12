# 과적합 측정 계산식 - MSE 구하기
value <- c(3, -0.5, 2, 7)
predict_value <- c(2.5, 0.0, 2, 8)

MSE <-mean((value-predict_value)^2)

MSE
