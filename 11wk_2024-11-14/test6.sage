# This code uses a pseudo-random approach to previous implementations of the graph permutation generator
# Greedy/Heuristic Approach
# Early Stopping
# Parallel Processing
#
# Trading processing load for accuracy by reducing the number of fixed weights
# and increasing the limiter value we receive more accurate results at the cost of processing load.
# Increasing the number of fixed_weights and decreasing the limiter will decrease processing load
# at the cost of accuracy.
# The optimial approach for a graph where we do not know the max graph value is removing all
# fixed weights and increasing the limiter to a sufficient size and via iteration
# outputing a value each time.

from random import sample
from itertools import permutations

def max_graph_value_and_assignments(graph, fixed_weights, max_samples=1000):
    edges = list(graph.edges(labels=False))
    
    # Separate fixed and unfixed edges
    fixed_edges = list(fixed_weights.keys())
    unfixed_edges = [e for e in edges if e not in fixed_edges]
    num_unfixed_edges = len(unfixed_edges)
    
    # Identify all possible weights and remove those used for fixed edges
    total_weights = set(range(1, len(edges) + 1))
    used_weights = set(fixed_weights.values())
    unused_weights = list(total_weights - used_weights)
    
    # Limit permutations to a smaller set
    all_weight_assignments = list(permutations(unused_weights))
    if len(all_weight_assignments) > max_samples:
        all_weight_assignments = sample(all_weight_assignments, max_samples)
    
    max_graph_value = 0
    max_assignments = []
    all_results = []

    for i, unfixed_assignment in enumerate(all_weight_assignments, start=1):
        edge_weights = {unfixed_edges[j]: unfixed_assignment[j] for j in range(num_unfixed_edges)}
        edge_weights.update(fixed_weights)
        
        graph_value = 0
        for tree in graph.spanning_trees():
            tree_product = 1
            for edge in tree.edges(labels=False):
                tree_product *= edge_weights[edge]
            graph_value += tree_product
        
        # Track all assignments and their graph values
        all_results.append((f"Permutation {i}", unfixed_assignment, edge_weights, graph_value))
        
        if graph_value > max_graph_value:
            max_graph_value = graph_value
            max_assignments = [(i, edge_weights)]  # Store both index and edge weights for max graph value
        elif graph_value == max_graph_value:
            max_assignments.append((i, edge_weights))  # Add to the list of max-value permutations
    
    # Return max graph value along with its corresponding edge weight assignments
    return max_graph_value, max_assignments

# Usage
#G = graphs.CompleteGraph(6)
G = Graph([(1,2), (2,3), (3,4), (4,5), (5,6), (6,1), (1,4)])
fixed_weights = {
    #(0, 1): 6, 
    #(0, 4): 8,
    #(1, 2): 7,
    #(3, 4): 9,
    #(2, 3): 10
}
# Usage example with sample limit
max_value, max_permutations = max_graph_value_and_assignments(G, fixed_weights, max_samples=5000)

print("Max Graph Value:", max_value)
print("Permutations with Max Graph Value:")
for perm_index, edge_weights in max_permutations:
    print(f"Permutation {perm_index}: Edge Weights - {edge_weights}")
