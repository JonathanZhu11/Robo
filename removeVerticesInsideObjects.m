% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function vertices = removeVerticesInsideObjects(vertices, objects)
    numObjects = length(objects);    
    for j = 1:numObjects
        obj = objects{j};
        [in, on] = inpolygon(vertices(:,1), vertices(:,2), obj(:,1), obj(:,2));
        corner = ismember(vertices, obj, 'rows');
        
        vertices(xor(in,corner),:) = [];
    end
end
