# This file was generated, do not modify it. # hide
using StatsPlots, Distributions, LaTeXStrings

plot(Normal(0, 1),
        lw=5, label=false,
        xlabel=L"x",
        ylabel="Density")
savefig(joinpath(@OUTPUT, "normal.svg")); # hide