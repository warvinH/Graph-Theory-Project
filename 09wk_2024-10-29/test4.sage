from itertools import permutations

def max_graph_value_and_assignments(graph, max_weight):
    edges = list(graph.edges(labels=False))
    num_edges = len(edges)
    
    # Generate all permutations of weights (from 1 to max_weight)
    all_weight_assignments = list(permutations(range(1, num_edges + 1)))
    
    max_graph_value = 0
    max_assignments = []  # To store permutation numbers with max value
    all_results = []
    
    for i, assignment in enumerate(all_weight_assignments, start=1):
        # Assign weights to edges based on the order in `edges`
        edge_weights = {edges[j]: assignment[j] for j in range(num_edges)}
        
        # Calculate the graph value for this assignment
        graph_value = 0
        for tree in graph.spanning_trees():
            tree_product = 1
            for edge in tree.edges(labels=False):
                tree_product *= edge_weights[edge]
            graph_value += tree_product
        
        # Track all assignments and their graph values with labels
        all_results.append((f"Permutation {i}", assignment, edge_weights, graph_value))
        
        # Update max graph value and track all permutations with this max value
        if graph_value > max_graph_value:
            max_graph_value = graph_value
            max_assignments = [i]  # Reset with the current permutation
        elif graph_value == max_graph_value:
            max_assignments.append(i)  # Add to list of max-value permutations
    
    return max_graph_value, max_assignments, all_results

# OUTPUT
G = graphs.CompleteGraph(4)  # Example graph, replace with your specific graph
max_weight = 10            # Define max weight according to the number of edges
max_value, max_permutations, all_assignments = max_graph_value_and_assignments(G, max_weight)

print("Max Graph Value:", max_value)
print("Permutations with Max Graph Value:", max_permutations)
print("All Assignments and Values:")
for label, assignment, edge_weights, value in all_assignments:
    print(f"{label}: {assignment} with Graph Value = {value}")
    print("Edge weights:", edge_weights)
    print()
