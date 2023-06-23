% First Step is to create a State-Space Variable
ss = stateSpaceSE2;

% Next, Create an occupancyMap-based state validator using the 
% created state space.
sv = validatorOccupancyMap(ss);

% Read the Maze image
maze=imread('Maze1.png');

% Convert to a gray image
graymaze = rgb2gray(maze);

% Perform thresholding (to create a binary image)
bwimage = graymaze < 0.5;

% Convert to an occupancy map
map2 = binaryOccupancyMap(bwimage);

% Display the map
figure(1)
show(map2)

% Define the robot radius and create an inflated version of the map
robotRadius = 0.2;
mapInflated = copy(map2);
inflate(mapInflated, robotRadius);

% Display the inflated map
figure(2);
show(mapInflated);
grid;

% Assign the inflated map to the validator
sv.Map = mapInflated;

% Set validation distance for the validator
sv.ValidationDistance = 0.01;

% Update state space bounds to be the same as map limits
ss.StateBounds = [map2.XWorldLimits; map2.YWorldLimits; [-pi pi]];

% Create RRT* path planner and allow further optimization after goal 
% is reached. Reduce the maximum iterations and increase the maximum 
% connection distance.
planner = plannerRRTStar(ss, sv);
planner.ContinueAfterGoalReached = true;
planner.MaxConnectionDistance = 0.3;

% Set the start and goal states.
start = [700 50 0];
goal = [150 350 0];

% Set the initial value for planner.MaxIterations.
planner.MaxIterations = 25;

% Set a flag to indicate whether a feasible path has been found.
pathFound = false;

% Loop until a feasible path is found.
while ~pathFound
    % Plan a path with the current value of planner.MaxIterations.
    rng(100,'twister') % repeatable result
    [pthObj, solnInfo] = plan(planner, start, goal);
    
    % Check if a path was found.
    if isempty(pthObj.States) 
        % If no path was found, increase planner.MaxIterations and try again.
        planner.MaxIterations = planner.MaxIterations + 10;
    else
        % If a path was found, set the pathFound flag to true and exit the loop.
        pathFound = true;
    end
end

% Visualize the results.
map2.show
hold on
% Tree expansion
plot(solnInfo.TreeData(:,1), solnInfo.TreeData(:,2), '.-');
% Draw path
plot(pthObj.States(:,1), pthObj.States(:,2), 'r-', 'LineWidth', 2)
% Display the number of final iterations on the plot.
text(2.0, -0.4, sprintf('Iterations: %d', planner.MaxIterations), 'FontSize', 8)
hold off
