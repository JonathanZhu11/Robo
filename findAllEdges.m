function edges = findAllEdges(vertices)
    numVerts = length(vertices);
    numEdges = nchoosek(numVerts,2);

    edges=cell(numEdges,1);
    index=1;
    for i=1:numVerts
        for j=i+1:numVerts
            edges{index}=[vertices(i,:);vertices(j,:)];
            index=index+1;
        end
    end
end