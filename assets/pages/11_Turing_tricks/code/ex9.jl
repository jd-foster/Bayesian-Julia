# This file was generated, do not modify it. # hide
using StatsPlots, Distributions, LaTeXStrings
funnel_y = rand(Normal(0, 3), 10_000)
funnel_x = rand(Normal(), 10_000) .* exp.(funnel_y / 2)

scatter((funnel_x, funnel_y),
        label=false, mc=:steelblue, ma=0.3,
        xlabel=L"X", ylabel=L"Y",
        xlims=(-100, 100))
savefig(joinpath(@OUTPUT, "funnel.svg")); # hide