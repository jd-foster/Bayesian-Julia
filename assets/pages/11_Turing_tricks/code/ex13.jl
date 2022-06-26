# This file was generated, do not modify it. # hide
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