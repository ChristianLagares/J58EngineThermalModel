%% overall_effiency
%
% INSERT DOC
%% CODE
function [output] = overall_effiency(propulsive_efficiency,...
                                     thermal_efficiency)
    % Docstring

    output = propulsive_efficiency.*thermal_efficiency;
end
