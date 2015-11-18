function path = dijkstra(start, goal, vertices, edges)
    numEdges = size(edges,1);
    distances = zeros(numEdges,1);
    for i=1:numEdges
        p1 = edges(1,:);
        p2 = edges(2,:);
        distances(i,1) = distance(p1, p2); 
    end
end