load('weightedGraphs4.sage')

#G1
G1 = graphs.CompleteGraph(6)
assign_weights(G1)
H1 = hamiltonian_cycles_with_weights(G1)
print("Number of distinct Hamiltonian cycles:", len(H1))
totSum1=0
for cycle, weights, product in H1:
    #print("Cycle:", cycle,"Weights:", weights,"Product of weights:", product)
    totSum1+=product
print("\nTotal Sum of Products:",totSum1)
print()
x1=product_of_edges_in_spanning_trees(G1)
print("Total graph value:",sum(x1))