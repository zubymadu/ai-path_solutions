% MyDrawingRobot
%MyDrawingRobot(x, y, pose(3),0.5);
function MyDrawingRobot(x, y, theta,radius)

theta = theta - 90;
    
 RW=1.2;
 RL=1.4;
    % Get points for orientation arrow
    p1x=RW/6; p1y= 2*-RL/7;
    p1 = [p1x,p1y];
    p2 = [p1x,-p1y];
    p3 = [3*p1x,-p1y];
    p4 = [0,1];
    % Now the Wheel
    ww=0.25;  %Wheel width
    sw = 0.06; % Space between the wheels and the robot body (i.e. the arrow)
    w1=[p1x+sw, p1y]; w2=[p1x+sw, 0]; w3=[p1x+ww,0]; w4=[p1x+ww, p1y];
    w11=[w1(1,1), (p1y/2)-sw];
    w12 = [p1x, w11(1,2)];
    w22 = [w12(1,1), w12(1,2)+2*sw];
    w21=[w2(1,1), w22(1,2)];
    
    inv_x = [-1,1];
    R1 = [p1;p2;p3;p4;inv_x.*p3;inv_x.*p2;inv_x.*p1;p1];
    R2 = [w1;w11;w12;w22;w21;w2;w3;w4;w1];      %inv_x.*w1;inv_x.*w2;inv_x.*w3;inv_x.*w4;inv_x.*w1];
    R3 = [inv_x.*w1;inv_x.*w11;inv_x.*w12;inv_x.*w22;inv_x.*w21;inv_x.*w2;inv_x.*w3;inv_x.*w4;inv_x.*w1];
    % Rotation matrix for theta
    rot_trans = [cosd(theta), -sind(theta), x; sind(theta), cosd(theta), y; 0 0 1];
    
    
 
    R1 = R1.*radius;
    R2=R2.*radius;
    R3=R3.*radius;
    % Apply rotation and translation to points
    R1 = rot_trans*[R1,ones(size(R1(:,1)))]';
    R2 = rot_trans*[R2,ones(size(R2(:,1)))]';
    R3 = rot_trans*[R3,ones(size(R3(:,1)))]';
    R1 = R1(1:2,:)';
    R2 = R2(1:2,:)';
    R3 = R3(1:2,:)';
        
    %figure(2)
   fillcolor=[0,0,0.1];
    plot(R1(:,1),R1(:,2),'blue','LineWidth',3 );
    fill(R1(:,1),R1(:,2),fillcolor );
    hold on;
    % Draw the right Wheel
    darkgrey=[0.2,0.2,0.2];
    plot(R2(:,1),R2(:,2),'black','LineWidth',2 );
    fill(R2(:,1),R2(:,2), darkgrey );  % Fill with dark gray
    % Draw the Left Wheel
    plot(R3(:,1),R3(:,2),'black','LineWidth',2 );
    fill(R3(:,1),R3(:,2),darkgrey );     % Fill with dark gray
    %axis([-5,5,-5,5]);
end