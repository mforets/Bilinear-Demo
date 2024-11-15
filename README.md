# Bilinear-Demo

A demonstrational project for modeling bilinear systems of equations in Julia.

## How to use it

1. Download the latest stable Julia release binary for your OS from https://julialang.org/downloads/

2. Clone this git repository.

3. cd to the `julia` folder and do `$ julia --project=.` (assuming that you have `julia` available in your OS path).
    - Note that in a typical Julia package you would also `] instantiate` the dependencies (downloading and precompilation), but this project has no dependencies so that step is not required.

4. Do `using BilinearDemo` to load the module under `julia/src`. Then you should be able to run the example in the module's docstring.

## Example problems

### Preliminaries

We say that a variable is determined if it has a specified value. For example, in

```julia
julia> Variable("x")
Variable("x", nothing, nothing)
```
variable `x` is not determined, while the following corresponds to setting `x = 2`:

```julia
julia> Variable("x", 2.0)
Variable("x", 2.0, nothing)
```
The third field corresponds to an uncertainty assignment, eg.
```julia
julia> Variable("x", 2.0, 0.01)
Variable("x", 2.0, 0.01)
```
represents `x = 2 ± 0.01`.


### Problems

The following problems are of varying difficulty, and you can consder them in any order. 
The scope and specific assumptions are intentionally left open-ended.
It is encouraged that you think about these problems on pen and paper before writing any code.

1. How do you represent a circle of center 1.0 and radius 0.5 using `BilinearEquation`?
2. How do you model a basic SIR model (see the wikipedia article for [The SIR model without birth and date](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology))?   
3. Design a method to evaluate a system of bilinear equations for a given vector of variables: `evaluate(sys::BilinearSystem, vals::Vector{Variable})`. Assume that all variables are determined.
4. Design a method `substitute(sys::BilinearSystem, var::Variable)` to substitute for a given variable `var`, obtaining a new `BilinearSystem`.
5. Design a method `solve(eq::BilinearEquation)` to solve the equation, assuming that `eq` has a unique variable.
6. Design a method to evaluate the Jacobian matrix `jacobian(sys::BilinearSystem, vals::Vector{Variable})` for a given vector of variables. Again, assume that all variables are determined.
7. Discuss different approaches to extend the `solve` method for the multivariate case `BilinearSystem`.

