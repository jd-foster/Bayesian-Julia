# This file was generated, do not modify it. # hide
using Plots, StatsPlots, Distributions, LaTeXStrings

d = LogNormal(0, 2)
range_d = 0:0.001:4
q25 = quantile(d, 0.25)
q75 = quantile(d, 0.75)
plot((range_d, pdf.(d, range_d)),
     leg=false,
     xlims=(-0.2, 4.2),
     lw=3,
     xlabel=L"\theta",
     ylabel="Density")
scatter!((mode(d), pdf(d, mode(d))), mc=:green, ms=5)
plot!(range(q25, stop=q75, length=100),
      x -> pdf(d, x),
      lc=false, fc=:blues,
      fill=true, fa=0.5)
savefig(joinpath(@OUTPUT, "lognormal.svg")); # hide