# This file was generated, do not modify it. # hide
plot(NegativeBinomial(1, 0.5),
        markershape=:circle,
        label=L"k=1",
        alpha=0.5,
        xlabel=L"\theta",
        ylabel="Mass"
    )
plot!(NegativeBinomial(2, 0.5),
        markershape=:circle,
        label=L"k=2",
        alpha=0.5)
savefig(joinpath(@OUTPUT, "negbinomial.svg")); # hide