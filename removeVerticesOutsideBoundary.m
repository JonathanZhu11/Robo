% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function vertices = removeVerticesOutsideBoundary(vertices, boundary)
    
    [in, on] = inpolygon(vertices(:,1), vertices(:,2), boundary(:,1), boundary(:,2));
    corner = ismember(vertices, boundary, 'rows');
    
    vertices(~in,:) = [];
end
