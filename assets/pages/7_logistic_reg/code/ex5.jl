# This file was generated, do not modify it. # hide
chain = sample(model, NUTS(), MCMCThreads(), 2_000, 4)
summarystats(chain)