# This file was generated, do not modify it. # hide
using Plots, StatsPlots, Distributions, LaTeXStrings

plot(DiscreteUniform(1, 6),
        label="6-sided Dice",
        markershape=:circle,
        xlabel=L"\theta",
        ylabel="Mass",
        ylims=(0, 0.3)
    )
savefig(joinpath(@OUTPUT, "discrete_uniform.svg")); # hide