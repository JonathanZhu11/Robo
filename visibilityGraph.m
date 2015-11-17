function [vertices, edges] = visibilityGraph(start, goal, objects)
    %start is a point
    %goal is a point
    %objects is a cell array of polygons
    polyEdges = zeros(1,2,2);
    %1st index = edge index
    %2nd index = vertex index
    %3rd indec = x or y value
    vertices = zeros(2);
    vertices(1,:) = start;
    vertices(2,:) = goal;
    %generate a list of all vertices and polygon edges
    for i=1:length(objects)
        obj = objects{i};
        obj = vertcat(obj(length(obj),:), obj);
        for j=2:length(obj)
            vertices(length(vertices)+1,:)=obj(j,:);
            polyEdges(length(polyEdges)+1,:,:)=obj(j-1:j,:);
        end
    end
    allEdges = zeros(0,2,2);
    %generate a list of all possible edges
    for i=1:length(vertices);
        for j=i+1:length(vertices);
            allEdges(length(allEdges)+1,1,:)=vertices(i,:);
            allEdges(length(allEdges)+1,2,:)=vertices(j,:);
        end
    end
    
    edges = polyEdges;
    %check for visibility of all edges
    %add visible edges to output
    for i=1:length(allEdges)
        visible=1;
        for j=1:length(polyEdges)
            if(intersects(squeeze(allEdges(i,:,:)), squeeze(polyEdges(j,:,:)))==1)
                visible=0;
            end
        end
        if(visible==1)
            edges(length(edges)+1,:,:)=allEdges(i,:,:);
        end
    end
end