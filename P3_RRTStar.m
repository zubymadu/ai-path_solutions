clear all;

% First Step is to create a State-Space Variable
ss = stateSpaceSE2;

% Next, Create an occupancyMap-based state validator using the 
% created state space.
sv = validatorOccupancyMap(ss);

% Create an occupancy map from an example map and set map resolution 
% as 10 cells/meter.
load exampleMaps
map = occupancyMap(complexMap,10);
sv.Map = map;

% Set validation distance for the validator.
sv.ValidationDistance = 0.01;

% Update state space bounds to be the same as map limits.
ss.StateBounds = [map.XWorldLimits; map.YWorldLimits; [-pi pi]];

% Create RRT* path planner and allow further optimization after goal 
% is reached. Reduce the maximum iterations and increase the maximum 
% connection distance.
planner = plannerRRTStar(ss,sv);
planner.ContinueAfterGoalReached = true;
planner.MaxConnectionDistance = 0.3;

% Set the start and goal states.
start = [0.2 3.5 0];
goal = [5 0.2 0];

% Set the initial value for planner.MaxIterations.
planner.MaxIterations = 10;

% Set a flag to indicate whether a feasible path has been found.
pathFound = false;

% Loop until a feasible path is found.
while ~pathFound
    % Plan a path with the current value of planner.MaxIterations.
    rng(100,'twister') % repeatable result
    [pthObj,solnInfo] = plan(planner,start,goal);
    
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
map.show
hold on
% Tree expansion
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-');
% Draw path
plot(pthObj.States(:,1),pthObj.States(:,2),'r-','LineWidth',2)
% Display the number of final iterations on the plot.
text(2.0,-0.4,sprintf('Iterations: %d',planner.MaxIterations),'FontSize',8)
hold off
