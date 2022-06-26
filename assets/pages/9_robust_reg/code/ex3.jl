# This file was generated, do not modify it. # hide
plot(Normal(0, 1),
        lw=5, label="Normal",
        xlabel=L"x",
        ylabel="Density",
        xlims=(-4, 4))
plot!(TDist(2),
        lw=5, label="Student")
savefig(joinpath(@OUTPUT, "comparison_normal_student.svg")); # hide