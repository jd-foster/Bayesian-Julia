# This file was generated, do not modify it. # hide
using Plots, StatsPlots, LaTeXStrings
@df br plot(:date,
            :new_confirmed,
            xlab=L"t", ylab="infected daily",
            yformatter=y -> string(round(Int64, y ÷ 1_000)) * "K",
            label=false)
savefig(joinpath(@OUTPUT, "infected.svg")); # hide