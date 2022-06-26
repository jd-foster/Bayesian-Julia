# This file was generated, do not modify it. # hide
plot(Exponential(1),
        label=L"\lambda=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 4.5)
    )
plot!(Exponential(0.5), label=L"\lambda=0.5", lw=5)
plot!(Exponential(1.5), label=L"\lambda=2", lw=5)
savefig(joinpath(@OUTPUT, "exponential.svg")); # hide