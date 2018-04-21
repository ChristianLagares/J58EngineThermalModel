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
[P04, T04, fuel2air, mdot_a, mdot_e1, mdot_f, LHV] = burner(P03, T03, mdot_a);

% Turbine Model
[P05, T05] = turbine(T02, T03, P04, T04, fuel2air);

% Afterburner Model
[P06, T06, mdot_e2, mdot_f2, ab_fuel2air] = afterburner(P05, T05, AB, mdot_e1);
total_fuel2air = struct('ENGLISH', (mdot_f2.ENGLISH+mdot_f.ENGLISH)./mdot_a.ENGLISH,...
                        'SI', (mdot_f2.SI+mdot_f.SI)./mdot_a.SI);
%total

% Nozzle Model
[P8, T8, V8] = nozzle(P06, T06, AB, T02, P_a);

fprintf('V_inf\tV_ext\tMach\tProportion\n')
for ii = [1:12]
    fprintf('%3.2f\t%3.2f\t%3.2f\t%3.2f\n',V_inf(ii), V8(ii), Mach(ii), V8(ii)/V_inf(ii))
end

%% Postprocessing
%
% Nozzle Area
rho_nozzle = P8./(287.*T8); % kg/m^3
total_mdot = struct('ENGLISH', (mdot_a_nonbleed.ENGLISH + mdot_f.ENGLISH + mdot_f2.ENGLISH),...
                    'SI', (mdot_a_nonbleed.SI + mdot_f.SI + mdot_f2.SI));
nozzle_area = (mdot_a_nonbleed.SI + mdot_f.SI + mdot_f2.SI)./(rho_nozzle + V8); % m^2

% Thrust
[thrust_SI] = thrust(mdot_a.SI, total_fuel2air.SI, ...
                     V8,V_inf, P_a, P8, nozzle_area); % Newtons
thrust_ENGLISH = 0.224808943.* thrust_SI; % lbf

% Propulsive Efficiency
[prop_efficiency] = propulsive_efficiency(mdot_a_nonbleed.SI,...
                                          total_fuel2air.SI,...
                                          V8, V_inf, thrust_SI);

% Thermal Efficiency

thermal_efficiency = ((thrust_SI.*V8) + (0.5.*mdot_a.SI.*(1+total_fuel2air.SI).*((V8-V_inf).^2)))./((LHV.*1000).*(mdot_f2.SI+mdot_f.SI));

% Overall Efficiency
overall_efficiency = prop_efficiency .* thermal_efficiency;

%% Viz
% 
figure('Name','PressureVStation')
plot([P_a; P0A; P02; P03; P04; P05; P06; P8])
xlabel('Station')
ylabel('P [Pa]')
legend('Validation','Takeoff', 'Refueling_Buddy', 'Climbing', 'Concorde',...
       'YF12A', 'A12Max', 'Takeoff_High', 'LowestM1',...
       'MA139XAA', 'FrenchGriffon2', 'ConstantClimb', 'Out_Of_Model')

figure('Name','TemperatureVStation')
plot([T_a; T_a; T02; T03; T04; T05; T06; T8])
xlabel('Station')
ylabel('T [ºK]')
legend('Validation','Takeoff', 'Refueling_Buddy', 'Climbing', 'Concorde',...
       'YF12A', 'A12Max', 'Takeoff_High', 'LowestM1',...
       'MA139XAA', 'FrenchGriffon2', 'ConstantClimb', 'Out_Of_Model')

figure('Name','ThermalEfficiencyVV_inf')
scatter(V_inf', thermal_efficiency')
xlabel('V_inf [m/s]')
ylabel('\eta_t')

figure('Name','PropulsiveEfficiencyVV_inf')
scatter(V_inf', prop_efficiency')
xlabel('V_inf [m/s]')
ylabel('\eta_p')

figure('Name','OverallEfficiencyVV_inf')
scatter(V_inf', overall_efficiency')
xlabel('V_inf [m/s]')
ylabel('\eta_o')