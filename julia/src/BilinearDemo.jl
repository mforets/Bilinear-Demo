"""
Demonstrational project for bilinear systems of equations modeling in Julia.

## Examples

Consider the system of equations

```
(x + y)^2 = 0
1 - 2 * x = 0
```
It can be represented as follows:

```julia
julia> eq1 = BilinearEquation(ConstantTerm(0), LinearTerm[], [BilinearTerm("x", "x", 1), BilinearTerm("y", "y", 1), BilinearTerm("x", "y", 2)])

julia> eq2 = BilinearEquation(ConstantTerm(1), [LinearTerm("x", -2)], BilinearTerm[]);

julia> sys = BilinearSystem([eq1, eq2]);
```

The `Variable` abstraction can be used to operate symbolically, eg. we can assign a value to a variable with `Variable("x", 3.0)`.
"""
module BilinearDemo

export Variable, ConstantTerm, LinearTerm, BilinearTerm, BilinearEquation, BilinearSystem

"""
Variables with their respective uncertainties, if available.
"""
abstract type AbstractVariable end

"Label used for variable names."
const Label = String

"""
Variable that is measured with an associated uncertainty.
Assume uncertainties are distributed normally.
"""
struct Variable <: AbstractVariable
  "Name of this variable."
  name::Label
  "Value associated to the variable (nothing if the value is unknown)."
  value::Union{Float64,Nothing}
  "Uncertainty associated to the variable (nothing if the uncertainty is unknown). Assume standard deviation of a normal distribution."
  uncertainty::Union{Float64,Nothing}
end
Variable(name::Label) = Variable(name, nothing, nothing)
Variable(name::Label, value::Float64) = Variable(name, value, nothing)

"Terms (typically monomials) in an equation."
abstract type AbstractTerm end

"A constant term is one of the form `value`."
struct ConstantTerm <: AbstractTerm
  "Numeric value of this constant."
  value::Float64
end

"A linear term is one of the form `factor * variable`."
struct LinearTerm <: AbstractTerm
  "Name of the variable associated to this term."
  name::Label
  "Numerical factor."
  factor::Float64
end

"""
A bilinear term is one of the form `factor * variable1 * variable2`.
"""
struct BilinearTerm <: AbstractTerm
  "Name of the first variable associated to this term."
  name1::Label
  "Name of the second variable associated to this term."
  name2::Label
  "Numerical factor."
  factor::Float64
end

"Generic equation type."
abstract type AbstractEquation end

"""
A bilinear equation of the form `c + ∑ᵢ L[i] + ∑ᵢ B[i]` where:

- `c` is a constant term.
- `L[i]` are linear terms.
- `B[i]` are bilinear (nonlinear) terms.
"""
struct BilinearEquation <: AbstractEquation
  "Term which is constant."
  constant_term::ConstantTerm
  "Terms which are linear."
  linear_terms::Vector{LinearTerm}
  "Terms which are bilinear."
  bilinear_terms::Vector{BilinearTerm}
end

"Generic system of equations."
abstract type AbastractSystem end

"""
System of bilinear equations.
"""
struct BilinearSystem <: AbastractSystem
  "List of equations."
  equations::Vector{BilinearEquation}
end

end # module BilinearDemo
