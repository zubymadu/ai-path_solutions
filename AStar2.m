
% Dijkstra and A* Algorithm
clear all
clc
clf
%Define Number of Nodes
xmax = 40;
ymax = 35;
% Define the Start and Goal coordinates
start=[8,1];
goal=[38,32];
%Nodes
MAP = zeros(xmax,ymax);
%To define objects, set their MAP(x,y) to inf
MAP(8,4:10) = inf;
MAP(12,6:8) = inf;
MAP(16,4:10) = inf;
MAP(28,3:15) = inf;
MAP(22,3:16) = inf;
MAP(8,3:13) = inf;
MAP(34,5:16) = inf;
MAP(5:26,29) = inf;
MAP(8:31,21) = inf;
figure(1);
disp('Waiting for a key press')
surf(MAP')
gray=[0.5 0.5 0.5];
colormap(gray)
view(2)

hold on;
plot(start(1),start(2),'s','MarkerFaceColor','b')
plot(goal(1),goal(2),'s','MarkerFaceColor','g')

k=1;  % Set k=0 for Dijkstra's Algorithm
%k=1;   % Set k=1 for Astar's algorithm

[flag, path] = MyAstar(MAP,start, goal, k);
if(flag)
    disp('Path Found');
    for j = 1:size(path,1)
        plot(path(j,1),path(j,2),'X','color','r')
        pause(0.2)
    end
    plot(start(1),start(2),'s','MarkerFaceColor','r')
    plot(goal(1),goal(2),'s','MarkerFaceColor','g')
else
    disp('No Path Found')
end