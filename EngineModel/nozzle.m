%% Nozzle
%
% INSERT DOC
%% CODE
function [P8, T8, V8, Pc] = nozzle(P06, T06, AB, T02, P_a)
    % Docstring
    eta_n = 0.98;
    R = 287;
    gamma_h = 1.33;
    Cph = 1.155; 
    
    T8 = nominalEGT(T02 - 273.15)+273.15; % T06.*(2./(gamma_h+1));
    Pc = zeros(size(P06));
    P8 = zeros(size(P06));
    V8 = zeros(size(P06));
    
   
    % Ctitical Pressure
    Pc(AB == 1) = P06(AB == 1).*((1 - (1/eta_n).*(gamma_h-1)./(gamma_h+1)).^(gamma_h./(gamma_h-1)));
    Pc(AB == 0) = P06(AB == 0).*((1 - (1/eta_n).*(gamma_h-1)./(gamma_h+1)).^(gamma_h./(gamma_h-1)));
    
    % Inoperant AB
    P8(AB == 0 & Pc >= P_a) = Pc(AB == 0 & Pc >= P_a);
    P8(AB == 0 & Pc < P_a) = P_a(AB == 0 & Pc < P_a);
    V8(AB == 0 & Pc >= P_a) = sqrt(gamma_h .* R .* T8(AB == 0 & Pc >= P_a));
    V8(AB == 0 & Pc < P_a) = sqrt(((2.*gamma_h.*eta_n.*R.*...
        T06(AB == 0 & Pc < P_a))./(gamma_h-1)).*...
        (1-((P_a(AB == 0 & Pc < P_a)./...
        P06(AB == 0 & Pc < P_a)).^((gamma_h-1)./gamma_h))));
    
    % Operative AB
    P8(AB == 1 & Pc >= P_a) = Pc(AB == 1 & Pc >= P_a);
    P8(AB == 1 & Pc < P_a) = P_a(AB == 0 & Pc < P_a);
    V8(AB == 1 & Pc >= P_a) = sqrt(gamma_h .* R .* T8(AB == 1 & Pc >= P_a));
    V8(AB == 1 & Pc < P_a) = sqrt(2.*Cph.*eta_n.*T06(AB == 1 & Pc < P_a).*...
        (1-((P_a(AB == 1 & Pc < P_a)./P06(AB == 1 & Pc < P_a)).^((gamma_h-1)./gamma_h))));
end