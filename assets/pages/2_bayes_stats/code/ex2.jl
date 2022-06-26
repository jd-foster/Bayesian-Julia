# This file was generated, do not modify it. # hide
d1 = Normal(10, 1)
d2 = Normal(2, 1)
mix_d = [0.4, 0.6]
d = MixtureModel([d1, d2], mix_d)
range_d = -2:0.01:14
sim_d = rand(d, 10_000)
q25 = quantile(sim_d, 0.25)
q75 = quantile(sim_d, 0.75)
plot((range_d, pdf.(d, range_d)),
     leg=false,
     xlims=(-2, 14),
     xticks=[0, 5, 10],
     lw=3,
     xlabel=L"\theta",
     ylabel="Density")
scatter!((mode(d2), pdf(d, mode(d2))), mc=:green, ms=5)
plot!(range(q25, stop=q75, length=100),
      x -> pdf(d, x),
      lc=false, fc=:blues,
      fill=true, fa=0.5)
savefig(joinpath(@OUTPUT, "mixture.svg")); # hide