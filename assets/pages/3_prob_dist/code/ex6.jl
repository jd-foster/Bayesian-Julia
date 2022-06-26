# This file was generated, do not modify it. # hide
plot(Normal(0, 1),
        label=L"\sigma=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(-4, 4)
    )
plot!(Normal(0, 0.5), label=L"\sigma=0.5", lw=5)
plot!(Normal(0, 2), label=L"\sigma=2", lw=5)
savefig(joinpath(@OUTPUT, "normal.svg")); # hide