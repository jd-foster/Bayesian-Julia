# This file was generated, do not modify it. # hide
gdf_type = groupby(duncan, :type)
@df combine(gdf_type, :prestige => mean) bar(:type, :prestige_mean, label=false)
savefig(joinpath(@OUTPUT, "prestige_per_type.svg")); # hide