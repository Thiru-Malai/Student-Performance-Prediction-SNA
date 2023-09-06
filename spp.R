library(igraph)

# Read your data (assuming you have already loaded the 'exams.csv' file)
data <- read.csv("./exams.csv", header = TRUE)

# Select the first 1000 rows
data_subset <- data[1:1000, ]

# Initialize a list to store the results for each column
results_list <- list()

# Loop through each column in the dataset
for (col_name in colnames(data_subset)) {
  # Create a new data frame for the current column
  y <- data.frame(data_subset$gender, data_subset[[col_name]])
  # Create a directed graph
  networkgraph <- graph.data.frame(y, directed = TRUE)
  
  # Calculate closeness centrality
  closeness_centrality <- closeness(networkgraph)
  
  # Calculate degree centrality
  degree_centrality <- degree(networkgraph)
  
  # Calculate PageRank centrality
  pagerank_centrality <- page_rank(networkgraph)$vector
  
  # Calculate prestige centrality (eigenvector centrality)
  prestige_centrality <- eigen_centrality(networkgraph)$vector
  
  # Rank the centralities if possible
  rank_closeness <- rank(-closeness_centrality)
  rank_degree <- rank(-degree_centrality)
  rank_pagerank <- rank(-pagerank_centrality)
  rank_prestige <- rank(-prestige_centrality)
  
  # Store the results in a data frame
  result_df <- data.frame(
    Node = V(networkgraph)$name,
    Closeness = closeness_centrality,
    Degree = degree_centrality,
    PageRank = pagerank_centrality,
    Prestige = prestige_centrality,
    Rank_Closeness = rank_closeness,
    Rank_Degree = rank_degree,
    Rank_PageRank = rank_pagerank,
    Rank_Prestige = rank_prestige
  )
  
  # Store the results in the list
  results_list[[col_name]] <- result_df
}

print(results_list)

# Calculate the metrics for the entire dataset (all 1000 rows)
# Create a new data frame for the entire dataset
entire_dataset <- data.frame(
  Node = V(networkgraph)$name,
  Closeness = closeness(networkgraph),
  Degree = degree(networkgraph),
  PageRank = page_rank(networkgraph)$vector,
  Prestige = eigen_centrality(networkgraph)$vector
)

# Print the data for the entire dataset
print("Metrics for the entire dataset (1000 rows):")
print(entire_dataset)