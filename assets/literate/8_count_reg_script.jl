# This file was generated, do not modify it.

using Plots, LaTeXStrings

plot(exp, -6, 6, label=false,
     xlabel=L"x", ylabel=L"e^x")
savefig(joinpath(@OUTPUT, "exponential.svg")); # hide

using Turing
using LazyArrays
using Random:seed!
seed!(123)
setprogress!(false) # hide

@model function poissonreg(X,  y; predictors=size(X, 2))
    #priors
    α ~ Normal(0, 2.5)
    β ~ filldist(TDist(3), predictors)

    #likelihood
    y ~ arraydist(LazyArray(@~ LogPoisson.(α .+ X * β)))
end;

using StatsPlots, Distributions
plot(Gamma(0.01, 0.01),
        lw=2, label=false,
        xlabel=L"\phi",
        ylabel="Density",
        xlims=(0, 0.001))
savefig(joinpath(@OUTPUT, "gamma.svg")); # hide

function NegativeBinomial2(μ, ϕ)
    p = 1 / (1 + μ / ϕ)
    r = ϕ

    return NegativeBinomial(r, p)
end

@model function negbinreg(X,  y; predictors=size(X, 2))
    #priors
    α ~ Normal(0, 2.5)
    β ~ filldist(TDist(3), predictors)
    ϕ⁻ ~ Gamma(0.01, 0.01)
    ϕ = 1 / ϕ⁻

    #likelihood
    y ~ arraydist(LazyArray(@~ NegativeBinomial2.(exp.(α .+ X * β), ϕ)))
end;

using DataFrames, CSV, HTTP

url = "https://raw.githubusercontent.com/storopoli/Bayesian-Julia/master/datasets/roaches.csv"
roaches = CSV.read(HTTP.get(url).body, DataFrame)
describe(roaches)

X = Matrix(select(roaches, Not(:y)))
y = roaches[:, :y]
model_poisson = poissonreg(X, y);

chain_poisson = sample(model_poisson, NUTS(), MCMCThreads(), 2_000, 4)
summarystats(chain_poisson)

using Chain

@chain quantile(chain_poisson) begin
    DataFrame
    select(_,
        :parameters,
        names(_, r"%") .=> ByRow(exp),
        renamecols=false)
end

model_negbin = negbinreg(X, y);

seed!(111) # hide
chain_negbin = sample(model_negbin, NUTS(),MCMCThreads(), 2_000, 4)
summarystats(chain_negbin)

@chain quantile(chain_negbin) begin
    DataFrame
    select(_,
        :parameters,
        names(_, r"%") .=> ByRow(exp),
        renamecols=false)
end

