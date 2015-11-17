function edges = findAllEdges(vertices)
    [numPoints, dim] = size(unique(vertices,'rows'));
    C = nchoosek(1:numPoints,2);
    numEdges = size(C,1);
    edges = zeros(numEdges, dim, 2);

    for i=1:numEdges
        vertices(C(i),:);
        edges(i,:,1) = vertices(C(i,1),:);
        edges(i,:,2) = vertices(C(i,2),:);
    end
end