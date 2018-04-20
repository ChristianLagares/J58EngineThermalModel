%% Thrust
% 
% Thrust force is considered an important performance parameter for any
% turbojet engine.
%
%% CODE
function [thrust] = thrust(air_massflow, air2fuel, exhaust_velocity,...
    flight_velocity, atmospheric_pressure, exhaust_pressure, exhaust_area)
    % thrust computes the thrust force for multiple flight conditions. Inputs
    % should be floating point vectors with one entry per flight condition.

    pthrust = (exhaust_pressure - atmospheric_pressure).*exhaust_area;
    vthrust = air_massflow.*((1+air2fuel).*exhaust_velocity + flight_velocity);

    thrust = pthrust + vthrust;
end