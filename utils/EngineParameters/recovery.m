%% Recover vs Mach

%% Code
function [ratio] = recovery(Mach)
    % Docstring
    if Mach < 1.0
        ratio = 0.3555.*((Mach).^4.221) + 1.181;
    elseif Mach < 2
        ratio = (0.2981.*(exp(Mach.*1.593))) + 0.5581;
    else
        ratio1 = (0.2981.*(exp(Mach.*1.593))) + 0.5581;
        ratio2 = (0.3555.*(Mach.^4.221)) + 1.181;
        ratio = (ratio1+ratio2)./2;
    end
end