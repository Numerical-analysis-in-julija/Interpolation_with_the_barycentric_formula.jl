module Interpolation_with_the_barycentric_formula

using LinearAlgebra
using Plots

export barycentric_interpolation, chebyshev_nodes, chebyshev_weights, get_optimal_degree, compute_max_error, plot_interpolation

"""
This function calculates the Chebyshev nodes for the given interval.
    Parameters:
        n: the number of nodes
        a: the left endpoint of the interval
        b: the right endpoint of the interval
    Returns:
        mapped_nodes: the Chebyshev nodes
"""
function chebyshev_nodes(n, a, b)

    # Check the nodes calculation
    nodes = [cos(π * (i / n)) for i in 0:n]
    
    # Check the mapping to the interval
    mapped_nodes = [(a + b) / 2 + (b - a) / 2 * x for x in nodes]
   
    return mapped_nodes
end

"""chebyshev_nodes(10, -1, 1)
11-element Vector{Float64}:
  1.0
  0.9510565162951535   
  0.8090169943749475   
  0.5877852522924731   
  0.30901699437494745  
  6.123233995736766e-17
 -0.30901699437494734  
 -0.587785252292473    
 -0.8090169943749473   
 -0.9510565162951535   
 -1.0
"""

"""
This function calculates the barycentric weights for the Chebyshev nodes.
    Parameters:
        n: the number of nodes
    Returns:
        weights: the barycentric weights
"""
function chebyshev_weights(n)
    weights = [Float64((-1)^i) for i in 0:n]
    weights[1] *= 0.5
    weights[end] *= 0.5
    return weights
end

"""
chebyshev_weights(10)
11-element Vector{Float64}:
  0.5
 -1.0
  1.0
 -1.0
  1.0
 -1.0
  1.0
 -1.0
  1.0
 -1.0
  0.5
"""
    
"""
This function calculates the barycentric interpolation for the given function.
    Parameters:
        nodes: the nodes
        values: the values
        weights: the weights
        x: the point
    Returns:
        numerator / denominator: the barycentric interpolation
"""
function barycentric_interpolation(nodes,values, weights, x)
   if x in nodes
        return values[nodes .== x][1]
    else
         # Calculate the numerator
         numerator = sum(values[i] * weights[i] ./ (x .- nodes[i]) for i in 1:length(nodes))
         # Calculate the denominator
         denominator = sum(weights[i] ./ (x .- nodes[i]) for i in 1:length(nodes))
    end

    return numerator / denominator
end

"""
n = 10
a, b = -1, 1
nodes = chebyshev_nodes(n, a, b)
values = [exp(-node^2) for node in nodes]
weights = chebyshev_weights(n)
x = 1e-6
interpolated_value = barycentric_interpolation(nodes, values, weights, x)
0.999999999999
"""
    
"""
This function calculates the optimal degree for the given function.
    Parameters:
        func: the function
        a: the left endpoint of the interval
        b: the right endpoint of the interval
        n: the number of nodes
        precision: the precision
    Returns:
        n: the optimal degree
"""

function get_optimal_degree(func, a, b,n,precision)
    while true
        nodes = chebyshev_nodes(n, a, b)
        values = [func(node) for node in nodes]
        weights = chebyshev_weights(n)
        
        test_points = range(a, stop=b, length=1000)
        max_error = 0.0

        for x in test_points
            interpolated_value = barycentric_interpolation(nodes, values, weights, x)
            error = abs(func(x) - interpolated_value)
            max_error = max(max_error, error)
        end

        if max_error < precision
            return n
        end

        n += 1  
    
    end
end

"""
n = 1
precision = 1e-6 

f1(x) = exp(-x^2)
f2(x) = x == 0 ? 1 : sin(x)/x
f3(x) = abs(x^2 - 2 * x)

println("e^(-x^2) [-1, 1]: ", get_optimal_degree(f1, -1, 1, n, precision))
println("sin(x)/x on [0, 10]: ", get_optimal_degree(f2, 0, 10, n, precision))
println("|x^2 - 2x| on [1, 3]: ", get_optimal_degree(f3, 1, 3, n, precision))
e^(-x^2) [-1, 1]: 10
sin(x)/x on [0, 10]: 13
|x^2 - 2x| on [1, 3]: 1567
"""

"""
This function computes the maximum error for the given function.
    Parameters:
        f: the function
        a: the left endpoint of the interval
        b: the right endpoint of the interval
        n: the number of nodes
    Returns:
        max_error: the maximum error
"""
function compute_max_error(f, a, b, n)
    nodes = chebyshev_nodes(n, a, b)
    values = [f(node) for node in nodes]
    weights = chebyshev_weights(n)
    
    x_vals = range(a, stop=b, length=1000)
    errors = [abs(f(x) - barycentric_interpolation(nodes, values, weights, x)) for x in x_vals]
    
    return maximum(errors)
end

"""
This function plots the original function and the interpolated function.
    Parameters:
        f: the original function
        a: the left endpoint of the interval
        b: the right endpoint of the interval
        n: the number of nodes
        name: the name of the function
    Returns:
        p: the plot
"""
function plot_interpolation(f, a, b, n, name)
    nodes = chebyshev_nodes(n, a, b)
    values = [f(node) for node in nodes]
    weights = chebyshev_weights(n)
    
    x_vals = range(a, stop=b, length=1000)
    y_true = [f(x) for x in x_vals]
    y_interp = [barycentric_interpolation(nodes, values, weights, x) for x in x_vals]
    
    p = plot(x_vals, y_true, label="Original $name", lw=2)
    plot!(p, x_vals, y_interp, label="Interpolated $name n=$n", linestyle=:dash, lw=2)
    title!("Interpolation of $name with degree $n")
    xlabel!("x")
    ylabel!("f(x)")
    return p
end

end # module Interpolation_with_the_barycentric_formula
