# Name: Warvin Hassan
# Project: Graph Theory Project Week #7
# Instructor: Dr. Goyt
# Date: 10/16/2024 (Fall Semester)
##########################################################################
# This program will construct weighted graphs which ultilizes the weightedGraphs code from last week
# and works on specific cases by removing the pseudo-random integer generator. This also adds another function
# called "hamiltonian_cycles_with_weights"

import itertools
# Function to generate random integer weights for edges
def assign_weights(graph):
    weights = {}
    count= 1
    for edge in graph.edges():
        print("Weight:",count)
        count+=1
        w= int(input("Enter a weight: "))
        weights[edge] = w
    print("weights assigned.")
    print()
    print("weights ->",weights)
    print()
    # Set edge labels using set_edge_label in a loop
    # The way this works given a dictionary it looks at the key (edge) and then since this is a tuple it looks
    # at positon 0 and position 1 and assigns them via the set_edge_label function respectively, next it looks at the 
    # dictionary value (weight) and assigns that to set_edge_label in our case label is a weight
    # ex: weights = {(0,1): 3, (1,2): 8, (2,3): 1}, the for loop will go through this dictionary and assign the key and value respectively
    for edge, weight in weights.items():
        graph.set_edge_label(edge[0], edge[1], weight)

# Function to compute the product of edge weights for each spanning tree
def product_of_edges_in_spanning_trees(graph): 
    # Get all spanning trees
    spanning_trees = graph.spanning_trees()
    
    # Initialize a list to store products of edge weights for each spanning tree
    products = []
    
    # Iterate through each spanning tree
    for tree in spanning_trees:
        product = 1
        for edge in tree.edges():
            # Determine edge format and retrieve vertices
            u, v = edge[0], edge[1]  # Adjust according to actual edge format
       
            # Get the weight of the edge
            weight = graph.edge_label(u, v)  # Retrieve weight using edge_label
            product *= weight
        products.append(product)
    
    return products

# Function to calculate distinct Hamiltonian cycles of a complete graph and their edge weights
def hamiltonian_cycles_with_weights(graph):
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
