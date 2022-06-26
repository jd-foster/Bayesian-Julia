Chains MCMC chain (2000×17×4 Array{Float64, 3}):

Iterations        = 1001:1:3000
Number of chains  = 4
Samples per chain = 2000
Wall duration     = 26.69 seconds
Compute duration  = 43.5 seconds
parameters        = α, β[1], β[2], β[3], σ
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse         ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64     Float64   Float64       Float64

           α   21.7605    8.4877     0.0949    0.1480   2914.7137    1.0017       67.0111
        β[1]    2.0650    1.8492     0.0207    0.0328   3031.0695    1.0003       69.6862
        β[2]    0.5795    0.0591     0.0007    0.0010   4212.2141    1.0009       96.8414
        β[3]    0.2408    0.2999     0.0034    0.0046   3947.2384    1.0010       90.7495
           σ   17.8637    0.5804     0.0065    0.0094   4867.5020    1.0006      111.9069

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           α    5.1598   16.0733   21.7539   27.4851   38.0494
        β[1]   -0.6046    0.7341    1.6767    3.0814    6.5626
        β[2]    0.4642    0.5391    0.5803    0.6197    0.6941
        β[3]   -0.3413    0.0386    0.2392    0.4440    0.8286
           σ   16.7764   17.4746   17.8393   18.2370   19.0468
