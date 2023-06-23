% Implementation of a PRM Algorithm: PRM_DEMO1.m 
% of size 10 by 10 squared meters. 

% Clear the workspace and close all figures
clear all;
clf;

% Load the map from the exampleMaps.mat file and store it in the "map" variable
load exampleMaps.mat
map = binaryOccupancyMap(complexMap,1);

% Display the map
figure(1);
show(map)
grid;

% Define the robot radius and create an inflated version of the map
robotRadius = 0.2;
mapInflated = copy(map);
inflate(mapInflated,robotRadius);

% Display the inflated map
figure(2);
show(mapInflated);
grid;

% Create an instance of the mobileRobotPRM class and set the inflated map as the map for the PRM object
% Specify the number of nodes and connection distance for the PRM
prm = mobileRobotPRM;
prm.Map = mapInflated;
prm.NumNodes = 138; 
prm.ConnectionDistance = 15;

% Define the start and end locations
startLocation = [3 3];
endLocation = [45 35];

% Use the findpath function to compute a path from the start to the end location using the PRM object
path = findpath(prm, startLocation, endLocation)

% Display the path on the map
show(prm)
