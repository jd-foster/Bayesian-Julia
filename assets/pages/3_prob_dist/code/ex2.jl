# This file was generated, do not modify it. # hide
plot(Bernoulli(0.5),
        markershape=:circle,
        label=L"p=0.5",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass",
        ylim=(0, 1)
    )
plot!(Bernoulli(0.2),
        markershape=:circle,
        label=L"p=0.2",
        alpha=0.5)
savefig(joinpath(@OUTPUT, "bernoulli.svg")); # hide