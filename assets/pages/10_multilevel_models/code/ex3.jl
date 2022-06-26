# This file was generated, do not modify it. # hide
@model function varying_intercept_slope(X, idx, y; n_gr=length(unique(idx)), predictors=size(X, 2))
    #priors
    α ~ Normal(mean(y), 2.5 * std(y))                    # population-level intercept
    σ ~ Exponential(1 / std(y))                          # residual SD
    #prior for variance of random intercepts and slopes
    #usually requires thoughtful specification
    τₐ ~ truncated(Cauchy(0, 2), 0, Inf)                 # group-level SDs intercepts
    τᵦ ~ filldist(truncated(Cauchy(0, 2), 0, Inf), n_gr) # group-level slopes SDs
    αⱼ ~ filldist(Normal(0, τₐ), n_gr)                   # group-level intercepts
    βⱼ ~ filldist(Normal(0, 1), predictors, n_gr)        # group-level standard normal slopes

    #likelihood
    ŷ = α .+ αⱼ[idx] .+ X * βⱼ * τᵦ
    y ~ MvNormal(ŷ, σ)
end;