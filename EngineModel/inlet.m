%% Inlet
%
% INSERT DOC
%% CODE
function [P2, T2] = inlet(altitude, Mach, Toffset)
    % inlet - models the SR-71 supersonic inlet
    eta_d = recovery(Mach);
    gamma_c = 1.4; 
    
    altitude = altitude_converter(altitude, 'ft', 'm');
    
    atmosphere = atmos(altitude, 'units', 'SI', 'structOutput', true);
    
    P_a  = atmosphere.P;
    T_a  = atmosphere.T +Toffset;
    
    P_0a = P_a; % + 0.5 .* atmosphere.rho .* (Mach .* atmosphere.a).^2;
    
    P2 = P_0a.*((1 + (((gamma_c - 1)/2).*(Mach.^2).*(eta_d))).^(gamma_c/(gamma_c-1)));
    T2 = T_a.*((1 + (((gamma_c - 1)/2).*(Mach.^2))));
end