function vertices = removeVerticesOutsideBoundary(vertices, boundary)
    
    [in, on] = inpolygon(vertices(:,1), vertices(:,2), boundary(:,1), boundary(:,2));
    corner = ismember(vertices, boundary, 'rows');
    vertices(xor(~in,corner),:) = [];
end
