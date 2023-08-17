using Test
using Interpolation_with_the_barycentric_formula

# Test 1: Chebyshev Nodes
@testset "Test 1: Chebyshev Nodes" begin
    result = chebyshev_nodes(10, -1, 1)
    expected = [1.0, 0.9510565162951535, 0.8090169943749475, 0.5877852522924731, 0.30901699437494745, 6.123233995736766e-17, -0.30901699437494734, -0.587785252292473, -0.8090169943749473, -0.9510565162951535, -1.0]
    @test result ≈ expected
end

# Test 2: Chebyshev Weights
@testset "Test 2: Chebyshev Weights" begin
    result = chebyshev_weights(10)
    expected = [0.5, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 0.5]
    @test result ≈ expected
end

# Test 3: Barycentric Interpolation
@testset "Test 3: Barycentric Interpolation" begin
    nodes = chebyshev_nodes(10, -1, 1)
    values = [exp(-node^2) for node in nodes]
    weights = chebyshev_weights(10)
    result = barycentric_interpolation(nodes, values, weights, 1e-6)
    @test result ≈ 0.999999999999
end

# Test 4: Get Optimal Degree
@testset "Test 4: Get Optimal Degree" begin
    f1 = x -> exp(-x^2)
    result1 = get_optimal_degree(f1, -1, 1, 1, 1e-6)
    @test result1 == 10
    
    f2 = x -> x == 0 ? 1 : sin(x)/x
    result2 = get_optimal_degree(f2, 0, 10, 1, 1e-6)
    @test result2 == 13

    f3 = x -> abs(x^2 - 2 * x)
    result3 = get_optimal_degree(f3, 1, 3, 1, 1e-6)
    @test result3 == 1567
end

# Test 5: Compute Max Error
@testset "Test 5: Compute Max Error" begin
    f1 = x -> exp(-x^2)
    result1 = compute_max_error(f1, -1, 1, 10)
    @test 0 <= result1 <= 1e-6
end

