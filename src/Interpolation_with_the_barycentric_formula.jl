module InterpolationModule

using LinearAlgebra

function chebyshev_points_weights(n)
    i = 0:n
    x = cos.(π * i / n)  # Chebyshev points
    w = ones(n+1)  # weights
    w[1] = 0.5
    w[end] = 0.5
    w = w .* (-1) .^ i
    return x, w
end

function barycentric_interpolation(x, y, w, x0)
    y0 = zeros(length(x0))
    for (j, x0j) in enumerate(x0)
        numerator = 0.0
        denominator = 0.0
        for (xi, yi, wi) in zip(x, y, w)
            if abs(x0j - xi) < 1e-10
                y0[j] = yi
                break
            else
                r = wi / (x0j - xi)
                numerator += r * yi
                denominator += r
            end
        end
        if y0[j] == 0.0
            y0[j] = numerator / denominator
        end
    end
    return y0
end

function transform(x, a, b)
    return a .+ (x .+ 1) * (b - a) / 2
end

function inverse_transform(x, a, b)
    return 2 * (x .- a) / (b - a) .- 1
end

f1(x) = exp.(-x.^2)
f2(x) = sin.(x)
f3(x) = abs.(x.^2 - 2 .* x)

function interpolation_error(f, y_interpolated, x, a, b)
    y_true = f(transform(x, a, b))
    return maximum(abs.(y_true .- y_interpolated))
end

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

export chebyshev_points_weights, barycentric_interpolation, transform, inverse_transform, f1, f2, f3, interpolation_error

end # module Interpolation_with_the_barycentric_formula
