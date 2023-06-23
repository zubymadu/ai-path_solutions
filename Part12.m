% Clear all the variables
clear all;

% Create a new figure
figure;

% Set the lengths of the manipulator
L1 = 0.5;
L2 = 0.2;

% Ask the user to enter the angle theta1 in degrees
t1 = input('Enter Angle Theta 1 (in degrees):');

% Convert the angle to radians
t1 = t1*pi/180;

% Initialize variables to store the end effector position
x_ee = 0;
y_ee = 0;
z_ee = 0;

% Loop over the range of values for theta2
for t2 = -pi/2:0.1:pi/2
    % Clear the figure
    clf;

    % Calculate the end effector position using forward kinematics
    x = L1*cos(t1) + L2*cos(t1+t2);
    y = L1*sin(t1) + L2*sin(t1+t2);
    z = 0;

    % Plot the first link
    plot([0, L1*cos(t1)], [0, L1*sin(t1)], 'b-', 'LineWidth', 2);
    hold on;

    % Plot the second link
    plot([L1*cos(t1), x], [L1*sin(t1), y], 'b-', 'LineWidth', 2);

    % Plot the end effector position
    plot3(x, y, z, 'ro', 'LineWidth', 2);

    % Set the limits of the x and y axes
    xlim([0 1]);
    ylim([0 1]);

    % Set the limits of the z axis
    zlim([0 1]);

    % Add a title and labels for the x and y axes
    title('2-Links Manipulator');
    xlabel('x');
    ylabel('y');

    % Pause for 0.2 seconds
    pause(0.2);

    % Store the end effector position
    x_ee = x;
    y_ee = y;
    z_ee = z;
end

% Display the end effector position
fprintf('End effector position: (%.2f, %.2f, %.2f)\n', x_ee, y_ee, z_ee);
