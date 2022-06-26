# This file was generated, do not modify it. # hide
plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:steelblue,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

hmc_anim = @animate for i in 1:100
    scatter!(plt, (X_hmc[i, 1], X_hmc[i, 2]),
             label=false, mc=:red, ma=0.5)
    plot!(X_hmc[i:i + 1, 1], X_hmc[i:i + 1, 2], seriestype=:path,
          lc=:green, la=0.5, label=false)
end
gif(hmc_anim, joinpath(@OUTPUT, "hmc_anim.gif"), fps=5); # hide