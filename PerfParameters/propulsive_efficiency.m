%% Propulsive Efficiency
%
% 
%% CODE
function [output] = propulsive_efficiency(air_massflow,air2fuel,exhaust_velocity,flight_velocity,thrust)
% Docstring

efprop_num = flight_velocity.*thrust;
efprop_den = efprop_num + .5.*air_massflow.*(1+air2fuel).*(exhaust_velocity-flight_velocity).^2

output= efprop_num./efprop_den
end
