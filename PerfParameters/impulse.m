%% Impulse
%
% INSERT DOC
%% CODE
function [output] = impulse(air_massflow,air2fuel,thrust)
% Docstring

output = air_massflow.*air2fuel./thrust
end
