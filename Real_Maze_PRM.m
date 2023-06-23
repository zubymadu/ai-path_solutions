% Working on a real Maze
% Read the Maze image
maze=imread('Maze1.png');
    % Convert to a gray image
graymaze = rgb2gray(maze);
    % perform thresholding (to create a binary image)
bwimage = graymaze < 0.15;
% Convert to an occupancy map
map2= binaryOccupancyMap(bwimage);
% Display the map
figure(1)
show(map2)

pause;
startLocation = [700 50];
endLocation = [50 350];

hold on
plot(770, 50, '.r', 'MarkerSize',15)
plot(50, 250, '.b', 'MarkerSize',15)
% Inflating the Maze
robotRadius = 15 ;  %15
% Now Inflate the map with respect to Robot Size 
% First take a copy of the map
mapInflated = copy(map2);
inflate(mapInflated,robotRadius);
% Display the inflated map
figure(2)
show(mapInflated)


% For simplicity, lets call the 
% Inflated image: map3 
map3 = mapInflated;

% Save the random number generation settings using the rng function. 
% The saved settings enable you to reproduce the same points and 
% see the effect of changing ConnectionDistance.
rngState = rng;
% Create a roadmap with 100 nodes and calculate the path. 
% The default ConnectionDistance is set to inf.
prm = robotics.PRM(map3, 100);

path=[];    % Make sure the path is initially empty
% Now perform the path finding 
while isempty(path)
    % No feasible path found yet, increase the number of nodes
    prm.NumNodes = prm.NumNodes + 10;
 
    % Use the |update| function to re-create the 
    % PRM roadmap with the changed attribute
    update(prm);
 
    % Search for a feasible path with the updated PRM
    path = findpath(prm, startLocation, endLocation);
end
path = findpath(prm,startLocation,endLocation)
figure(3)
show(prm)


% In order to plot the path on the original 
% (before inflating) map
% the following is performed
% First plot the original map
figure(4);
show(map2);
hold on;
%Now plot the path with a red color thick line
plot(path(:,1), path(:,2), "Color",[1,0,0],"LineWidth",3);
hold off;

% Now Call My FollowPathRobot function to show
% The robot following the path
steps=5;
FollowPathRobot(path, map2, steps)


