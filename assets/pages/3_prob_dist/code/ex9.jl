# This file was generated, do not modify it. # hide
plot(TDist(2),
        label=L"\nu=2",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(-4, 4)
    )
plot!(TDist(8), label=L"\nu=8", lw=5)
plot!(TDist(30), label=L"\nu=30", lw=5)
savefig(joinpath(@OUTPUT, "tdist.svg")); # hide