% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

%start_goal is text file containing start and goal points
%environment is text file containing all obstacles of environment
function hwk4_team_15(start_goal, environment)
    ROOMBA_DIA = 0.35;
    %reading in values from start_goal.txt file
    fileID1=fopen(start_goal,'r');
    start_goal_data = fscanf(fileID1,'%f');
    fclose(fileID1);
    start_point = [start_goal_data(1) start_goal_data(2)];
    goal_point = [start_goal_data(3) start_goal_data(4)];
    
    %reading in values from environment.txt file
    fileID=fopen(environment,'r');
    data = fscanf(fileID,'%f');
    fclose(fileID);
    
    %number of obstacles in environment
    numObjects=data(1);
    
    vertices = [];
    objects={};
    grown_objects={};
    
    index=2;
    for i=1:numObjects
        size=data(index);
        vertices(i) = size;
        index=index+1;
        A = zeros(2);
        for j=1:size
            A(j,1)=data(index);
            A(j,2)=data(index+1);
            index=index+2;
        end
        %store each obstacle's points in a matrix within objects
        objects{i}=A;
        %grow obstacles
        grown_objects{i} = convexHull(A,ROOMBA_DIA/2);
    end
    
    %first obstacle --> environement wall
    boundary=objects{1};
    objects(1) = []; %remove wall from obstacles
    grown_objects(1) = []; % remove wall from grown_obstacles
    vertices(1) = [];

    %find visibility Graph
    [verts,edges] = visibilityGraph(start_point,goal_point,grown_objects);

    
    %%%%% GUI MAP DISPLAY %%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    map_out = figure('Name', 'Environment');    
    hold on;
    %map out the boundary
    fill(boundary(:,1),boundary(:,2),'w');
    %map out the objects in the map
    for i=1:numObjects-1
        grown_ob = grown_objects{i};
        fill(grown_ob(1:vertices(i),1),grown_ob(1:vertices(i),2),'y');
        ob=objects{i};
        fill(ob(1:vertices(i),1),ob(1:vertices(i),2),'g');
    end

    %map out all possible paths
%     for i=1:length(edges)
%         plot([edges(i,1),edges(i,2)],[edges(i,3),edges(i,4)],'r');
%     end

    %map start and end points
    plot(start_point(1), start_point(2), 'o', 'markersize', 15);
    plot(goal_point(1), goal_point(2), 'o', 'markersize', 15);
    camroll(90); %turn graph by 90degrees to match assignment pic

end

%grows each obstacle (X) by radius (r) of the roomba
function Xprime = convexHull(X, r)
%first append the last element to the front and the front element to the
%end
Xprime=X;
X = vertcat(X(length(X),:), X, X(1,:));

for i=2:length(X)-1
    phi = pi-atan2(X(i-1,2)-X(i,2),X(i-1,1)-X(i,1));
    Rot_phi = [cos(phi) -sin(phi); sin(phi) cos(phi)];
    nRot_phi = [cos(-phi) -sin(-phi); sin(-phi) cos(-phi)];
    newPnt = (Rot_phi*(X(i+1,:)-X(i,:))');
    theta = atan2(newPnt(2),newPnt(1));
    ro = -theta/2;
    nRot_ro = [cos(-ro) -sin(-ro); sin(-ro) cos(-ro)];
    Xprime(i-1,:) = [0, (-r/cos(theta/2))*sign(theta)];
    Xprime(i-1,:) = (nRot_phi*nRot_ro*Xprime(i-1,:)')';
    Xprime(i-1,:) = Xprime(i-1,:) + X(i,:);
end

end


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
        X = objects{i};
        X = vertcat(X(length(X),:), X);
        for j=2:length(X)
            vertices(length(vertices)+1,:)=X(j,:);
            polyEdges(length(polyEdges)+1,:,:)=X(j-1:j,:);
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
%     allEdges=allEdges(2:length(allEdges),:,:);
    
    edges = polyEdges;
    %check for visibility of all edges
    %add visible edges to output
    for i=1:length(allEdges)
        visible=1;
        for j=1:length(polyEdges)
            if(intersects(squeeze(allEdges(i,:,:)), squeeze(polyEdges(j,:,:)))==1)
            %if(intersects(allEdges(i,:,:),polyEdges(j,:,:))==1)
                visible=0;
            end
        end
        if(visible==1)
            edges(length(edges)+1,:,:)=allEdges(i,:,:);
        end
    end
        
end

function int = intersects(edge1, edge2)
    p = edge1(1,:);
    q = edge2(1,:);
    r = edge1(2,:)-p;
    s = edge2(2,:)-q;
    d = crossprod(r,s);
    if(d==0)
        int=0;
    else
        t = crossprod(q-p,s)/d;
        u = crossprod(q-p,r)/d;
        if(t>0 && t<1 && u>0 && u<1)
            int=1;
        else
            int=0;
        end
    end
end

function c = crossprod(x,y)
    c=x(1)*y(2)-x(2)*y(1);
end