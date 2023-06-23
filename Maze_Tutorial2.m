% Load all pre-defined maps
load exampleMaps.mat

% Create a variable 'map' and assigned to the simpleMap
map = binaryOccupancyMap(simpleMap,2);

% Create an empty figure and show the map
figure(1);
show(map);

% Hold the figure so we can continue plotting on the top of the map
hold on;

% A Program for a robot to follow a path
path = [2.00 1.00; 1.25 1.75; 5.25 8.25; 7.25 8.75; 11.75 10.75; 12.00 10.00];

% Set start and goal poses.
% Calculate the starting pose
midpoint = size(path, 1) / 2;
sp = atan2(path(midpoint+1,2) - path(midpoint,2), path(midpoint+1,1)-path(midpoint,1));

% Calculate the goal pose
gp = atan2(path(end,2) - path(end-1,2), path(end,1)-path(end-1,1));

% Now define the Starting and goal coordinates and pose
start = [path(midpoint,1), path(midpoint,2), sp];
goal = [path(end,1), path(end,2), gp];

% Show start and goal positions of robot.
plot(start(1),start(2),'ro','LineWidth',2); % Draw a small circle
plot(goal(1),goal(2),'mo', 'LineWidth',2); % Draw a small circle

% Show start and goal headings.
r = 0.5;
plot([start(1),start(1) + r*cos(start(3))],[start(2),start(2) + r*sin(start(3))],'r-','LineWidth',2);
plot([goal(1),goal(1) + r*cos(goal(3))],[goal(2),goal(2) + r*sin(goal(3))],'m-','LineWidth',2);

% Now plot the path on the maze
plot(path(:,1), path(:,2),'k--d')

% Calculate the distance that the robot needs to travel segment by segment
totalDistance = 0; % Initialize the total distance to zero
for i = 1:size(path,1)-1 % Iterate through each pair of consecutive points in the path
    % Calculate the distance between the current pair of points using the euclidean distance formula
    segmentDistance = sqrt((path(i+1,1)-path(i,1))^2 + (path(i+1,2)-path(i,2))^2);
    % Add the segment distance to the total distance
    totalDistance = totalDistance + segmentDistance;
end

% Print the total distance that the robot needs to travel
fprintf('Total distance: %.2f metres', totalDistance);
