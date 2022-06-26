Chains MCMC chain (2000×21×4 Array{Float64, 3}):

Iterations        = 1001:1:3000
Number of chains  = 4
Samples per chain = 2000
Wall duration     = 36.88 seconds
Compute duration  = 59.93 seconds
parameters        = α, β[1], β[2], β[3], β[4], σ, τ, αⱼ[1], αⱼ[2]
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters       mean       std   naive_se      mcse         ess      rhat   ess_per_sec
      Symbol    Float64   Float64    Float64   Float64     Float64   Float64       Float64

           α    70.9231    5.4125     0.0605    0.1536   1299.1195    1.0010       21.6762
        β[1]     3.2175    1.2616     0.0141    0.0214   3111.1091    1.0001       51.9098
        β[2]   -11.6139    1.2762     0.0143    0.0230   3205.7805    1.0004       53.4894
        β[3]     7.1610    1.2829     0.0143    0.0208   3327.2658    1.0009       55.5164
        β[4]     1.1733    1.2852     0.0144    0.0208   3246.8705    1.0002       54.1750
           σ     6.0074    0.2769     0.0031    0.0043   4802.3614    1.0007       80.1288
           τ     6.3794    6.0608     0.0678    0.1365   1699.2462    1.0003       28.3524
       αⱼ[1]    -3.6485    5.3036     0.0593    0.1492   1282.2576    1.0012       21.3949
       αⱼ[2]     3.5121    5.3124     0.0594    0.1505   1291.8190    1.0013       21.5544

Quantiles
  parameters       2.5%      25.0%      50.0%      75.0%     97.5%
      Symbol    Float64    Float64    Float64    Float64   Float64

           α    60.4039    68.4525    70.7961    73.1815   81.6217
        β[1]     0.7794     2.3615     3.2116     4.0688    5.7162
        β[2]   -14.1369   -12.4823   -11.6131   -10.7528   -9.1068
        β[3]     4.6566     6.2791     7.1728     8.0273    9.6582
        β[4]    -1.2670     0.3044     1.1510     2.0380    3.7365
           σ     5.4817     5.8174     5.9997     6.1850    6.5762
           τ     1.9377     3.3165     4.6980     7.1703   21.8292
       αⱼ[1]   -14.2241    -5.7653    -3.4677    -1.3435    6.5001
       αⱼ[2]    -7.0246     1.3672     3.5568     5.8528   13.8679
