%% Shock Trap
%
% INSERT DOC
%% CODE
function [P2, T2, mdot_a_out] = shock_trap(P2, T2, mdot_a_in, Flight_Mach)
    % shock_trap
    mdot_a_en_out = mdot_a_in.ENGLISH;
    mdot_a_si_out = mdot_a_in.SI;
    
    mdot_a_en_in = mdot_a_in.ENGLISH;
    mdot_a_si_in = mdot_a_in.SI;
    
    mdot_a_en_out(Flight_Mach >= 1.3) = mdot_a_en_in(Flight_Mach >= 1.3).*0.85;
    mdot_a_si_out(Flight_Mach >= 1.3) = mdot_a_si_in(Flight_Mach >= 1.3).*0.85;

    mdot_a_out = struct('ENGLISH', mdot_a_en_out,...
                        'SI', mdot_a_si_out);
end