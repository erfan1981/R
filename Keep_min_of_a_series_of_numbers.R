a <- rnorm(1000)
f < a[1]
for (i in 1:1000) {
if (f > a[i]) {f <- a[i]} 
}
print(f)