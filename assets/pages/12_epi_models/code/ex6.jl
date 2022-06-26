# This file was generated, do not modify it. # hide
i₀ = first(br[:, :new_confirmed])
N = maximum(br[:, :estimated_population_2019])

u = [N - i₀, i₀, 0.0]
p = [0.5, 0.05]
prob = ODEProblem(sir_ode!, u, (1.0, 100.0), p)
sol_ode = solve(prob)
plot(sol_ode, label=[L"S" L"I" L"R" ],
     lw=3,
     xlabel=L"t",
     ylabel=L"N",
     yformatter=y -> string(round(Int64, y ÷ 1_000_000)) * "mi",
     title="SIR Model for 100 days, β = $(p[1]), γ = $(p[2])")
savefig(joinpath(@OUTPUT, "ode_solve.svg")); # hide