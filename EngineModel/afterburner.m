%% Afterburner
%
% INSERT DOC
%% CODE
function [P06, T06, mdot_e2, mdot_f2, fuel2air] = afterburner(P05, T05, AB, mdot_e1)
    % Docstring
    Cph2 = 1.155; % [kJ/kg ºK]
    Cph1 = 1.268; % [kJ/kg ºK]
    JP7LHV = 43682; % [kJ/kg]
    T06 = ones(size(T05));
    T06(AB == 0) = T05(AB == 0);
    T06(AB == 1) = (1760+273.15); % [ºK] Assumption: Constant @ Nominal 
    eta_b = 0.99; % Assumption: From Course Textbook
    
    fuel2air = (Cph2.*T06 - Cph1.*T05)./(eta_b.*JP7LHV - Cph2.*T06);
    P06 = P05;
    P06(AB == 1) = P05(AB == 1).*(1-(1-eta_b));
    
    tmp1 = zeros(size(T05));
    tmp1(AB == 1) = mdot_e1.SI(AB == 1).*(1+fuel2air(AB == 1));
    tmp2 = zeros(size(T05));
    tmp2(AB == 1) = mdot_e1.SI(AB == 1).*(1+fuel2air(AB == 1));
    mdot_e2 = struct('ENGLISH', tmp1,...
                    'SI', tmp2);
    tmp1 = zeros(size(T05));
    tmp1(AB == 1) = mdot_e1.ENGLISH(AB == 1).*(fuel2air(AB == 1));
    tmp2 = zeros(size(T05));
    tmp2(AB == 1) = mdot_e1.SI(AB == 1).*(fuel2air(AB == 1));
    mdot_f2 = struct('ENGLISH', tmp1,...
                    'SI', tmp2);
end