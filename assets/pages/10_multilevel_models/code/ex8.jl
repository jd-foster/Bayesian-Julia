# This file was generated, do not modify it. # hide
model_slope = varying_slope(X, idx, y)
chain_slope = sample(model_slope, NUTS(), MCMCThreads(), 2_000, 4)
summarystats(chain_slope)  |> DataFrame  |> println