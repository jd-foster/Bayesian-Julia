Chains MCMC chain (2000×20×4 Array{Float64, 3}):

Iterations        = 1001:1:3000
Number of chains  = 4
Samples per chain = 2000
parameters        = real_β[1], real_β[2], real_β[3], α, β[1], β[2], β[3], σ
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters       mean       std   naive_se      mcse         ess      rhat
      Symbol    Float64   Float64    Float64   Float64     Float64   Float64

   real_β[1]     6.3055    2.2329     0.0250    0.0254   8448.8553    1.0000
   real_β[2]     0.5027    0.0623     0.0007    0.0011   3438.9964    1.0004
   real_β[3]    -0.0698    0.2153     0.0024    0.0041   2623.7032    1.0003
           α    33.1727    7.8577     0.0879    0.1782   2041.0042    1.0009
        β[1]   -49.7607    7.0422     0.0787    0.1585   2048.1515    1.0009
        β[2]    21.9290    3.5838     0.0401    0.0805   2081.2924    1.0009
        β[3]     0.2857    0.8818     0.0099    0.0168   2623.7032    1.0003
           σ    17.8587    0.5819     0.0065    0.0095   4699.4191    1.0006

Quantiles
  parameters       2.5%      25.0%      50.0%      75.0%      97.5%
      Symbol    Float64    Float64    Float64    Float64    Float64

   real_β[1]     1.9439     4.7838     6.2949     7.8240    10.6701
   real_β[2]     0.3791     0.4612     0.5042     0.5450     0.6233
   real_β[3]    -0.5211    -0.2010    -0.0599     0.0731     0.3345
           α    18.3592    27.7799    33.0213    38.2457    49.2744
        β[1]   -63.1723   -54.6366   -49.9046   -45.2286   -35.2212
        β[2]    14.6372    19.5997    22.0105    24.3817    28.7418
        β[3]    -1.3697    -0.2994     0.2454     0.8231     2.1338
           σ    16.7691    17.4447    17.8500    18.2574    19.0212
