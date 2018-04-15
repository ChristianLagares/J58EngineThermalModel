%% TSFC
%
% INSERT DOC
%% CODE
function [output] = tsfc(air_massflow,air2fuel,thrust)
% Docstring

output = air_massflow.*air2fuel./thrust
end
