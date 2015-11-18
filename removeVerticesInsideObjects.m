function vertices = removeVerticesInsideObjects(vertices, objects)
    numObjects = length(objects);    
    for j = 1:numObjects
        obj = objects{j};
        [in, on] = inpolygon(vertices(:,1), vertices(:,2), obj(:,1), obj(:,2));
        corner = ismember(vertices, obj, 'rows');
        
        vertices(xor(in,corner),:) = [];
    end
end
