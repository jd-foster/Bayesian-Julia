# This file was generated, do not modify it.

using Plots, StatsPlots, Distributions, LaTeXStrings, Random

Random.seed!(123);

const N = 100_000
const μ = [0, 0]
const Σ = [1 0.8; 0.8 1]

const mvnormal = MvNormal(μ, Σ)

data = rand(mvnormal, N)';

x = -3:0.01:3
y = -3:0.01:3
dens_mvnormal = [pdf(mvnormal, [i, j]) for i in x, j in y]
contour(x, y, dens_mvnormal, xlabel=L"X", ylabel=L"Y", fill=true)
savefig(joinpath(@OUTPUT, "countour_mvnormal.svg")); # hide

surface(x, y, dens_mvnormal, xlabel=L"X", ylabel=L"Y", zlabel="PDF")
savefig(joinpath(@OUTPUT, "surface_mvnormal.svg")); # hide

function metropolis(S::Int64, width::Float64, ρ::Float64;
                    μ_x::Float64=0.0, μ_y::Float64=0.0,
                    σ_x::Float64=1.0, σ_y::Float64=1.0,
                    start_x=-2.5, start_y=2.5,
                    seed=123)
    rgn = MersenneTwister(seed)
    binormal = MvNormal([μ_x; μ_y], [σ_x ρ; ρ σ_y])
    draws = Matrix{Float64}(undef, S, 2)
    accepted = 0::Int64;
    x = start_x; y = start_y
    @inbounds draws[1, :] = [x y]
    for s in 2:S
        x_ = rand(rgn, Uniform(x - width, x + width))
        y_ = rand(rgn, Uniform(y - width, y + width))
        r = exp(logpdf(binormal, [x_, y_]) - logpdf(binormal, [x, y]))

        if r > rand(rgn, Uniform())
            x = x_
            y = y_
            accepted += 1
        end
        @inbounds draws[s, :] = [x y]
    end
    println("Acceptance rate is: $(accepted / S)")
    return draws
end

const S = 10_000
const width = 2.75
const ρ = 0.8

X_met = metropolis(S, width, ρ);

X_met[1:10, :]

using MCMCChains

chain_met = Chains(X_met, [:X, :Y]);

summarystats(chain_met)

mean(summarystats(chain_met)[:, :ess]) / S

plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:steelblue,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

met_anim = @animate for i in 1:100
    scatter!(plt, (X_met[i, 1], X_met[i, 2]),
             label=false, mc=:red, ma=0.5)
    plot!(X_met[i:i + 1, 1], X_met[i:i + 1, 2], seriestype=:path,
          lc=:green, la=0.5, label=false)
end
gif(met_anim, joinpath(@OUTPUT, "met_anim.gif"), fps=5); # hide

const warmup = 1_000

