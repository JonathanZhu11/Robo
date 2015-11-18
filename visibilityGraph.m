%start is a point
%goal is a point
%objects is a cell array of polygons
function [vertices, edges] = visibilityGraph(start, goal, objects)
    numObjects = length(objects);
    polygonEdges = zeros(1,2,2);
    %1st index = edge index
    %2nd index = vertex index
    %3rd indec = x or y value
    vertices = zeros(numObjects+2, 2);
    vertices(1,:) = start;
    vertices(2,:) = goal;
    %generate a list of all vertices and polygon edges
    sizePoly=1;
    sizeVert=3;
    for i=1:numObjects
        obj = objects{i};
        obj = vertcat(obj(length(obj),:), obj);
        for j=2:length(obj)
            vertices(sizeVert,:)=obj(j,:);
            polygonEdges(sizePoly,:,:)=obj(j-1:j,:);
            sizeVert=sizeVert+1;
            sizePoly=sizePoly+1;
        end
    end
    
    allEdges = findAllEdges(vertices);
    
    edges = polygonEdges;
    %check for visibility of all edges
    %add visible edges to output
    for i=1:length(allEdges)
        visible=1;
        for j=1:length(polygonEdges)
            if(intersects(squeeze(allEdges(i,:,:)),squeeze(polygonEdges(j,:,:)))==1)
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