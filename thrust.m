%% Thrust
% 
% INSERT DOC
%% CODE
function [output] = thrust(air_massflow, air2fuel, exhaust_velocity,...
    flight_velocity, atmospheric_pressure, exhaust_pressure, exhaust_area)
% thrust computes the thrust force for multiple flight conditions. Inputs
% should be floating point vectors with one entry per flight condition.

pthrust = (exhaust_pressure - atmospheric_pressure).*exhaust_area;
vthrust = air_massflow.*((1+air2fuel).*exhaust_velocity + flight_velocity);

output = pthrust + vthrust;
end