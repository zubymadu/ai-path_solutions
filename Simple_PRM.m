% Implementation of a Simple PRM Algorithm 
% of size 10 by 10 squared meters.
clear all;
clf;
D = 1; % Distance to new node
N = 10; % Number of Iterations
M = []; % Map of all nodes
j = 1;
while j < N
 xRand = 10*rand(1,2); % Generate Random Pair of Coordinates
 M=[M; xRand];
 con=[]; % Connections
 for i = 1:size(M,1)
 d = norm(M(i,:)-xRand);
 if d<D && d>eps % Add Connections from xRand to neighbour
 con = [con; xRand, M(i,:)];
 end
 end
 j = j + 1; % Next Iteration
 line(xRand(1), xRand(2), 'Color', 'r', 'Marker', '.');
 for i = 1:size(con,1)
 line(con(i,[1,3]), con(i,[2,4]), 'Color', 'b');
 end
end