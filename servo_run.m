% Alternatively
% Measure the time and use speed of light to calculate d=t*c/2;
clear all;
% Create an Arduino object and include the Ultrasonic Libraries
a = arduino('COM9','Uno','Libraries','Ultrasonic')
% Create an ultrasonic sensor connection object 
% with the trigger pin set to D2 and the echo pin set to D3.
u = ultrasonic(a,'D2','D3')
% Measure the time taken by the ultrasound waves reflected from 
% the object to reach the sensor.
t = readEchoTime(u);
% Calculate the distance to the object, by assuming the speed of sound to be 344 m/s.
d = 344*t/2;
fprintf('Current motor position is %f degrees\n', d);
clear a u