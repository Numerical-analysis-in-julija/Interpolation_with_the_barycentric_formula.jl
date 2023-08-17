using Interpolation_with_the_barycentric_formula

precision = 1e-6
n = 10

f1(x) = exp.(-x.^2)
#f2(x) = sin.(x) ./ x to ne dela 
f2(x) = x == 0 ? 1 : sin(x)/x # to dela 
f3(x) = abs.(x.^2 - 2 .* x)

functions = [f1, f2, f3]
intervals = [(-1, 1), (0, 10), (1, 3)]
names = ["exp(-x^2)", "sin(x)/x", "|x^2 - 2x|"]


# Calculate and print the optimal degree for each function
for (i, f) in enumerate(functions)
    degree = get_optimal_degree(f, intervals[i][1], intervals[i][2], n, precision)
    println("Optimal degree for $(names[i]) on [$(intervals[i][1]), $(intervals[i][2])]: $degree")
end

# Compute the maximum error for each function at the optimal degrees and print the results
degrees = [10, 13, 1567]
for (i, f) in enumerate(functions)
    error = compute_max_error(f, intervals[i][1], intervals[i][2], degrees[i])
    println("Maximum error for $(names[i]) on [$(intervals[i][1]), $(intervals[i][2])]: $error")
end

# Display the plots for each function for increasing n values up to their max degrees
for (i, f) in enumerate(functions)
    for n in [1, 3, degrees[i]]
        p = plot_interpolation(f, intervals[i][1], intervals[i][2], n, names[i])
        display(p)
        sleep(2)  
    end
end



