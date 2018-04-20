%% Burner
%
% INSERT DOC
%% CODE
function [P04, T04, fuel2air, mdot_a, mdot_e, mdot_f, JP7LHV] = burner(P03, T03, mdot_a)
    % Docstring
    Cph = 1.005; % [kJ/kg ºK]
    Cpc = 1.155; % [kJ/kg ºK]
    JP7LHV = 43682; % [kJ/kg]
    T04 = ones(size(T03)).*(1093.33+273.15); % [ºK] Assumption: Constant @ Nominal 
    eta_b = 0.99; % Assumption: From Course Textbook
    
    fuel2air = (Cph.*T04 - Cpc.*T03)./(eta_b.*JP7LHV - Cph.*T04);
    P04 = P03.*(1-(1-eta_b));
    mdot_e = struct('ENGLISH', mdot_a.ENGLISH.*(1+fuel2air),...
                    'SI', mdot_a.SI.*(1+fuel2air));
    mdot_f = struct('ENGLISH', mdot_a.ENGLISH.*(fuel2air),...
                    'SI', mdot_a.SI.*(fuel2air));
end