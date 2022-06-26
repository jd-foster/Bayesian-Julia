# This file was generated, do not modify it. # hide
x = -3:0.01:3
y = -3:0.01:3
dens_mvnormal = [pdf(mvnormal, [i, j]) for i in x, j in y]
contour(x, y, dens_mvnormal, xlabel=L"X", ylabel=L"Y", fill=true)
savefig(joinpath(@OUTPUT, "countour_mvnormal.svg")); # hide