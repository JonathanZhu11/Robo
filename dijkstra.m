function path = dijkstra(start, goal, vertices, edges)
    path = zeros(0,2);
    
    %The following matrices contain this info:
    %column 1,2=x,y values of the point
    %column 3=tentative marker distance
    %column 4=tentative predecessor index in the chain
    %column 5=visited marker
    m(1:length(vertices),1)=inf;
    n(1:length(vertices),1)=-1;
    v = zeros(length(vertices),1);
    vnodes=horzcat(vertices,m,n,v);
    
    
    %find start point and set its marker to 0
    sIndex=findIndex(start,vnodes(:,1:2));
    vnodes(sIndex,3)=0;
    
    while(1)
        [mVal,cIndex]=minNodes(vnodes);
        %check stopping conditions
        if(vEquals(goal,vnodes(cIndex,1:2)))
            break;
        end
        if(mVal==inf)
            break;
        end
        
        %find neighbors and set tentative values
        neighbors=findNeighbors(vnodes(cIndex,1:2),edges);
        for i=1:size(neighbors,1)
            nIndex=findIndex(neighbors(i,:),vnodes(:,1:2));
            %check if visited
            if(vnodes(nIndex,5)==0)
                %get distance from current node
                dist=distance(vnodes(cIndex,1:2),neighbors(i,:));
                dist=dist+vnodes(cIndex,3);
                %update values if necessary
                if(dist<vnodes(nIndex,3))
                    vnodes(nIndex,3)=dist; %set tentative dist
                    vnodes(nIndex,4)=cIndex; %set tentative predecessor
                end
            end
        end
        %mark node as visited
        vnodes(cIndex,5)=1;
    end
    
    %get goal index
    gIndex=findIndex(goal,vnodes(:,1:2));
    if(vnodes(gIndex,4)==-1)
        return;
    end
    %generate path from predecessor chain
    while(1)
        path(size(path,1)+1,:)=vnodes(gIndex,1:2);
        if(vnodes(gIndex,4)==-1)
            break;
        end
        gIndex=vnodes(gIndex,5);
    end
    
    path=flipud(path);
       
end

function result=vEquals(v1,v2)
    result=0;
    diff=v1-v2;
    if(sum(diff.^2)<0.0001)
        result=1;
    end
end

function ind=findIndex(vec,list)
    ind=-1;
    for i=1:size(list,1)
        if(vEquals(vec,list(i,:)))
            ind=i;
            return;
        end
    end
end

function [m,index]=minNodes(nodes)
    m=inf;
    index=-1;
    for i=1:size(nodes,1)
        if(nodes(i,5)==0)
            if(nodes(i,3)<m)
                m=nodes(i,3);
                index=i;
            end
        end
    end
end

function neighbors=findNeighbors(point,edges)
    neighbors=zeros(0,2);
    size=1;
    for i=1:length(edges)
        p1=edges{i}(1,:);
        p2=edges{i}(2,:);
        if(vEquals(point,p1))
            neighbors(size,:)=p2;
            size=size+1;
        elseif(vEquals(point,p2))
            neighbors(size,:)=p1;
            size=size+1;
        end
    end
end