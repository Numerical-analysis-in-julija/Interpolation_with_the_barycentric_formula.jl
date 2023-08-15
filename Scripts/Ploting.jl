
using Plots

x1 = -1:0.01:1
x2 = 0.01:0.1:10
x3 = 1:0.01:3

f1(x) = exp(-x^2)
f2(x) = sin(x) / x
#f2(x) = x == 0 ? 1 : sin(x)/x
f3(x) = abs(x^2 - 2x)

# Plot the functions
plot(x1, f1.(x1), label="e^{-x^2}", legend=:topright)

plot(x2, f2.(x2), label="sin(x)/x")

plot(x3, f3.(x3), label="|x^2-2x|")

