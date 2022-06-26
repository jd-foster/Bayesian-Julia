# This file was generated, do not modify it.

using Plots, StatsPlots, Distributions, LaTeXStrings

plot(DiscreteUniform(1, 6),
        label="6-sided Dice",
        markershape=:circle,
        xlabel=L"\theta",
        ylabel="Mass",
        ylims=(0, 0.3)
    )
savefig(joinpath(@OUTPUT, "discrete_uniform.svg")); # hide

plot(Bernoulli(0.5),
        markershape=:circle,
        label=L"p=0.5",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass",
        ylim=(0, 1)
    )
plot!(Bernoulli(0.2),
        markershape=:circle,
        label=L"p=0.2",
        alpha=0.5)
savefig(joinpath(@OUTPUT, "bernoulli.svg")); # hide

plot(Binomial(5, 0.5),
        markershape=:circle,
        label=L"p=0.5",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass"
    )
plot!(Binomial(5, 0.2),
        markershape=:circle,
        label=L"p=0.2",
        alpha=0.5)
savefig(joinpath(@OUTPUT, "binomial.svg")); # hide

plot(Poisson(1),
        markershape=:circle,
        label=L"\lambda=1",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass"
    )
plot!(Poisson(4),
    markershape=:circle,
    label=L"\lambda=4",
    alpha=0.5)
savefig(joinpath(@OUTPUT, "poisson.svg")); # hide

plot(NegativeBinomial(1, 0.5),
        markershape=:circle,
        label=L"k=1",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass"
    )
plot!(NegativeBinomial(2, 0.5),
        markershape=:circle,
        label=L"k=2",
        alpha=0.5)
savefig(joinpath(@OUTPUT, "negbinomial.svg")); # hide

plot(Normal(0, 1),
        label=L"\sigma=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(-4, 4)
    )
plot!(Normal(0, 0.5), label=L"\sigma=0.5", lw=5)
plot!(Normal(0, 2), label=L"\sigma=2", lw=5)
savefig(joinpath(@OUTPUT, "normal.svg")); # hide

plot(LogNormal(0, 1),
        label=L"\sigma=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 3)
    )
plot!(LogNormal(0, 0.25), label=L"\sigma=0.25", lw=5)
plot!(LogNormal(0, 0.5), label=L"\sigma=0.5", lw=5)
savefig(joinpath(@OUTPUT, "lognormal.svg")); # hide

plot(Exponential(1),
        label=L"\lambda=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 4.5)
    )
plot!(Exponential(0.5), label=L"\lambda=0.5", lw=5)
plot!(Exponential(1.5), label=L"\lambda=2", lw=5)
savefig(joinpath(@OUTPUT, "exponential.svg")); # hide

plot(TDist(2),
        label=L"\nu=2",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(-4, 4)
    )
plot!(TDist(8), label=L"\nu=8", lw=5)
plot!(TDist(30), label=L"\nu=30", lw=5)
savefig(joinpath(@OUTPUT, "tdist.svg")); # hide

plot(Beta(1, 1),
        label=L"a=b=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 1)
    )
plot!(Beta(3, 2), label=L"a=3, b=2", lw=5)
plot!(Beta(2, 3), label=L"a=2, b=3", lw=5)
savefig(joinpath(@OUTPUT, "beta.svg")); # hide

