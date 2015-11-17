% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

%start_goal is text file containing start and goal points
%environment is text file containing all obstacles of environment
function hwk4_team_15(start_goal, environment)

%reading in values from .txt files
fileID1=fopen(start_goal,'r');
start_goal_data = fscanf(fileID1,'%f');
fclose(fileID1);
start_point = [start_goal_data(1) start_goal_data(2)];
goal_point = [start_goal_data(3) start_goal_data(4)];
fileID=fopen(environment,'r');
data = fscanf(fileID,'%f');
fclose(fileID);
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
    objects{i}=A;
    grown_objects{i} = convexHull(A,0.35);
end
boundary=objects{1};
objects(1) = [];
grown_objects(1) = [];
vertices(1) = [];

map_out = figure('Name', 'Environment');    
hold on;
%map out the boundary
fill(boundary(:,1),boundary(:,2),'w');
%map out the objects in the map
for i=1:numObjects-1
    grown_ob = grown_objects{i};
    fill(grown_ob(1:vertices(i),1),grown_ob(1:vertices(i),2),'r');
    ob=objects{i};
    fill(ob(1:vertices(i),1),ob(1:vertices(i),2),'b');
end
plot(start_point(1), start_point(2), 'o', 'markersize', 15);
plot(goal_point(1), goal_point(2), 'o', 'markersize', 15);
camroll(90);

end

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