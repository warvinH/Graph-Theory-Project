# Name: Warvin Hassan
# Project: Graph Theory Project Week #3
# Instructor: Dr. Goyt
# Date: 09/17/2024 (Fall Semester)
##########################################################################
# This program will construct weighted graphs which ultilizes the weightedGraphs code from last week
# and works on specific cases by removing the pseudo-random integer generator.

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