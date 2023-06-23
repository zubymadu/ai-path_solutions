% Clear all the variables
clear all;

% Set the lengths of the manipulator
L1 = 0.5;
L2 = 0.2;

% Fix the value of theta1 at 60 degrees
t1 = 60*pi/180;

% Initialize a variable to store the end effector position
x_ee = 0;
y_ee = 0;
z_ee = 0;

% Loop over 50 runs
for i = 1:50
    % Generate a random value for theta2 in the range -pi/2 to pi/2
    a = -pi/2;
    b = pi/2;
    rng('shuffle');
    t2 = a + (b-a).*rand;

    % Calculate the end effector position using forward kinematics
    x = L1*cos(t1) + L2*cos(t1+t2);
    y = L1*sin(t1) + L2*sin(t1+t2);
    z = 0;

    % Store the end effector position
    x_ee(i) = x;
    y_ee(i) = y;
    z_ee(i) = z;
end

% Display the end effector positions
fprintf('End effector positions:\n');
for i = 1:50
    fprintf('(%.2f, %.2f, %.2f)\n', x_ee(i), y_ee(i), z_ee(i));
end
