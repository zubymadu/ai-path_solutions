load exampleMaps.mat % Load all pre-defined maps
% Create a variable 'map' and assigned to the simpleMap
map = binaryOccupancyMap(ternaryMap,1);
figure(1); % Create an empty figure
show(map) % Show the Maze
% by holding the figure, we can continue plotting on the top of the maze
hold on; 
% Set start and goal poses.
start = [5.0, 5.0,pi/4];
goal = [25, 5.0,-pi];
% Show start and goal positions of robot.
plot(start(1),start(2),'rs'); % Draw a small square
plot(goal(1),goal(2),'ms'); % Draw a small square
% Show start and goal headings.
r = 1;
plot([start(1),start(1) + r*cos(start(3))],[start(2),start(2) + r*sin(start(3))],'r-');
plot([goal(1),goal(1) + r*cos(goal(3))],[goal(2),goal(2) + r*sin(goal(3))],'m-');
hold off