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
[P8, T8, V8, Pc] = nozzle(P06, T06, AB, T02, P_a);

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

thermal_efficiency = ((thrust_SI.*V_inf) + (0.5.*mdot_a.SI.*(1+total_fuel2air.SI).*((V8-V_inf).^2)))./((LHV.*1000).*(mdot_f2.SI+mdot_f.SI));

% Overall Efficiency
overall_efficiency = prop_efficiency .* thermal_efficiency;

% TSFC
TSFC = tsfc(mdot_a.SI, total_fuel2air.SI.*3600, thrust_SI);

% TSFC ENGLISH
TSFC_ENGLISH = tsfc(mdot_a.ENGLISH, total_fuel2air.ENGLISH.*3600, thrust_ENGLISH);

% Impulse
Impulse = impulse(mdot_a_nonbleed.SI, total_fuel2air.SI, thrust_SI);

% Specific Thrust
specific_thrust = (thrust_SI)./(mdot_a_nonbleed.SI);

fprintf('V_inf [mph]\tV_ext[mph]\tMach\tEta_T\tEta_P\tEta_o\tThrust [lbf]\tThrust [kN]\tTSFC [kg/h/N]\n')
for ii = [1:13]
    fprintf('%3.2f\t\t%3.2f\t\t%3.2f\t%4.4f\t%4.4f\t%4.4f\t%6.1f\t\t%3.2f\t\t%4.4f\n',V_inf(ii)*2.24, V8(ii)*2.24, Mach(ii), thermal_efficiency(ii), prop_efficiency(ii), overall_efficiency(ii), thrust_ENGLISH(ii), thrust_SI(ii)/1000, TSFC(ii))
end

%% Viz
% 
render = false;
if render == true
    figure('Name','PressureVStation')
    plot([P_a; P0A; P02; P03; P04; P05; P06; P8])
    xlabel('Station')
    ylabel('P [Pa]')
    legend('Validation','Takeoff (1)', 'Refueling Buddy (2)',...
           'Climbing (3)', 'Concorde (4)',...
           'YF12A (5)', 'A12Max (6)', 'Takeoff High (7)', 'LowestM1  (8)',...
           'MA139XAA (9)', 'FrenchGriffon2  (10)', 'ConstantClimb (11)', 'Out Of Model  (12)')
    grid on
    grid minor

    figure('Name','TemperatureVStation')
    plot([T_a; T_a; T02; T03; T04; T05; T06; T8])
    xlabel('Station')
    ylabel('T [ºK]')
    legend('Validation','Takeoff (1)', 'Refueling Buddy (2)',...
           'Climbing (3)', 'Concorde (4)',...
           'YF12A (5)', 'A12Max (6)', 'Takeoff High (7)', 'LowestM1  (8)',...
           'MA139XAA (9)', 'FrenchGriffon2  (10)', 'ConstantClimb (11)', 'Out Of Model  (12)')
    grid on
    grid minor

    figure('Name','ThermalEfficiencyVV_inf')
    scatter(V_inf', thermal_efficiency')
    ylim([0,1])
    xlabel('V_{inf} [m/s]')
    ylabel('\eta_t')
    grid on
    grid minor

    figure('Name','ThermalEfficiencyVMach')
    scatter(Mach', thermal_efficiency')
    ylim([0,1])
    xlabel('Mach')
    ylabel('\eta_t')
    grid on
    grid minor

    figure('Name','PropulsiveEfficiencyVVinf')
    scatter(V_inf', prop_efficiency')
    ylim([0,1])
    xlabel('V_{inf} [m/s]')
    ylabel('\eta_p')
    grid on
    grid minor

    figure('Name','PropulsiveEfficiencyVMach')
    scatter(Mach', prop_efficiency')
    ylim([0,1])
    xlabel('Mach')
    ylabel('\eta_p')
    grid on
    grid minor

    figure('Name','OverallEfficiencyVV_inf')
    scatter(V_inf', overall_efficiency')
    ylim([0,1])
    xlabel('V_{inf} [m/s]')
    ylabel('\eta_o')
    grid on
    grid minor

    figure('Name','OverallEfficiencyVMach')
    scatter(Mach', overall_efficiency')
    ylim([0,1])
    xlabel('Mach')
    ylabel('\eta_o')
    grid on
    grid minor

    figure('Name','TSFCVMach')
    scatter(Mach, TSFC)
    xlabel('Mach')
    ylabel('TSFC [(kg/h)/N]')
    grid on
    grid minor

    figure('Name','SpecificThrustVMach')
    scatter(Mach, specific_thrust)
    xlabel('Mach')
    ylabel('Specific Thrust [N/(kg/s)]')
    grid on
    grid minor

    figure('Name','fVMach')
    scatter(Mach, total_fuel2air.SI)
    xlabel('Mach')
    ylabel('Fuel to Air Ratio')
    grid on
    grid minor

    figure('Name','ImpulseVMach')
    scatter(Mach, Impulse)
    xlabel('Mach')
    ylabel('Impulse [s]')
    grid on
    grid minor
    
    figure('Name','EffVThrust')
    scatter(thrust_ENGLISH, overall_efficiency)
    xlabel('\tau [lbf]')
    ylabel('\eta_o')
    grid on
    grid minor
