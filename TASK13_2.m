% Set 𝜃1 to 60 degrees
theta1 = 60*pi/180;

% Initialize an array to store the values of 𝜃2
theta2 = zeros(1,50);

% Generate 50 runs
for i = 1:50
    % Generate a random number between -pi/2 and pi/2
    a = -pi/2;
    b = pi/2;
    rng('shuffle');
    theta2(i) = a + (b-a).*rand;
end

% Print the values of 𝜃2
disp(theta2);
