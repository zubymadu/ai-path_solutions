% RRTStar.m
clear all;
p=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
   1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
   ];
Mymap= occupancyMap(p);

% Define Robot Dimensions and Inflate the Map
robotRadius = 0.1;
map = copy(Mymap);
inflate(map,robotRadius);
show(map)
% First Step is to create a State-Space Variable
ss = stateSpaceSE2;

sv = validatorOccupancyMap(ss);

sv.Map = map;
% Set validation distance for the validator.
sv.ValidationDistance = 0.01;
ss.StateBounds = [Mymap.XWorldLimits; Mymap.YWorldLimits; [-pi pi]];
planner = plannerRRTStar(ss,sv);
planner.ContinueAfterGoalReached = true;
% Reduce max iterations
planner.MaxIterations = 10;
% Increase max connection distance
planner.MaxConnectionDistance = 0.3;
start = [4 10 0];
goal = [26 8 0];
% Plan a path with default settings.
[pthObj,solnInfo] = plan(planner,start,goal);
rng(100,'twister') % repeatable result
while (isempty(pthObj.States))
    planner.MaxIterations = planner.MaxIterations +10;
    [pthObj,solnInfo] = plan(planner,start,goal);
end

% FInally, Visualize the results
Mymap.show
hold on
% Tree expansion
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-')
% Draw path
if isempty(pthObj.States) 
    disp('Path Not Found');
else
    disp('Path Found')
    plot(pthObj.States(:,1),pthObj.States(:,2),'r-','LineWidth',2)
    s=sprintf("The Number of Iterations Needed is = %d",planner.MaxIterations);
    title(s);
end





