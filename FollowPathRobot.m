function FollowPathRobot(path, map, steps)
p=path;
%p=[1 2; 2 6; 4 10 ;6 7; 8, 9; 12,9;16,18];
%figure(5);
%show(map)
plot(p(:,1), p(:,2));
px=p(:,1);          % Get all the x values from p
py=p(:,2);          % Get all the y Values from p
mx=max(px);         % Get the maximum value of the x
my=max(py);         % Get the maximum value of the y
%limits=[0, mx+mx/2 ,0, my+my/2];
%axis(limits);
hold on;
% Caluclate the Gradients (i.e. slope of each segment)
m=diff(py)./diff(px);
delay=0.01;
%steps=0.05;
% Calculate the distance for each segment)
[N,M]=size(p);  % Get the total number of coordinates
 
for i=1:N-1 
    % Method of calculating the distance
    x=[p(i,1)  p(i,2)];
    y=[p(i+1,1)  p(i+1,2)];
    d(i)=norm(x-y);
end
 
% Alternative Method of finding the angles:
p_diff=diff(p);
v=p_diff(:,1) + 1i*p_diff(:,2);
Angles = angle(v) * 180/pi; %// Line angles given in degrees  
 
for i=1: N-1
    % Method of calculating the distance
    x=[p(i,1)  p(i,2)];
    y=[p(i+1,1)  p(i+1,2)];
    d(i)=norm(x-y);
    
    s1=sprintf('i=%d, mp1 = %f, Angles(%d)=%f', i,m(i),i, Angles(i));
    disp(s1);
    clf;
    show(map)
    pose=[p(i,1), p(i,2),Angles(i)];
 
    MyDrawingRobot(pose(1), pose(2), pose(3),0.5)
    plot(p(:,1), p(:,2))
    %axis(limits);
 
    % To account for Vertical lines: Y changes Not x
    if m(i)==inf      % Vertical line going up
        dx=1;
        for y=p(i,2):dx*steps:p(i+1,2)
            clf;
            hold on;
            plot(p(:,1), p(:,2))
            %axis(limits)
            x=p(i,1);  % or  x=p(i,2);
            % Do the formula for x not y
            MyDrawingRobot(x, y, pose(3),0.5);
            pause(delay); 
        end
    elseif m(i)==-inf     % Vertical line going down
            dx=-1;
            for y=p(i,2):dx*steps:p(i+1,2)
                clf;
                show(map);
                hold on;
                plot(p(:,1), p(:,2))
                %axis(limits)
                x=p(i,1);  % or  x=p(i,2);
                % Do the formula for x not y
                MyDrawingRobot(x, y, pose(3),0.5);
                pause(delay); 
            end
        else
             if p(i,1) > p(i+1,1)
                dx=-1;
             else
                dx=1;
             end
             for x=p(i,1):dx*steps:p(i+1,1)
                clf;
                show(map);
                hold on;
                plot(p(:,1), p(:,2))
                %axis(limits);
                y=m(i)*(x-p(i,1))+p(i,2);
                MyDrawingRobot(x, y, pose(3),0.5);
                pause(delay); 
            end
        end
end
grid;
% Calculate the angles wrt to each line
hold off;