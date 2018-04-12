%% Ideal Gas
%
%
%% Code
function [P2, T2] = atm2comp(altitude, T_offset, Mach)
    % Docstring
    meters = 0.3.*altitude;
    properties = atmos(meters, 'units', 'SI',...
        'structOutput', true);
    P0 = properties.P;
    recovery_rate = recovery(Mach);
    P2 = recovery_rate.*P0;
    rho = (6.349*(10^-5)).*(P2.^0.8578);
    
    c = sqrt(1.4.*(P2./rho));
    
    T2 = T_offset+(c.^2)./(1.4*287);
end