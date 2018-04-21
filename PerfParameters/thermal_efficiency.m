%% Thermal Efficiency
%
% INSERT DOC
%% CODE
function [thermal_efficiency] = thermal_efficiency(air_massflow,air2fuel,...
                                       exhaust_velocity,flight_velocity,...
                                       LHV)
    % Docstring

    efther_num = (thrust.*flight_velocity)+0.5*air_massflow.*...
                 (1+air2fuel).*(exhaust_velocity-flight_velocity).^2;
    efther_den = air_massflow.*air2fuel.*LHV;

    thermal_efficiency = efther_num./efther_den;
end
