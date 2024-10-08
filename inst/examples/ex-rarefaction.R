## Data from Conkey 1980, Kintigh 1989
data("cantabria")

## Replicate fig. 3 from Baxter 2011
rare <- rarefaction(cantabria, sample = 23, method = "baxter")
plot(rare, panel.first = graphics::grid())

## Change graphical parameters
plot(rare, color = color("bright")(5), symbol = 1:5)
