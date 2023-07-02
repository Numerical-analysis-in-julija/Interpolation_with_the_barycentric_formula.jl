using Documenter
using Interpolation_with_the_barycentric_formula

makedocs(
    sitename = "Interpolation_with_the_barycentric_formula",
    format = Documenter.HTML(),
    modules = [Interpolation_with_the_barycentric_formula]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
