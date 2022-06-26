# This file was generated, do not modify it. # hide
model_ncp = varying_intercept_ncp(X, idx, y)
chain_ncp = sample(model_ncp, NUTS(), MCMCThreads(), 2_000, 4)