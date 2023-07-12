using Interpolation

f1(x) = exp.(-x.^2)
f2(x) = sin.(x)
f3(x) = abs.(x.^2 - 2 .* x)

functions = [f1, f2, f3]
intervals = [(-1, 1), (0, 10), (1, 3)]
names = ["exp(-x^2)", "sin(x)", "|x^2 - 2x|"]

for (f, interval, name) in zip(functions, intervals, names)
    println("Interpolating function $name on interval $interval...")
    a, b = interval
    degree = 0
    error = Inf
    while error > 1e-6 && degree < 100
        degree += 1
        x, w = chebyshev_points_weights(degree)
        y = f(transform(x, a, b))
        x_test = range(-1, stop=1, length=100)
        y_interpolated = barycentric_interpolation(x, y, w, x_test)
        error = interpolation_error(f, y_interpolated, x_test, a, b)
    end
    println("  Achieved error $error with polynomial degree $degree")
end