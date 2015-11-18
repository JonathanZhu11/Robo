%start is a point
%goal is a point
%objects is a cell array of polygons
function [vertices, edges] = visibilityGraph(start, goal, objects)
    
    precision = 0.0001;
    
    boundary = objects{1};
    boundary = roundto(boundary, precision);
    
    numObjects = length(objects);
    polygonEdges = cell(1,1);
    
    vertices = zeros(numObjects+2, 2);
    vertices(1,:) = start;
    vertices(2,:) = goal;
    
    %generate a list of all vertices and polygon edges
    sizePoly=1;
    sizeVert=3;
    
    for i=1:numObjects
        obj = objects{i};
        objects{i} = roundto(obj, precision);
        obj = vertcat(obj(length(obj),:), obj);
     
        for j=1:length(obj)-1
            vertices(sizeVert,:)=obj(j,:);
            polygonEdges{sizePoly}=obj(j:j+1,:);
            sizeVert=sizeVert+1;
            sizePoly=sizePoly+1;
        end
    end
    
    vertices = roundto(vertices, precision);
    vertices = removeVerticesInsideObjects(vertices, objects(2:end));
    vertices = removeVerticesOutsideBoundary(vertices, boundary);
    
    allEdges = findAllEdges(vertices);
    
    edges = {};
    
    %check for visibility of all edges
    %add visible edges to output
    edges = {};
    for i=1:length(polygonEdges)
        polygonEdges{i} = roundto(polygonEdges{i}, precision);
        visible=1;
        for n=2:length(polygonEdges)
            polygonEdges{n} = roundto(polygonEdges{n}, precision);
            if(intersects(polygonEdges{i},polygonEdges{n})==1)
                visible=0;
            end
        end
        if(visible==1)
            edges{length(edges)+1}=polygonEdges{i};
        end
    end
    
    
    
    for i=1:length(allEdges)
        allEdges{i} = roundto(allEdges{i}, precision);
        visible=1;
        for n=1:length(polygonEdges)
            polygonEdges{n} = roundto(polygonEdges{n}, precision);
            if(intersects(allEdges{i},polygonEdges{n})==1)
                visible=0;
            elseif(insideObject(allEdges{i},objects)==1)
                visible=0;
            end
        end
        if(visible==1)
            edges{length(edges)+1}=allEdges{i};
        end
    end
%     edges = allEdges;
end


function xround = roundto(x, d)
if d<= 0, error('Error: Rounding precision must be > 0'); end
xround = round(x/d)*d;
end