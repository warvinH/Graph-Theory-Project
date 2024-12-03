# Name: Warvin Hassan
# Project: Graph Theory Project Week #8
# Instructor: Dr. Goyt
# Date: 10/23/2024 (Fall Semester)
##########################################################################
# This program returns all the permutations for 
# hamiltonian cycles for a complete graph and returns the results.

import itertools

# Function to automatically assign weights using all permutations
def perm_weights(graph):
    num_edges = graph.size()  # Get the number of edges in the graph
    weight_range = list(range(1, num_edges + 1))  # Generate weights from 1 to the number of edges
    
    # Get all permutations of the weight range
    weight_permutations = itertools.permutations(weight_range)
    
    all_cycle_data = []  # Store the Hamiltonian cycles for all weight permutations
    all_weight_data = []  # Store the weights for each permutation
    
    for perm in weight_permutations:
        # Assign weights to edges based on the current permutation
        weights = {}
        edges = graph.edges(labels=False)  # Get the edges of the graph without labels
        
        for edge, weight in zip(edges, perm):
            weights[edge] = weight
        
        # Assign the weights to the graph
        for edge, weight in weights.items():
            graph.set_edge_label(edge[0], edge[1], weight)
        
        # Calculate the Hamiltonian cycles with the assigned weights
        cycle_data = perm_cycles_with_weights(graph)
        
        # Add the result for this permutation and the weights used
        all_cycle_data.append(cycle_data)
        all_weight_data.append(weights)  # Store weights for the current permutation
    
    return all_cycle_data, all_weight_data

# Function to calculate distinct Hamiltonian cycles of a complete graph and their edge weights
def perm_cycles_with_weights(graph):
    vertices = graph.vertices()
    
    # Fix the first vertex to avoid generating the same cycle in different rotations
    first_vertex = vertices[0]
    
    # Get all permutations of the remaining vertices
    permuted_vertices = itertools.permutations(vertices[1:])
    
    hamiltonian_cycles = set()  # Use a set to automatically handle duplicates
    cycle_data = []  # List to store cycles with weights
    
    for perm in permuted_vertices:
        # Form the cycle with the fixed vertex
        cycle = [first_vertex] + list(perm) + [first_vertex]
        
        # Convert cycle to a tuple for hashing
        cycle_tuple = tuple(cycle)

        # To avoid duplicates, we consider the sorted version of the cycle (to keep the smallest lexicographically)
        # Also we add the reverse of the cycle, which helps in avoiding duplicates
        reversed_cycle = cycle_tuple[::-1]
        
        # We store the minimum representation of the cycle (either original or reversed)
        canonical_form = min(cycle_tuple, reversed_cycle)

        # If the canonical form is not already in the set, add it
        if canonical_form not in hamiltonian_cycles:
            hamiltonian_cycles.add(canonical_form)  
            
            # Get the weights of the edges in this cycle
            weights = []
            for i in range(len(cycle) - 1):
                u, v = cycle[i], cycle[i+1]
                # Retrieve the edge weight between vertices u and v
                weight = graph.edge_label(u, v)
                weights.append(weight)
            
            # Calculate the product and sum of weights
            product = 1
            for weight in weights:
                product *= weight
            
            # Store the cycle, weights, product, and sum
            cycle_data.append((canonical_form, weights, product))
    
    return cycle_data
