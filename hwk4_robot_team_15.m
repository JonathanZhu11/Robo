% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 - robot Solution

function hw4_robot_team_15(serPort)
angThresh=pi/60;
distThresh = 0.2;
points_file = [0.58 -3.107;0.58 -0.5;2 1;2 5;-0.03 10.657];
current_pos = points_file(1,:);
goal_pos = points_file(length(points_file),:);
vertices = points_file(2:length(points_file),:);
%take current angle from bot and adjust to facing y-axis.
current_angle = AngleSensorRoomba(serPort)+pi/2;

state = 0;

%go from vertex to vertex until goal_pos
while(1)
    pause(0.1);
    
    [ BumpRight, BumpLeft, ~, ~, ~, BumpFront] =...
        BumpsWheelDropsSensorsRoomba(serPort);
    [wall_sensor] = WallSensorReadRoomba(serPort);
    
    distance = DistanceSensorRoomba(serPort);
    Deltangle = AngleSensorRoomba(serPort);
    
    %adjust position/angle
    current_angle = current_angle+Deltangle;
    current_pos = current_pos+[cos(current_angle)*distance sin(current_angle)*distance];
    current_pos
    %check whether reached goal
    if(sqrt(sum((current_pos-goal_pos).^2))<distThresh)
        SetFwdVelAngVelCreate(serPort, 0, 0);
        disp('Done');
        return;
    end
    next=vertices(1,:);
    if(state==0)
        %check whether reached next vertex
        if(sqrt(sum((current_pos-next).^2))<distThresh)
            SetFwdVelAngVelCreate(serPort, 0, 0);
            vertices(1,:)=[];
            disp('Reached next checkpoint');
            state = 1;
        else
            SetFwdVelAngVelCreate(serPort,0.2,0);
        end
    end
    
    %face next checkpoint
    if(state==1)
        next=vertices(1,:);
        current_pos
        next
        target = angleToGoal(current_pos, next);
        target
        current_angle
        angDist = mod(target-current_angle, 2*pi);
        disp(angDist);
        disp(angThresh);
        if(angDist<angThresh)
            SetFwdVelAngVelCreate(serPort, 0, 0);
            disp('finished turning');
            state=0;
        else
            %scale rotation speed so it slows as it approaches target
            SetFwdVelAngVelCreate(serPort, 0, 0.1+angDist/3);
        end
    end
end
end

%gets necessary angle to face goal
%takes position[x y] and goal[x y]
function angle = angleToGoal(position, goal)
x = goal(1)-position(1);
y = goal(2)-position(2);
angInternal = atan(y/x);
if(x<0)
    if(y<0)
        angle = angInternal-pi;
    elseif(y>0)
        angle = angInternal+pi;
    else
        angle = pi;
    end
else
    angle = angInternal;
end

end
