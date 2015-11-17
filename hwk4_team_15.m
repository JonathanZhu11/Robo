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
    startGoalData = fscanf(fileID1,'%f');
    fclose(fileID1);
    start = [startGoalData(1) startGoalData(2)];
    goal = [startGoalData(3) startGoalData(4)];
    
    %reading in values from environment.txt file
    fileID=fopen(environment,'r');
    data = fscanf(fileID,'%f');
    fclose(fileID);
    
    %number of obstacles in environment
    numObjects=data(1);
    vertices = zeros(1,numObjects);
    objects=cell(1,numObjects);
    grownObjects=cell(1,numObjects);
    
    index=2;
    for i=1:numObjects
        size=data(index);
        vertices(1,i) = size;
        index=index+1;
        A = zeros(2);
        for j=1:size
            A(j,1)=data(index);
            A(j,2)=data(index+1);
            index=index+2;
        end
        %store each obstacle's points in a matrix within objects
        objects{1,i}=A;
        %grow obstacles
        grownObjects{1,i} = convexHull(A,ROOMBA_DIA/2);
    end
    
    %first obstacle --> environement wall
    boundary=objects{1,1};
    objects(1) = []; %remove wall from obstacles
    grownObjects(1) = []; % remove wall from grown_obstacles
    vertices(1) = [];

    %find visibility Graph
    [verts,edges] = visibilityGraph(start,goal,grownObjects);

    
    %%%%% GUI MAP DISPLAY %%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    map_out = figure('Name', 'Environment');    
    hold on;
    %map out the boundary
    fill(boundary(:,1),boundary(:,2),'w');
    %map out the objects in the map
    for i=1:numObjects-1
        grown_ob = grownObjects{i};
        fill(grown_ob(1:vertices(i),1),grown_ob(1:vertices(i),2),'y');
        ob=objects{i};
        fill(ob(1:vertices(i),1),ob(1:vertices(i),2),'g');
    end

    %map out all possible paths
%     for i=1:length(edges)
%         plot([edges(i,1),edges(i,2)],[edges(i,3),edges(i,4)],'r');
%     end

    %map start and end points
    plot(start(1), start(2), 'o', 'markersize', 15);
    plot(goal(1), goal(2), 'o', 'markersize', 15);
    camroll(90); %turn graph by 90degrees to match assignment pic

end
