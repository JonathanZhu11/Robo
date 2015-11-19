% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

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