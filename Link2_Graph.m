% Prompt the user to enter the angles theta1 and theta2 in degrees
t1 = input('Enter the value of theta1 in degrees: ');
t2 = input('Enter the value of theta2 in degrees: ');

% Convert the angles to radians
t1 = deg2rad(t1);
t2 = deg2rad(t2);

% Calculate the end effector position using forward kinematics
x = L1*cos(t1) + L2*cos(t1+t2);
y = L1*sin(t1) + L2*sin(t1+t2);
z = 0;

% Create an empty figure
figure;

% Plot the first link
plot([0, L1*cos(t1)], [0, L1*sin(t1)], 'b-', 'LineWidth', 2);
hold on;

% Plot the second link
plot([L1*cos(t1), x], [L1*sin(t1), y], 'b-', 'LineWidth', 2);

% Plot the end effector position
plot3(x, y, z, 'ro', 'LineWidth', 2);

% Display the coordinates of the end effector
s=sprintf('The End Effector coordinates: (%f , %f)\n', x ,y);

% Set the axis limits and labels
disp(s);
grid;
title(s);
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
xlabel('x');
ylabel('y');
zlabel('z');
