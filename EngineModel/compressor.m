%% Compressor
%
% INSERT DOC
%% CODE
function [P03, T03, mdot_a, eta_c] = compressor(P02, T02, mdot_a)
    % Compressor
    eta_c = 0.9;
    gamma_c = 1.4;
    
    parameters = engine();
    compression_ratio = parameters.COMPRESSION_RATIO;
    
    P03 = compression_ratio.*P02;
    T03 = T02.*(1+(((compression_ratio.^((gamma_c-1)/gamma_c))-1)/eta_c));
end