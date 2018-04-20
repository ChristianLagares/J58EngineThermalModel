%% Main Routine
%
% This file contains the main routine for the J58 Thermal Model.
%
% All other files are required to be in the same directory.
%% Routine Body
%
% Pressures [Pa]
% Temperatures [�K]
% mdot_a.ENGLISH [lb/s]
% mdot_a.SI [kg/s]

% Generating Condition Vectors
[altitude, Mach, Afterburner] = condition_vectorizer();

% Inlet Model
[P_a, P0A, P02, T_a, T02, mdot_a_nonbleed] = inlet(altitude, Mach, 0);

% Shock Trap Bleed Model
[P02, T02, mdot_a] = shock_trap(P02, T02, mdot_a_nonbleed, Mach);

% Compressor Model
[P03, T03, mdot_a, eta_c] = compressor(P02, T02, mdot_a);

% Burner Model
[P04, T04, fuel2air, mdot_a, mdot_e, mdot_f] = burner(P03, T03, mdot_a);

% Turbine Model
[P05, T05] = turbine(T02, T03, P04, T04, fuel2air);
%% Viz
% 
figure('Name','PressureVStation')
plot([P_a; P0A; P02; P03; P04; P05])
xlabel('Station')
ylabel('P [Pa]')
legend('Condition1', 'Condition2', 'Condition3', 'Condition4',...
       'Condition5', 'Condition6', 'Condition7', 'Condition8',...
       'Condition9', 'Condition10', 'Condition11', 'Condition12')

figure('Name','TemperatureVStation')
plot([T_a; T_a; T02; T03; T04; T05])
xlabel('Station')
ylabel('T [�K]')
legend('Condition1', 'Condition2', 'Condition3', 'Condition4',...
       'Condition5', 'Condition6', 'Condition7', 'Condition8',...
       'Condition9', 'Condition10', 'Condition11', 'Condition12')
