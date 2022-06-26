# This file was generated, do not modify it. # hide
using Plots, StatsPlots, Distributions, LaTeXStrings

dice = DiscreteUniform(1, 6)
plot(dice,
    label="six-sided Dice",
    markershape=:circle,
    ms=5,
    xlabel=L"\theta",
    ylabel="Mass",
    ylims=(0, 0.3)
)
vline!([mean(dice)], lw=5, col=:red, label=L"E(\theta)")
savefig(joinpath(@OUTPUT, "dice.svg")); # hide