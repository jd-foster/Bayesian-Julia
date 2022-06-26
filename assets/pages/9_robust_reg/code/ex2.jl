# This file was generated, do not modify it. # hide
plot(TDist(2),
        lw=5, label=false,
        xlabel=L"x",
        ylabel="Density",
        xlims=(-4, 4))
savefig(joinpath(@OUTPUT, "tdist.svg")); # hide