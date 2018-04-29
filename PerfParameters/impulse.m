%% Impulse
%
% INSERT DOC
%% CODE
function [output] = impulse(air_massflow,air2fuel,thrust)
% Docstring

output = thrust./(air_massflow.*air2fuel.*9.81);
end
