%% Turbine
%
% INSERT DOC
%% CODE
function [P05, T05] = turbine(T02, T03, P04, T04, fuel2air)
    % Docstring
    Cph = 1.005; % [kJ/kg ºK]
    Cpc = 1.155; % [kJ/kg ºK]
    losses = 0.90; % Assumed Shaft Losses
    eta_t = 0.95;
    gamma_h = 1.33;
    
    T05 = T04.*(1 - ((((Cpc./Cph).*T02)./(losses.*(1+fuel2air).*T04))).*((T03./T02) - 1));
    P05 = P04.*(1 - ((1./eta_t).*(1-(T05./T04)))).^(gamma_h./(gamma_h-1));
end