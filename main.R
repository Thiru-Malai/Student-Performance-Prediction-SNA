library(igraph)
data <- read.csv("./exams.csv", header = TRUE)

d <- data[0:20]
View(d)

y <- data.frame(d$gender, d$math.score, d$reading.score, d$writing.score)

networkgraph <- graph.data.frame(y, directed = TRUE)
View(networkgraph)
V(networkgraph)


set.seed(100)
plot(networkgraph, vertex.color = "#9c9dfa", vertex.size = 10, edge.arrow_size = 0.3, vertex.label.cex = 0.8) # nolint: line_length_linter.

de <- degree(networkgraph)
print("Degree:")
print(de)

b <- betweenness(networkgraph)
print("Betweenness:")
print(b)

e <- edge_density(networkgraph)
print("edge_density")
print(e)

c <- closeness(networkgraph)

print(c)
