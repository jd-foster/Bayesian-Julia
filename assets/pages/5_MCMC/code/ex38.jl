# This file was generated, do not modify it. # hide
scatter((X_hmc[warmup:end, 1], X_hmc[warmup:end, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")
savefig(joinpath(@OUTPUT, "hmc_all.svg")); # hide