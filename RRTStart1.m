clear all;

ss = stateSpaceSE2;

sv = validatorOccupancyMap(ss);

load exampleMaps
map = occupancyMap(simpleMap,10);
sv.Map = map;
% Set validation distance for the validator.
sv.ValidationDistance = 0.01;
ss.StateBounds = [map.XWorldLimits; map.YWorldLimits; [-pi pi]];
 
planner = plannerRRTStar(ss,sv);

planner.ContinueAfterGoalReached = true;
 
% Reduce max iterations
planner.MaxIterations = 400;
 
% Increase max connection distance
planner.MaxConnectionDistance = 0.3;
start = [0.5 0.5 0];
goal = [2.5 0.2 0];
% Plan a path with default settings.

rng(100,'twister') % repeatable result
[pthObj,solnInfo] = plan(planner,start,goal);
% Finally, Visualize the results.
map.show
hold on
% Tree expansion
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-');
% Draw path
if isempty(pthObj.States) 
    disp('Path Not Found');
else
    disp('Path Found')
    plot(pthObj.States(:,1),pthObj.States(:,2),'r-','LineWidth',2)
end





