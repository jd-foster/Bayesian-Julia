# This file was generated, do not modify it. # hide
plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:grey,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

const logocolors = Colors.JULIA_LOGO_COLORS;

parallel_met = Animation()
for i in 1:99
    scatter!(plt, (X_met_1[i, 1], X_met_1[i, 2]),
             label=false, mc=logocolors.blue, ma=0.5)
    plot!(X_met_1[i:i + 1, 1], X_met_1[i:i + 1, 2], seriestype=:path,
          lc=logocolors.blue, la=0.5, label=false)
    scatter!(plt, (X_met_2[i, 1], X_met_2[i, 2]),
             label=false, mc=logocolors.red, ma=0.5)
    plot!(X_met_2[i:i + 1, 1], X_met_2[i:i + 1, 2], seriestype=:path,
          lc=logocolors.red, la=0.5, label=false)
    scatter!(plt, (X_met_3[i, 1], X_met_3[i, 2]),
             label=false, mc=logocolors.green, ma=0.5)
    plot!(X_met_3[i:i + 1, 1], X_met_3[i:i + 1, 2], seriestype=:path,
          lc=logocolors.green, la=0.5, label=false)
    scatter!(plt, (X_met_4[i, 1], X_met_4[i, 2]),
             label=false, mc=logocolors.purple, ma=0.5)
    plot!(X_met_4[i:i + 1, 1], X_met_4[i:i + 1, 2], seriestype=:path,
          lc=logocolors.purple, la=0.5, label=false)
    frame(parallel_met)
end
gif(parallel_met, joinpath(@OUTPUT, "parallel_met.gif"), fps=5); # hide