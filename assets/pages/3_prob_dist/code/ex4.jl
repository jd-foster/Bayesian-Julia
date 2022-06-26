# This file was generated, do not modify it. # hide
plot(Poisson(1),
        markershape=:circle,
        label=L"\lambda=1",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass"
    )
plot!(Poisson(4),
    markershape=:circle,
    label=L"\lambda=4",
    alpha=0.5)
savefig(joinpath(@OUTPUT, "poisson.svg")); # hide