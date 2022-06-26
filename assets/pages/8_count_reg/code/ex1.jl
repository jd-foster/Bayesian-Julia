# This file was generated, do not modify it. # hide
using Plots, LaTeXStrings

plot(exp, -6, 6, label=false,
     xlabel=L"x", ylabel=L"e^x")
savefig(joinpath(@OUTPUT, "exponential.svg")); # hide