
include("generate.jl")

using GLMakie, CairoMakie

ni = 5
ns = 200
a = generate2D(ni,ns)
set∇𝝭!(a)

I = 13
p = collect(a.𝓒)[I]
xi = p.x
yi = p.y
zi = -0.01
xs = zeros(ns^2)
ys = zeros(ns^2)
𝝭 = zeros(ns^2)
∂𝝭∂x = zeros(ns^2)
∂𝝭∂y = zeros(ns^2)
𝓖 = a.𝓖
for (i,ξ) in enumerate(𝓖)
    N = ξ[:𝝭]
    B₁ = ξ[:∂𝝭∂x]
    B₂ = ξ[:∂𝝭∂y]
    xs[i] = ξ.x
    ys[i] = ξ.y
    𝝭[i] = N[I]
    ∂𝝭∂x[i] = B₁[I]
    ∂𝝭∂y[i] = B₂[I]
end

f = Figure(fonts=(;regular="Arial"))
ax = Axis3(
    f[1,1],
    xgridvisible=false,
    ygridvisible=false,
    zgridvisible=false,
    xlabelvisible=false,
    ylabelvisible=false,
    zlabelvisible=false,
    xticksvisible=false,
    yticksvisible=false,
    # zticksvisible=false,
    xticklabelsvisible=false,
    yticklabelsvisible=false,
    # zticklabelsvisible=false,
    zticklabelsize=25,
)
xlims!(ax, (0.0,1.0))
ylims!(ax, (0.0,1.0))
scatter!(xi, yi, zi, color=:black, markersize = 40, marker=:circle)

# zlims!(ax, (-0.1,1.0))
# surface!(xs, ys, 𝝭, colormap=:jet, alpha=0.6)
# save("𝝭.png",f)

zlims!(ax, (-4.0,4.0))
surface!(xs, ys, ∂𝝭∂x, colormap=:jet, alpha=0.6)
save("∂𝝭∂x.png",f)
f