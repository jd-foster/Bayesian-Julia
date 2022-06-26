# This file was generated, do not modify it. # hide
using Plots, LaTeXStrings

function logistic(x)
    return 1 / (1 + exp(-x))
end

plot(logistic, -10, 10, label=false,
     xlabel=L"x", ylabel=L"\mathrm{Logistic}(x)")
savefig(joinpath(@OUTPUT, "logistic.svg")); # hide