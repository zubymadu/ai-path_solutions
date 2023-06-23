%% PRM parameters
map=im2bw(imread('Maze2.png')); % input map read from a bmp file. for new maps write the file name here
% For Maze1.png: source=[400 50]; goal=[50 700];
% For Maze2.png: source=[40 40]; goal=[300 580];
source=[40 40]; % source position in Y, X format
goal=[300 580]; % goal position in Y, X format
k=80; % number of points in the PRM
display=true; % display processing of nodes


if ~feasiblePoint(source,map), error('source lies on an obstacle or outside map'); end
if ~feasiblePoint(goal,map), error('goal lies on an obstacle or outside map'); end

imshow(map);

%hold on;
%plot(source(2), source(1), '.r', 'MarkerSize',20)
%plot(goal(2), goal(1), '.g', 'MarkerSize',20)

%rectangle('position',[1 1 size(map)-1],'edgecolor','k')
r=5;
vertex=[source;goal]; % source and goal taken as additional vertices in the path planning to ease planning of the robot
if display, rectangle('Position',[vertex(1,2)-5,vertex(1,1)-5,r,r],'Curvature',[1,1],'FaceColor','r'); end % draw circle
if display, rectangle('Position',[vertex(2,2)-5,vertex(2,1)-5,r,r],'Curvature',[1,1],'FaceColor','g'); end

waitforbuttonpress;
tic; % tic-toc: Functions for Elapsed Time

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Step 1, Constructs the Map  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%  iteratively add vertices
r=4;
while length(vertex)<k+2 
    x = double(int32(rand(1,2) .* size(map))); % using randomly sampled nodes(convert to pixel unit)
    if feasiblePoint(x,map), 
        vertex=[vertex;x]; 
        if display, rectangle('Position',[x(2)-5,x(1)-5,r,r],'Curvature',[1,1],'FaceColor','b'); end
    end
end

if display 
    disp('click/press any key');
	% blocks the caller's execution stream until the function detects that the user has pressed a mouse button or a key while the Figure window is active
    waitforbuttonpress;  
end

%%  attempts to connect all pairs of randomly selected vertices
edges = cell(k+2,1);  % edges to be stored as an adjacency list
for i=1:k+2
    for j=i+1:k+2
        if checkPath(vertex(i,:),vertex(j,:),map);
            edges{i}=[edges{i};j]; 
			edges{j}=[edges{j};i];
            if display, line([vertex(i,2);vertex(j,2)],[vertex(i,1);vertex(j,1)]); end
        end
    end
end

if display 
    disp('click/press any key');
    waitforbuttonpress; 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Step 2,  Finding a Path using A*  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
	
% structure of a node is taken as: [index of node in vertex, historic cost, heuristic cost, total cost, parent index in closed list (-1 for source)]
Q=[1 0 heuristic(vertex(1,:),goal) 0+heuristic(vertex(1,:),goal) -1]; % the processing queue of A* algorihtm, open list
closed=[]; % the closed list taken as a list
pathFound=false;
while size(Q,1) > 0 	  % while open-list is not empty
     [A, I] = min(Q,[],1);% find the minimum value of each column
     current = Q(I(4),:); % select smallest total cost element to process
     Q=[Q(1:I(4)-1,:);Q(I(4)+1:end,:)]; % delete element under processing 
	 
     if current(1)==2 				    % index of node in vertex==2(goal)
         pathFound=true;break;
     end
	 
     for mv = 1:length(edges{current(1)}) % iterate through all edges from the node
         newVertex=edges{current(1)}(mv); % move to neighbor node
         if length(closed)==0 || length(find(closed(:,1)==newVertex))==0 % not in closed(Ignore the neighbor which is already evaluated)
             historicCost = current(2) + historic(vertex(current(1),:),vertex(newVertex,:)); % The distance from start to a neighbor
             heuristicCost = heuristic(vertex(newVertex,:),goal);
             totalCost = historicCost + heuristicCost;
			 
             add = true; % not already in queue with better cost
             if length(find(Q(:,1)==newVertex))>=1
                 I = find(Q(:,1)==newVertex);
                 if totalCost > Q(I,4), add=false; % not a better path
                 else Q=[Q(1:I-1,:);Q(I+1:end,:);];add=true; 
                 end
             end
			 
             if add
                 Q=[Q;newVertex historicCost heuristicCost totalCost size(closed,1)+1]; % add new nodes in queue
             end
         end           
     end
     closed=[closed;current]; % update closed lists
end

if ~pathFound
    error('no path found')
end

fprintf('processing time=%d \nPath Length=%d \n\n', toc, current(4)); 

path=[vertex(current(1),:)]; % retrieve path from parent information
prev = current(5);
while prev > 0
    path = [vertex(closed(prev,1),:);path];
    prev = closed(prev, 5);
end

imshow(map);
%rectangle('position',[1 1 size(map)-1],'edgecolor','k')
line(path(:,2),path(:,1),'color','r');
hold on;
plot(source(2), source(1), '.r', 'MarkerSize',20)
plot(goal(2), goal(1), '.g', 'MarkerSize',20)