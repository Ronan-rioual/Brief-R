data <- read.table(file = "dataset.txt",sep = "/t", header = TRUE)

dataset
str(dataset)
summary(dataset)

keep = c("squareMeters", "price")
input_data = dataset[keep]
input_data

model <- lm(input_data$price ~ input_data$squareMeters)

summary(model)

result= predict(model, input_data)
result

input_data = cbind(input_data, result)
input_data
