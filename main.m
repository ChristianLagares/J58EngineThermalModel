%% Main Routine
%
% This file contains the main routine for the J58 Thermal Model.
%
% All other files are required to be in the same directory.
%% Routine Body
%
% Pressures [Pa]
% Temperatures [ºK]
% mdot_a.ENGLISH [lb/s]
% mdot_a.SI [kg/s]

% Generating Condition Vectors
[altitude, Mach, AB] = condition_vectorizer();

% Inlet Model
[P_a, P0A, P02, T_a, T02, mdot_a_nonbleed, V_inf] = inlet(altitude, Mach, 0);

% Shock Trap Bleed Model
[P02, T02, mdot_a] = shock_trap(P02, T02, mdot_a_nonbleed, Mach);

% Compressor Model
[P03, T03, mdot_a, eta_c] = compressor(P02, T02, mdot_a);

% Burner Model
[P04, T04, fuel2air, mdot_a, mdot_e1, mdot_f] = burner(P03, T03, mdot_a);

% Turbine Model
[P05, T05] = turbine(T02, T03, P04, T04, fuel2air);

% Afterburner Model
[P06, T06, mdot_e2, mdot_f2, ab_fuel2air] = afterburner(P05, T05, AB, mdot_e1);
total_fuel2air = struct('ENLGLISH', mdot_f2.ENGLISH./mdot_a.ENGLISH,...
                        'SI', mdot_f2.SI./mdot_a.SI);

% Nozzle Model
[P8, T8, V8] = nozzle(P06, T06, AB, T02, P_a);
fprintf('V_inf\tV_ext\tMach\tProportion\n')
for ii = [1:12]
    fprintf('%3.2f\t%3.2f\t%3.2f\t%3.2f\n',V_inf(ii), V8(ii), Mach(ii), V8(ii)/V_inf(ii))
end

%% Viz
% 
figure('Name','PressureVStation')
plot([P_a; P0A; P02; P03; P04; P05; P06; P8])
xlabel('Station')
ylabel('P [Pa]')
legend('Condition1', 'Condition2', 'Condition3', 'Condition4',...
       'Condition5', 'Condition6', 'Condition7', 'Condition8',...
       'Condition9', 'Condition10', 'Condition11', 'Condition12')

figure('Name','TemperatureVStation')
plot([T_a; T_a; T02; T03; T04; T05; T06; T8])
xlabel('Station')
ylabel('T [ºK]')
legend('Condition1', 'Condition2', 'Condition3', 'Condition4',...
       'Condition5', 'Condition6', 'Condition7', 'Condition8',...
       'Condition9', 'Condition10', 'Condition11', 'Condition12')
