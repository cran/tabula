\donttest{
## Data from Conkey 1980, Kintigh 1989
data("cantabria")

## Assemblage diversity size comparison
## Warning: this may take a few seconds!
h <- heterogeneity(cantabria, method = "shannon")
h_sim <- simulate(h)
plot(h_sim)

r <- richness(cantabria, method = "observed")
r_sim <- simulate(r)
plot(r_sim)
}
