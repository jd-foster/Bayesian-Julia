# This file was generated, do not modify it. # hide
plot(Beta(1, 1),
        label=L"a=b=1",
        lw=5,
        xlabel=L"\theta",
        ylabel="Density",
        xlims=(0, 1)
    )
plot!(Beta(3, 2), label=L"a=3, b=2", lw=5)
plot!(Beta(2, 3), label=L"a=2, b=3", lw=5)
savefig(joinpath(@OUTPUT, "beta.svg")); # hide