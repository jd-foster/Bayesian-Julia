# This file was generated, do not modify it. # hide
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