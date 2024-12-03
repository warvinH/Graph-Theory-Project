load('weightedGraphs2.sage')

# ex: edges = [(1,2),(2,3),(1,3)]
c_3 = [(1,2), (2,3), (3,1)]
c_4 = [(1,2), (2,3), (3,4), (4,1)]
c_5 = [(1,2), (2,3), (3,4), (4,5), (5,1)]
c_4plus1 = [(1,2), (2,3), (3,4), (4,1), (1,3)]
c_5plus1 = [(1,2), (2,3), (3,4), (4,5), (5,1), (4,1)]
c_5plus1_alt = [(1,2), (2,3), (3,4), (4,5), (5,1), (4,2)]
c_6plus1 = [(1,2), (2,3), (3,4), (4,5), (5,6), (6,1), (1,4)]
c_6plus1_alt = [(1,2), (2,3), (3,4), (4,5), (5,6), (6,1), (1,3)]
c_6plus1_alt2 = [(1,2), (2,3), (3,4), (4,5), (5,6), (6,1), (1,5)]
k_4=[(1,2),(1,3),(1,4),(2,3),(2,4),(3,4)]#6
k_5=[(1,2),(1,3),(1,4),(1,5),(2,3),(2,4),(2,5),(3,4),(3,5),(4,5)]#10
k_6=[(1,2),(1,3),(1,4),(1,5),(1,6),(2,3),(2,4),(2,5),(2,6),(3,4),(3,5),(3,6),(4,5),(4,6),(5,6)]#15
x_5=[(1,2),(1,5),(2,3),(2,5),(3,4),(3,5),(4,5)]
#graphs.PetersenGraph()#petersen graph

#G1
print("Graph 1:")
G1 = Graph(k_5) # Change graph 1 <-------
#G1 = graphs.PetersenGraph() # PETERSEN 1
assign_weights(G1)
# Display matrix-tree
print(G1.laplacian_matrix())
print("#SpanningTs: ", G1.spanning_trees_count())
# Print the edge weights
print(f"Edge weights: {G1.edge_labels()}")
# Get the product of edge weights for each spanning tree
products1 = product_of_edges_in_spanning_trees(G1)
# Display the products
print(f"Products of edge weights for each spanning tree: {products1}")
print(f"Sum of the products: {sum(products1)}")
# plot
plotG1 = G1.plot()
plotG1.save("week3G1.png")
print()

#G2
print("Graph 2:")
G2 = Graph(k_5) # Change graph 2 <-------
#G2 = graphs.PetersenGraph() # PETERSEN 2
assign_weights(G2)
# Display matrix-tree
print(G2.laplacian_matrix())
print("#SpanningTs: ", G2.spanning_trees_count())
# Print the edge weights
print(f"Edge weights: {G2.edge_labels()}")
# Get the product of edge weights for each spanning tree
products2 = product_of_edges_in_spanning_trees(G2)
# Display the products
print(f"Products of edge weights for each spanning tree: {products2}")
print(f"Sum of the products: {sum(products2)}")
# plot
plotG2 = G2.plot()
plotG2.save("week3G2.png")
print() 