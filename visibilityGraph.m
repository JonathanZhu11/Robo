%start is a point
%goal is a point
%objects is a cell array of polygons
function [vertices, edges] = visibilityGraph(start, goal, objects)
    numObjects = length(objects);
    polygonEdges = cell(1,1);
    %1st index = edge index
    %2nd index = vertex index
    %3rd index = x or y value
    vertices = zeros(numObjects+2, 2);
    vertices(1,:) = start;
    vertices(2,:) = goal;
    %generate a list of all vertices and polygon edges
    sizePoly=1;
    sizeVert=3;
    for i=1:numObjects
        obj = objects{i};
        obj = vertcat(obj(length(obj),:), obj);
        disp(obj);
        for j=1:length(obj)-1
            vertices(sizeVert,:)=obj(j,:);
            polygonEdges{sizePoly}=obj(j:j+1,:);
            sizeVert=sizeVert+1;
            sizePoly=sizePoly+1;
        end
    end
    disp(vertices);
    allEdges = findAllEdges(vertices);
    edges = polygonEdges;
    %check for visibility of all edges
    %add visible edges to output
    for i=1:length(allEdges)
        visible=1;
        for n=1:length(polygonEdges)
            for j=1:length(polygonEdges{n})
                if(intersects(allEdges{i},polygonEdges{j})==1)
                    visible=0;
                elseif(insideObject(allEdges{i},objects)==1)
                    visible=0;
                end
            end
        end
        if(visible==1)
            edges{length(edges)+1}=allEdges{i};
        end
    end
    
    for i=1:length(edges)
        disp(edges{i})
    end
    
        
end