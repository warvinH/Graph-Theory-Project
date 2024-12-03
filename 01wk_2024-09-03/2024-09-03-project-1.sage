# Name: Warvin Hassan
# Project: Graph Theory Project Assignment #1
# Instructor: Dr. Goyt
# Date: 09/03/2024 (Fall Semester)
##########################################################################
# This program utilizes sage and its vast libary to compute and find a given graph's number of spanning trees.
# Here is the process as follows:
# 1. Define the graph
# 2. Compute as Laplacian matrix
# 3. Find number of spanning trees using Kirchhoff's theorem
# Some references:
# https://en.wikipedia.org/wiki/Laplacian_matrix
# https://en.wikipedia.org/wiki/Kirchhoff%27s_theorem
# https://www.geeksforgeeks.org/spanning-tree/
##########################################################################
# Defining the graph (example used is a triangle with 3 vertices)
G = Graph([(0, 1), (1, 2), (2, 0)])

# Computing the Laplacian matrix
#
# The Laplacian matrix is defined as L = D - A, where D is the degree matrix 
# (a diagonal matrix of vertex degrees) and A is the adjacency matrix of the graph.
#
# The diagonal of the matrix contains the number of connecting edges to each given vertex
# non-diagonal elements are -1 if the respective vertex position is adjacent to the other respective vertex
# otherwise the element is 0.
L = G.laplacian_matrix()
#
# This will give the Laplacian matrix of the graph. For a triangle, it should look like this:
print("Laplacian Matrix:")
print(L)

# Using Kirchhoff's theorem to find the number of spanning trees
#
# To find the number of spanning trees, we need to 
# compute the determinant of a cofactor of the Laplacian matrix.
#
# Definition: "A spanning tree is a subset of Graph G, such that all the vertices are connected using minimum possible number of edges. 
# Hence, a spanning tree does not have cycles and a graph may have more than one spanning tree."
#
num_spanning_trees = G.spanning_trees_count()
print("Number of spanning trees:", num_spanning_trees)

# Plot and save the graph as an image file (e.g., PNG)
G.plot().save("graph.png")

# Display the graph with a specific layout (e.g., circular layout)
# G.show(layout="circular", vertex_size=500, vertex_labels=True, edge_labels=False)


# Some more examples with different graphs
#
print("\nOther Examples:")
print("#"*30)

# G1- K4 graph
G1 = Graph([(0,1), (0,2), (0,3), (1,2), (1,3), (2,3)])
print("K4 Graph:")
print(G1.laplacian_matrix())
print("#SpanningTs: ", G1.spanning_trees_count())
G1.plot().save("K4.png")
print()
# G2- Petersen graph
G2 = graphs.PetersenGraph()
print("Petersen's Graph:")
print(G2.laplacian_matrix())
print("#SpanningTs: ", G2.spanning_trees_count())
G2.plot().save("Pete.png")
print()
# G3- a cycle with an extra edge
G3 = Graph([(0,1),(0,2),(0,3),(1,3),(2,3)])
print("A Cycle with one extra edge:")
print(G3.laplacian_matrix())
print("#SpanningTs: ", G3.spanning_trees_count())
G3.plot().save("xtraEdge.png")
print()
# G4- another cycle with an extra edge
G4 = Graph([(0,1),(0,2),(0,3),(1,3),(4,2),(4,3)])
print("A Cycle with one extra edge:")
print(G4.laplacian_matrix())
print("#SpanningTs: ", G4.spanning_trees_count())
G4.plot().save("xtraEdge2.png")