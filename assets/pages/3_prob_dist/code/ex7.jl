# This file was generated, do not modify it. # hide
plot(LogNormal(0, 1),
        label=L"\sigma=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 3)
    )
plot!(LogNormal(0, 0.25), label=L"\sigma=0.25", lw=5)
plot!(LogNormal(0, 0.5), label=L"\sigma=0.5", lw=5)
savefig(joinpath(@OUTPUT, "lognormal.svg")); # hide