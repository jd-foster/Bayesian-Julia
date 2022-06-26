# This file was generated, do not modify it. # hide
d1 = MvNormal([10, 2], [1 0; 0 1])
d2 = MvNormal([0, 0], [8.4 2.0; 2.0 1.7])

d = MixtureModel([d1, d2])

data_mixture = rand(d, 1_000)'

marginalkde(data_mixture[:, 1], data_mixture[:, 2],
            clip=((-1.6, 3), (-3, 3)),
            xlabel=L"X", ylabel=L"Y")
savefig(joinpath(@OUTPUT, "bimodal.svg")); # hide