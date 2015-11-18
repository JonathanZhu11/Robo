% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

%start_goal is text file containing start and goal points
%environment is text file containing all obstacles of environment

function hwk4_team_15(start_goal, environment)
    tic
    ROOMBA_DIA = 0.35;
    
    %read in values from start_goal.txt file
    fileID1=fopen(start_goal,'r');
    startGoalData = fscanf(fileID1,'%f');
    fclose(fileID1);
    
    start = [startGoalData(1) startGoalData(2)];
    goal = [startGoalData(3) startGoalData(4)];
    
    %read in values from environment.txt file
    fileID=fopen(environment,'r');
    envData = fscanf(fileID,'%f');
    fclose(fileID);
    
    %number of obstacles in environment
    numObjects = envData(1);
    %objectData = objectData(2:end);
    
    numVertices = zeros(numObjects,1);
    objects = cell(numObjects,1);
    grownObjects = cell(numObjects,1);
    
    index=2;
    for i=1:numObjects
        objectSize = envData(index);
        numVertices(i,1) = objectSize;
        index = index+1;
        
        obj = zeros(2);
        for j=1:objectSize
            obj(j,1)=envData(index);
            obj(j,2)=envData(index+1);
            index=index+2;
        end
        %store each obstacle's points in a matrix within objects
        objects{i,1}=obj;
        %grow obstacles
        if i ~= 1
            grownObjects{i,1} = convexHull(obj,ROOMBA_DIA/2);
        end
    end
    
    %first obstacle --> environement wall
    boundary = objects{1,1};
     grownObjects{1} = boundary;

    %find visibility Graph
    [verts,edges] = visibilityGraph(start,goal,grownObjects);
    
    %%%%% GUI MAP DISPLAY %%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    map_out = figure('Name', 'Environment');    
    hold on;
    
    %map out the boundary
    fill(boundary(:,1),boundary(:,2),'w');
    
    %map out the objects in the map
    for i=2:numObjects
        grown_ob = grownObjects{i};
        fill(grown_ob(1:numVertices(i),1),grown_ob(1:numVertices(i),2),'y');
        ob=objects{i};
        fill(ob(1:numVertices(i),1),ob(1:numVertices(i),2),'g');
    end

    %map out all possible paths
    
     for i=1:length(edges)
         plot([edges{i}(1,1),edges{i}(2,1)],[edges{i}(1,2),edges{i}(2,2)],'r');
     end

    %map start and end points
    plot(start(1), start(2), 'o', 'markersize', 15);
    plot(goal(1), goal(2), 'o', 'markersize', 15);
    camroll(90); %turn graph by 90degrees to match assignment pic

toc
end