scatter((X_met[warmup:warmup + 1_000, 1], X_met[warmup:warmup + 1_000, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")


savefig(joinpath(@OUTPUT, "met_first1000.svg")); # hide

scatter((X_met[warmup:end, 1], X_met[warmup:end, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")
savefig(joinpath(@OUTPUT, "met_all.svg")); # hide

function gibbs(S::Int64, ρ::Float64;
               μ_x::Float64=0.0, μ_y::Float64=0.0,
               σ_x::Float64=1.0, σ_y::Float64=1.0,
               start_x=-2.5, start_y=2.5,
               seed=123)
    rgn = MersenneTwister(seed)
    binormal = MvNormal([μ_x; μ_y], [σ_x ρ; ρ σ_y])
    draws = Matrix{Float64}(undef, S, 2)
    x = start_x; y = start_y
    β = ρ * σ_y / σ_x
    λ = ρ * σ_x / σ_y
    sqrt1mrho2 = sqrt(1 - ρ^2)
    σ_YX = σ_y * sqrt1mrho2
    σ_XY = σ_x * sqrt1mrho2
    @inbounds draws[1, :] = [x y]
    for s in 2:S
        if s % 2 == 0
            y = rand(rgn, Normal(μ_y + β * (x - μ_x), σ_YX))
        else
            x = rand(rgn, Normal(μ_x + λ * (y - μ_y), σ_XY))
        end
        @inbounds draws[s, :] = [x y]
    end
    return draws
end

X_gibbs = gibbs(S * 2, ρ);

X_gibbs[1:10, :]

chain_gibbs = Chains(X_gibbs, [:X, :Y]);

summarystats(chain_gibbs)

(mean(summarystats(chain_gibbs)[:, :ess]) / 2) / S

plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:steelblue,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

gibbs_anim = @animate for i in 1:200
    scatter!(plt, (X_gibbs[i, 1], X_gibbs[i, 2]),
             label=false, mc=:red, ma=0.5)
    plot!(X_gibbs[i:i + 1, 1], X_gibbs[i:i + 1, 2], seriestype=:path,
          lc=:green, la=0.5, label=false)
end
gif(gibbs_anim, joinpath(@OUTPUT, "gibbs_anim.gif"), fps=5); # hide

scatter((X_gibbs[2 * warmup:2 * warmup + 1_000, 1], X_gibbs[2 * warmup:2 * warmup + 1_000, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")


savefig(joinpath(@OUTPUT, "gibbs_first1000.svg")); # hide

scatter((X_gibbs[2 * warmup:end, 1], X_gibbs[2 * warmup:end, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")
savefig(joinpath(@OUTPUT, "gibbs_all.svg")); # hide

const starts = Iterators.product((-2.5, 2.5), (2.5, -2.5)) |> collect

const S_parallel = 100;

X_met_1 = metropolis(S_parallel, width, ρ, seed=124, start_x=first(starts[1]), start_y=last(starts[1]));
X_met_2 = metropolis(S_parallel, width, ρ, seed=125, start_x=first(starts[2]), start_y=last(starts[2]));
X_met_3 = metropolis(S_parallel, width, ρ, seed=126, start_x=first(starts[3]), start_y=last(starts[3]));
X_met_4 = metropolis(S_parallel, width, ρ, seed=127, start_x=first(starts[4]), start_y=last(starts[4]));

plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:grey,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

const logocolors = Colors.JULIA_LOGO_COLORS;

parallel_met = Animation()
for i in 1:99
    scatter!(plt, (X_met_1[i, 1], X_met_1[i, 2]),
             label=false, mc=logocolors.blue, ma=0.5)
    plot!(X_met_1[i:i + 1, 1], X_met_1[i:i + 1, 2], seriestype=:path,
          lc=logocolors.blue, la=0.5, label=false)
    scatter!(plt, (X_met_2[i, 1], X_met_2[i, 2]),
             label=false, mc=logocolors.red, ma=0.5)
    plot!(X_met_2[i:i + 1, 1], X_met_2[i:i + 1, 2], seriestype=:path,
          lc=logocolors.red, la=0.5, label=false)
    scatter!(plt, (X_met_3[i, 1], X_met_3[i, 2]),
             label=false, mc=logocolors.green, ma=0.5)
    plot!(X_met_3[i:i + 1, 1], X_met_3[i:i + 1, 2], seriestype=:path,
          lc=logocolors.green, la=0.5, label=false)
    scatter!(plt, (X_met_4[i, 1], X_met_4[i, 2]),
             label=false, mc=logocolors.purple, ma=0.5)
    plot!(X_met_4[i:i + 1, 1], X_met_4[i:i + 1, 2], seriestype=:path,
          lc=logocolors.purple, la=0.5, label=false)
    frame(parallel_met)
end
gif(parallel_met, joinpath(@OUTPUT, "parallel_met.gif"), fps=5); # hide

X_gibbs_1 = gibbs(S_parallel * 2, ρ, seed=124, start_x=first(starts[1]), start_y=last(starts[1]));
X_gibbs_2 = gibbs(S_parallel * 2, ρ, seed=125, start_x=first(starts[2]), start_y=last(starts[2]));
X_gibbs_3 = gibbs(S_parallel * 2, ρ, seed=126, start_x=first(starts[3]), start_y=last(starts[3]));
X_gibbs_4 = gibbs(S_parallel * 2, ρ, seed=127, start_x=first(starts[4]), start_y=last(starts[4]));

plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:grey,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

parallel_gibbs = Animation()
for i in 1:199
    scatter!(plt, (X_gibbs_1[i, 1], X_gibbs_1[i, 2]),
             label=false, mc=logocolors.blue, ma=0.5)
    plot!(X_gibbs_1[i:i + 1, 1], X_gibbs_1[i:i + 1, 2], seriestype=:path,
          lc=logocolors.blue, la=0.5, label=false)
    scatter!(plt, (X_gibbs_2[i, 1], X_gibbs_2[i, 2]),
             label=false, mc=logocolors.red, ma=0.5)
    plot!(X_gibbs_2[i:i + 1, 1], X_gibbs_2[i:i + 1, 2], seriestype=:path,
          lc=logocolors.red, la=0.5, label=false)
    scatter!(plt, (X_gibbs_3[i, 1], X_gibbs_3[i, 2]),
             label=false, mc=logocolors.green, ma=0.5)
    plot!(X_gibbs_3[i:i + 1, 1], X_gibbs_3[i:i + 1, 2], seriestype=:path,
          lc=logocolors.green, la=0.5, label=false)
    scatter!(plt, (X_gibbs_4[i, 1], X_gibbs_4[i, 2]),
             label=false, mc=logocolors.purple, ma=0.5)
    plot!(X_gibbs_4[i:i + 1, 1], X_gibbs_4[i:i + 1, 2], seriestype=:path,
          lc=logocolors.purple, la=0.5, label=false)
    frame(parallel_gibbs)
end
gif(parallel_gibbs, joinpath(@OUTPUT, "parallel_gibbs.gif"), fps=5); # hide

using ForwardDiff:gradient
function hmc(S::Int64, width::Float64, ρ::Float64;
             L=40, ϵ=0.001,
             μ_x::Float64=0.0, μ_y::Float64=0.0,
             σ_x::Float64=1.0, σ_y::Float64=1.0,
             start_x=-2.5, start_y=2.5,
             seed=123)
    rgn = MersenneTwister(seed)
    binormal = MvNormal([μ_x; μ_y], [σ_x ρ; ρ σ_y])
    draws = Matrix{Float64}(undef, S, 2)
    accepted = 0::Int64;
    x = start_x; y = start_y
    @inbounds draws[1, :] = [x y]
    M = [1. 0.; 0. 1.]
    ϕ_d = MvNormal([0.0, 0.0], M)
    for s in 2:S
        x_ = rand(rgn, Uniform(x - width, x + width))
        y_ = rand(rgn, Uniform(y - width, y + width))
        ϕ = rand(rgn, ϕ_d)
        kinetic = sum(ϕ.^2) / 2
        log_p = logpdf(binormal, [x, y]) - kinetic
        ϕ += 0.5 * ϵ * gradient(x -> logpdf(binormal, x), [x_, y_])
        for l in 1:L
            x_, y_ = [x_, y_] + (ϵ * M * ϕ)
            ϕ += + 0.5 * ϵ * gradient(x -> logpdf(binormal, x), [x_, y_])
        end
        ϕ = -ϕ # make the proposal symmetric
        kinetic = sum(ϕ.^2) / 2
        log_p_ = logpdf(binormal, [x_, y_]) - kinetic
        r = exp(log_p_ - log_p)

        if r > rand(rgn, Uniform())
            x = x_
            y = y_
            accepted += 1
        end
        @inbounds draws[s, :] = [x y]
    end
    println("Acceptance rate is: $(accepted / S)")
    return draws
end

gradient(x -> logpdf(mvnormal, x), [1, -1])

X_hmc = hmc(S, width, ρ, ϵ=0.0856, L=40);

X_hmc[1:10, :]

chain_hmc = Chains(X_hmc, [:X, :Y]);

summarystats(chain_hmc)

mean(summarystats(chain_hmc)[:, :ess]) / S

plt = covellipse(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.3,
    c=:steelblue,
    label="90% HPD",
    xlabel=L"\theta_1", ylabel=L"\theta_2")

hmc_anim = @animate for i in 1:100
    scatter!(plt, (X_hmc[i, 1], X_hmc[i, 2]),
             label=false, mc=:red, ma=0.5)
    plot!(X_hmc[i:i + 1, 1], X_hmc[i:i + 1, 2], seriestype=:path,
          lc=:green, la=0.5, label=false)
end
gif(hmc_anim, joinpath(@OUTPUT, "hmc_anim.gif"), fps=5); # hide

scatter((X_hmc[warmup:warmup + 1_000, 1], X_hmc[warmup:warmup + 1_000, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")


savefig(joinpath(@OUTPUT, "hmc_first1000.svg")); # hide

scatter((X_hmc[warmup:end, 1], X_hmc[warmup:end, 2]),
         label=false, mc=:red, ma=0.3,
         xlims=(-3, 3), ylims=(-3, 3),
         xlabel=L"\theta_1", ylabel=L"\theta_2")

covellipse!(μ, Σ,
    n_std=1.64, # 5% - 95% quantiles
    xlims=(-3, 3), ylims=(-3, 3),
    alpha=0.5,
    c=:steelblue,
    label="90% HPD")
savefig(joinpath(@OUTPUT, "hmc_all.svg")); # hide

d1 = MvNormal([10, 2], [1 0; 0 1])
d2 = MvNormal([0, 0], [8.4 2.0; 2.0 1.7])

d = MixtureModel([d1, d2])

data_mixture = rand(d, 1_000)'

marginalkde(data_mixture[:, 1], data_mixture[:, 2],
            clip=((-1.6, 3), (-3, 3)),
            xlabel=L"X", ylabel=L"Y")
savefig(joinpath(@OUTPUT, "bimodal.svg")); # hide

funnel_y = rand(Normal(0, 3), 10_000)
funnel_x = rand(Normal(), 10_000) .* exp.(funnel_y / 2)

scatter((funnel_x, funnel_y),
        label=false, mc=:steelblue, ma=0.3,
        xlabel=L"X", ylabel=L"Y",
        xlims=(-100, 100))
savefig(joinpath(@OUTPUT, "funnel.svg")); # hide

using Turing
setprogress!(false) # hide

@model function dice_throw(y)
    #Our prior belief about the probability of each result in a six-sided dice.
    #p is a vector of length 6 each with probability p that sums up to 1.
    p ~ Dirichlet(6, 1)

    #Each outcome of the six-sided dice has a probability p.
    y ~ filldist(Categorical(p), length(y))
end;

data_dice = rand(DiscreteUniform(1, 6), 1_000);

model = dice_throw(data_dice)
chain = sample(model, NUTS(), 2_000);
summarystats(chain)

bad_chain = sample(model, NUTS(0.3), 500)
summarystats(bad_chain)

sum(bad_chain[:numerical_error])

mean(bad_chain[:acceptance_rate])

mean(chain[:acceptance_rate])

traceplot(chain)
savefig(joinpath(@OUTPUT, "traceplot_chain.svg")); # hide

traceplot(bad_chain)
savefig(joinpath(@OUTPUT, "traceplot_bad_chain.svg")); # hide

