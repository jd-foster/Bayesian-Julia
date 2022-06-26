# This file was generated, do not modify it.

using StatsPlots, Distributions, LaTeXStrings

plot(Normal(0, 1),
        lw=5, label=false,
        xlabel=L"x",
        ylabel="Density")
savefig(joinpath(@OUTPUT, "normal.svg")); # hide

plot(TDist(2),
        lw=5, label=false,
        xlabel=L"x",
        ylabel="Density",
        xlims=(-4, 4))
savefig(joinpath(@OUTPUT, "tdist.svg")); # hide

plot(Normal(0, 1),
        lw=5, label="Normal",
        xlabel=L"x",
        ylabel="Density",
        xlims=(-4, 4))
plot!(TDist(2),
        lw=5, label="Student")
savefig(joinpath(@OUTPUT, "comparison_normal_student.svg")); # hide

using Turing
using Statistics: mean, std
using StatsBase:mad
using Random:seed!
seed!(123)
seed!(456) # hide
setprogress!(false) # hide

@model function robustreg(X, y; predictors=size(X, 2))
    #priors
    νₐ ~ LogNormal(1, 1)
    νᵦ ~ LogNormal(1, 1)
    α ~ LocationScale(median(y), 2.5 * mad(y), TDist(νₐ))
    β ~ filldist(TDist(νᵦ), predictors)
    σ ~ Exponential(1)
    ν ~ LogNormal(2, 1)

    #likelihood
    y ~ arraydist(LocationScale.(α .+ X * β, σ, TDist.(ν)))
end;

using DataFrames, CSV, HTTP

url = "https://raw.githubusercontent.com/storopoli/Bayesian-Julia/master/datasets/duncan.csv"
duncan = CSV.read(HTTP.get(url).body, DataFrame)
describe(duncan)

@df duncan density(:prestige, label=false)
savefig(joinpath(@OUTPUT, "prestige_density.svg")); # hide

gdf_type = groupby(duncan, :type)
@df combine(gdf_type, :prestige => mean) bar(:type, :prestige_mean, label=false)
savefig(joinpath(@OUTPUT, "prestige_per_type.svg")); # hide

X = Matrix(select(duncan, [:income, :education]))
y = duncan[:, :prestige]
model = robustreg(X, y);

chain = sample(model, NUTS(), MCMCThreads(), 2_000, 4)
summarystats(chain)

quantile(chain)

