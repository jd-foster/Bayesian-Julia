# This file was generated, do not modify it.

A = rand(3, 2)

using LinearAlgebra:qr, I
Q, R = qr(A)

Matrix(Q') ≈ Matrix(Q^-1)

Q' * Q ≈ I(3)

using Turing
using Statistics: mean, std
using Random:seed!
seed!(123)
setprogress!(false) # hide

@model function linreg(X, y; predictors=size(X, 2))
    #priors
    α ~ Normal(mean(y), 2.5 * std(y))
    β ~ filldist(TDist(3), predictors)
    σ ~ Exponential(1)

    #likelihood
    y ~ MvNormal(α .+ X * β, σ)
end;

using DataFrames, CSV, HTTP

url = "https://raw.githubusercontent.com/storopoli/Bayesian-Julia/master/datasets/kidiq.csv"
kidiq = CSV.read(HTTP.get(url).body, DataFrame)
X = Matrix(select(kidiq, Not(:kid_score)))
y = kidiq[:, :kid_score]
model = linreg(X, y)
chain = sample(model, NUTS(), MCMCThreads(), 2_000, 4)

Q, R = qr(X)
Q_ast = Matrix(Q) * sqrt(size(X, 1) - 1)
R_ast = R / sqrt(size(X, 1) - 1);

model_qr = linreg(Q_ast, y)
chain_qr = sample(model_qr, NUTS(1_000, 0.65), MCMCThreads(), 2_000, 4)

betas = mapslices(x -> R_ast^-1 * x, chain_qr[:, namesingroup(chain_qr, :β),:].value.data, dims=[2])
chain_beta = setrange(Chains(betas, ["real_β[$i]" for i in 1:size(Q_ast, 2)]), 1_001:1:3_000)
chain_qr_reconstructed = hcat(chain_beta, chain_qr)

using StatsPlots, Distributions, LaTeXStrings
funnel_y = rand(Normal(0, 3), 10_000)
funnel_x = rand(Normal(), 10_000) .* exp.(funnel_y / 2)

scatter((funnel_x, funnel_y),
        label=false, mc=:steelblue, ma=0.3,
        xlabel=L"X", ylabel=L"Y",
        xlims=(-100, 100))
savefig(joinpath(@OUTPUT, "funnel.svg")); # hide

@model function funnel()
    y ~ Normal(0, 3)
    x ~ Normal(0, exp(y / 2))
end

    chain_funnel = sample(funnel(), NUTS(), MCMCThreads(), 2_000, 4)

@model function ncp_funnel()
    x̃ ~ Normal()
    ỹ ~ Normal()
    y = 3.0 * ỹ         # implies y ~ Normal(0, 3)
    x = exp(y / 2) * x̃  # implies x ~ Normal(0, exp(y / 2))
end

chain_ncp_funnel = sample(ncp_funnel(), NUTS(), MCMCThreads(), 2_000, 4)

@model function varying_intercept(X, idx, y; n_gr=length(unique(idx)), predictors=size(X, 2))
    #priors
    α ~ Normal(mean(y), 2.5 * std(y))       # population-level intercept
    β ~ filldist(Normal(0, 2), predictors)  # population-level coefficients
    σ ~ Exponential(1 / std(y))             # residual SD
    #prior for variance of random intercepts
    #usually requires thoughtful specification
    τ ~ truncated(Cauchy(0, 2), 0, Inf)     # group-level SDs intercepts
    αⱼ ~ filldist(Normal(0, τ), n_gr)       # CP group-level intercepts

    #likelihood
    ŷ = α .+ X * β .+ αⱼ[idx]
    y ~ MvNormal(ŷ, σ)
end;

@model function varying_intercept_ncp(X, idx, y; n_gr=length(unique(idx)), predictors=size(X, 2))
    #priors
    α ~ Normal(mean(y), 2.5 * std(y))       # population-level intercept
    β ~ filldist(Normal(0, 2), predictors)  # population-level coefficients
    σ ~ Exponential(1 / std(y))             # residual SD

    #prior for variance of random intercepts
    #usually requires thoughtful specification
    τ ~ truncated(Cauchy(0, 2), 0, Inf)    # group-level SDs intercepts
    zⱼ ~ filldist(Normal(0, 1), n_gr)      # NCP group-level intercepts

    #likelihood
    ŷ = α .+ X * β .+ zⱼ[idx] .* τ
    y ~ MvNormal(ŷ, σ)
end;

url = "https://raw.githubusercontent.com/storopoli/Bayesian-Julia/master/datasets/cheese.csv"
cheese = CSV.read(HTTP.get(url).body, DataFrame)

for c in unique(cheese[:, :cheese])
    cheese[:, "cheese_$c"] = ifelse.(cheese[:, :cheese] .== c, 1, 0)
end

cheese[:, :background_int] = map(cheese[:, :background]) do b
    b == "rural" ? 1 :
    b == "urban" ? 2 : missing
end

X = Matrix(select(cheese, Between(:cheese_A, :cheese_D)));
y = cheese[:, :y];
idx = cheese[:, :background_int];

model_cp = varying_intercept(X, idx, y)
chain_cp = sample(model_cp, NUTS(), MCMCThreads(), 2_000, 4)

model_ncp = varying_intercept_ncp(X, idx, y)
chain_ncp = sample(model_ncp, NUTS(), MCMCThreads(), 2_000, 4)

τ = summarystats(chain_ncp)[:τ, :mean]
αⱼ = mapslices(x -> x * τ, chain_ncp[:, namesingroup(chain_ncp, :zⱼ), :].value.data, dims=[2])
chain_ncp_reconstructed = hcat(MCMCChains.resetrange(chain_ncp), Chains(αⱼ, ["αⱼ[$i]" for i in 1:length(unique(idx))]))

