% Implementation of a PRM Algorithm: PRM_DEMO1.m 
% of size 10 by 10 squared meters. 

% Clear the workspace and close all figures
clear all;
clf;

% Working on a real Maze
% Read the Maze image
maze=imread('Maze1.png');
% Convert to a gray image
graymaze = rgb2gray(maze);
% perform thresholding (to create a binary image)
bwimage = graymaze < 0.5;
% Convert to an occupancy map
map2= binaryOccupancyMap(bwimage);
% Display the map
figure(1)
show(map2)

% Define the robot radius and create an inflated version of the map
robotRadius = 0.2;
mapInflated = copy(map2);
inflate(mapInflated,robotRadius);

% Display the inflated map
figure(2);
show(mapInflated);
grid;

% Set the initial number of nodes and connection distance for the PRM
numNodes = 50;
connectionDistance = 15;

% Create an instance of the mobileRobotPRM class and set the inflated map as the map for the PRM object
prm = mobileRobotPRM;
prm.Map = mapInflated;

% Define the start and end locations
startLocation = [700 50];
endLocation = [50 250];

% Set a flag to indicate whether a suitable path has been found
pathFound = false;

% Loop until a suitable path is found
while ~pathFound
    
    % Set the number of nodes and connection distance for the PRM
    prm.NumNodes = numNodes;
    prm.ConnectionDistance = connectionDistance;
    
    % Use the findpath function to compute a path from the start to the end location using the PRM object
    path = findpath(prm, startLocation, endLocation);
    
    % Check if a valid path was found
    if ~isempty(path)
        % A valid path was found, so set the flag to true and exit the loop
        pathFound = true;
    else
        % A valid path was not found, so increase the number of nodes and try again
        numNodes = numNodes + 50;
    end
    
end
path = findpath(prm, startLocation, endLocation)
% Display the final value of the number of nodes and the path on the map
disp(['Final number of nodes: ' num2str(numNodes)])
show(prm)
