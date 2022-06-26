# This file was generated, do not modify it. # hide
@model function funnel()
    y ~ Normal(0, 3)
    x ~ Normal(0, exp(y / 2))
end

    chain_funnel = sample(funnel(), NUTS(), MCMCThreads(), 2_000, 4)