end

%% Correlation
FULL_MATRIX = [T_a',...
               P_a',...
               thermal_efficiency',...
               prop_efficiency',...
               overall_efficiency',...
               thrust_ENGLISH',...
               TSFC',...
               fuel2air',...
               altitude',...
               specific_thrust',...
               mdot_a_nonbleed.SI',...
               Mach'];

FULL_MATRIX_NORM = [normalize_array(thermal_efficiency'),...
                    normalize_array(prop_efficiency'),...
                    normalize_array(overall_efficiency'),...
                    normalize_array(thrust_ENGLISH'),...
                    normalize_array(1./TSFC'),...
                    normalize_array(1./fuel2air'),...
                    normalize_array(altitude'),...
                    normalize_array(specific_thrust'),...
                    normalize_array(mdot_a_nonbleed.SI'),...
                    normalize_array(Mach')];
variable_table = array2table(FULL_MATRIX, 'VariableNames',...
                              {'Ta','Pa','thermalEff','propEff','overallEff',...
                              'thrustEnglish',...
                              'TSFC', 'fuel2air', 'altitude','specificThrust',...
                              'mdotA','Mach'});
%% Decision Matrix
rounds = 4;
permutations_considered = 10;
total_variables = 10;
total_conditions = 13;
overall_probability = zeros(total_conditions,1);
for round = [1:rounds]
    decision_weight = zeros(total_variables, permutations_considered);
    for ii = [1:permutations_considered]
        if permutations_considered > 6
            if ii == 1
                random_sample = [8;8;9;10;7;6;1;1;1;1];
            elseif ii == 2
                random_sample = [10;10;10;9;5;4;3;2;1;10];
            elseif ii == 3
                random_sample = [7;7;8;8;10;4;1;2;0;0];
            elseif ii == 4
                random_sample = [6;6;10;10;10;1;1;1;1;1];
            elseif ii == 5
                random_sample = [6;6;10;10;10;1;6;1;1;5];
            elseif ii == 6
                random_sample = [10;10;10;10;10;10;0;10;0;0];
            end
        else
            random_sample = rand(total_variables,1);
        end
        decision_weight(:,ii) = exp(random_sample)./sum(exp(random_sample));
    end
    decision_matrix = FULL_MATRIX_NORM * decision_weight;
    probability_array = zeros(total_conditions,1);
    for iii = [1:total_conditions]
        logits = decision_matrix(iii,:);
        probability_array(iii, 1) = sum(logits);
    end
    probability_array = exp(probability_array)./sum(exp(probability_array));
    overall_probability(:) = overall_probability(:) + probability_array(:);
end
overall_probability = log(exp(overall_probability)./rounds);
overall_probability = exp(overall_probability)./sum(exp(overall_probability));
if render == true 
    figure('NAME','PROBABILITY')
    plot(overall_probability, 'ko')
    ylabel('Probability')
    xlabel('Condition')
    ylim([0,1])
    grid on 
    grid minor
    correlate = false;
    if correlate == true
        corrplot(variable_table, 'type', 'Pearson', 'testR', 'on')
        corrplot(variable_table, 'type', 'Kendall', 'testR', 'on')
        corrplot(variable_table, 'type', 'Spearman', 'testR', 'on')
    end
end
SUMMARY_MATRIX = [100.*overall_probability,...
                  T_a',...
                  P_a',...
                  thermal_efficiency',...
                  prop_efficiency',...
                  overall_efficiency',...
                  thrust_ENGLISH',...
                  TSFC_ENGLISH',...
                  altitude',...
                  specific_thrust',...
                  mdot_a_nonbleed.SI',...
                  Mach',...
                  Impulse',...
                  mdot_f2.SI',...
                  total_fuel2air.SI',...
                  AB'];
summary_table = array2table(SUMMARY_MATRIX, 'VariableNames',...
                              {'Probability','Ta','Pa','thermalEff',...
                              'propEff','overallEff',...
                              'thrustEnglish',...
                              'TSFC', 'altitude','specificThrust',...
                              'mdotA','Mach', 'Specific_Impulse',...
                              'mdotF','fuel2air','Afterburner'})