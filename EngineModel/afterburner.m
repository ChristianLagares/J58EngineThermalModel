%% Afterburner
%
% INSERT DOC
%% CODE
function [P06, T06, mdot_e2, mdot_f2] = afterburner(P05, T05, AB, mdot_e1)
    % Docstring
    Cph = 1.155; % [kJ/kg ºK]
    Cpc = 1.268; % [kJ/kg ºK]
    JP7LHV = 43682; % [kJ/kg]
    T06 = ones(size(T05));
    T06(AB == 0) = T05(AB == 0);
    T06(AB == 1) = (1760+273.15); % [ºK] Assumption: Constant @ Nominal 
    eta_b = 0.99; % Assumption: From Course Textbook
    
    fuel2air = (Cph.*T06 - Cpc.*T05)./(eta_b.*JP7LHV - Cph.*T06);
    P06 = P05.*(1-(1-eta_b));
    mdot_e2 = struct('ENGLISH', mdot_e1.ENGLISH.*(1+fuel2air),...
                    'SI', mdot_e1.SI.*(1+fuel2air));
    mdot_f2 = struct('ENGLISH', mdot_e1.ENGLISH.*(fuel2air),...
                    'SI', mdot_e1.SI.*(fuel2air));
end