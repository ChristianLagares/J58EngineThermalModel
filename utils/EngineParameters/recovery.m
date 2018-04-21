%% Recover vs Mach

%% Code
function [ratio] = recovery(Mach)
    % Docstring
    ratio = 0.004105.*(Mach.^4)+...
            -0.02213.*(Mach.^3)+...
           0.0006246.*(Mach.^2)+...
             0.03737.*(Mach) + 0.951;
end
