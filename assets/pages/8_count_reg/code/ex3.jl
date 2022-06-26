# This file was generated, do not modify it. # hide
using StatsPlots, Distributions
plot(Gamma(0.01, 0.01),
        lw=2, label=false,
        xlabel=L"\phi",
        ylabel="Density",
        xlims=(0, 0.001))
savefig(joinpath(@OUTPUT, "gamma.svg")); # hide