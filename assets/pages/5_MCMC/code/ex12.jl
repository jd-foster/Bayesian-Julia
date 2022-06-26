# This file was generated, do not modify it. # hide
const warmup = 1_000

scatter((X_met[warmup:warmup + 1_000, 1], X_met[warmup:warmup + 1_000, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")


savefig(joinpath(@OUTPUT, "met_first1000.svg")); # hide