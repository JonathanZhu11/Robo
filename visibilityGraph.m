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
    sizePoly=1;
    sizeVert=3;
    for i=1:length(objects)
        X = objects{i};
        X = vertcat(X(length(X),:), X);
        for j=2:length(X)
            vertices(sizeVert,:)=X(j,:);
            polyEdges(sizePoly,:,:)=X(j-1:j,:);
            sizeVert=sizeVert+1;
            sizePoly=sizePoly+1;
        end
    end
    allEdges = zeros(1,2,2);
    %generate a list of all possible edges
    sizeAll=1;
    for i=1:length(vertices);
        for j=i+1:length(vertices);
            allEdges(sizeAll,1,:)=vertices(i,:);
            allEdges(sizeAll,2,:)=vertices(j,:);
            sizeAll=sizeAll+1;
        end
    end
    edges = polyEdges;
    %check for visibility of all edges
    %add visible edges to output
    for i=1:length(allEdges)
        visible=1;
        for j=1:length(polyEdges)
            if(intersects(squeeze(allEdges(i,:,:)),squeeze(polyEdges(j,:,:)))==1)
                visible=0;
            elseif(insideObject(squeeze(allEdges(i,:,:)),objects)==1)
                visible=0;
            end
        end
        if(visible==1)
            edges(length(edges)+1,:,:)=allEdges(i,:,:);
        end
    end
        
end