using Test
using Interpolation_with_the_barycentric_formula


# Test 1: Chebyshev points and weights
@testset "Test 1: Chebyshev points and weights" begin
    x, w = chebyshev_points_weights(5)
    @test length(x) == 6
    @test length(w) == 6
    @test x[1] == 1
    @test w[1] == 0.5
end

# Test 2: Barycentric interpolation
@testset "Test 2: Barycentric interpolation" begin
    x, w = chebyshev_points_weights(5)
    y = f1(transform(x, -1, 1))
    x0 = range(-1, stop=1, length=10)
    y0 = barycentric_interpolation(x, y, w, x0)
    @test length(y0) == 10
    @test y0[1] == y[1]
end

# Test 3: Transform and inverse transform
@testset "Test 3: Transform and inverse transform" begin
    x = range(-1, stop=1, length=10)
    x_transformed = transform(x, 0, 10)
    x_inverse_transformed = inverse_transform(x_transformed, 0, 10)
    @test x_transformed[1] == 0
    @test x_inverse_transformed[1] == -1
end

# Test 4: Interpolation error
@testset "Test 4: Interpolation error" begin
    x, w = chebyshev_points_weights(5)
    y = f1(transform(x, -1, 1))
    x0 = range(-1, stop=1, length=10)
    y0 = barycentric_interpolation(x, y, w, x0)
    error = interpolation_error(f1, y0, x0, -1, 1)
    @test error < 1
end

# Test 5: Interpolation of functions
@testset "Test 5: Interpolation of functions" begin
    functions = [f1, f2, f3]
    intervals = [(-1, 1), (0, 10), (1, 3)]
    for (f, interval) in zip(functions, intervals)
        degree = 10
        x, w = chebyshev_points_weights(degree)
        y = f(transform(x, interval[1], interval[2]))
        x0 = range(-1, stop=1, length=10)
        y0 = barycentric_interpolation(x, y, w, x0)
        error = interpolation_error(f, y0, x0, interval[1], interval[2])
        @test error < 1
    end
end


