# Interpolation using Barycentric Formula

[![Documenter](https://github.com/lovc21/Interpolation_with_the_barycentric_formula.jl/actions/workflows/Documenter.yml/badge.svg)](https://github.com/lovc21/Interpolation_with_the_barycentric_formula.jl/actions/workflows/Documenter.yml)
[![Runtests](https://github.com/lovc21/Interpolation_with_the_barycentric_formula.jl/actions/workflows/Runtests.yml/badge.svg)](https://github.com/lovc21/Interpolation_with_the_barycentric_formula.jlin/actions/workflows/Runtests.yml)

In this repository, you can finde the code for Homework 3 of the Numerical Methods course.The code is written in Julia, and the main implementation can be found in the file `src/Interpolation_with_the_barycentric_formula.jl`. The code is tested using the file `test/runtests.jl`, and it is documented using the file docs/make.jl, you can test the code for the specific by running the `Scripts/script.jl` file.

To run the code, it is necessary to have Julia installed on your computer. Once downloaded, you can run the code for the following equations:  e^(-x^2)  on \([-1,1]\) , sin(x)/x  on \([0,10]\) and |x^2-2x|  on \([1,3]\).To run the code, you can simply start the script  `Scripts/script.jl`.The script will compute the interpolation for the three equations and will return the reuslts to the precision of 1e-6.  

Here are the results of the interpolation for the three equations for the nodes 1 ,3 the number so that the error is less than 1e-6:

1. e^(-x^2)
<p align="center">
  <img width="460" height="300" src="./images/ezgif-4-cfcfa1457c.gif">
</p>

2. sin(x)/x 
<p align="center">
  <img width="460" height="300" src="./images/ezgif-4-e9a28c1c2b.gif">
</p>

3. |x^2-2x|
<p align="center">
  <img width="460" height="300" src="./images/ezgif-4-53e4254853.gif">
</p>