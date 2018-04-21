%% Engine Specs
%
% Basic engine parameters are provided in a structure.
%
% engine_specs:
% 
%     * WET_THRUST
%     * DRY_THRUST
%     * SFC
%     * AFTERBURNER_FUEL_perHour
%     * NO_AFTERBURNER_FUEL_perHour
%     * AFTERBURNER_FUEL_perSecond
%     * NO_AFTERBURNER_FUEL_perSecond


%% CODE
function [engine_specs] = engine()
    % Published Specs
    WET_THRUST = 34000; % lbf
    DRY_THRUST = 25000; % lbf
    WET_SFC = 1.9; % lb/lbf*hr
    DRY_SFC = 0.8; % lb/lbf*hr
    CORE_AIRFLOW = 450; % lb
    COMPRESSION_RATIO = 8.8; 
    
    WET_FUEL_hr = WET_SFC * WET_THRUST; % lb/hr
    DRY_FUEL_hr = DRY_SFC * DRY_THRUST; % lb/hr
    WET_FUEL_sec = WET_FUEL_hr/3600; % lb/sec
    DRY_FUEL_sec = DRY_FUEL_hr/3600; %lb/sec
    
    engine_specs = struct('WET_THRUST', WET_THRUST,...
                          'DRY_THRUST', DRY_THRUST,...
                          'WET_FUEL_perHour', WET_FUEL_hr,...
                          'DRY_FUEL_perHour', DRY_FUEL_hr,...
                          'WET_FUEL_perSecond', WET_FUEL_sec,...
                          'DRY_FUEL_perSecond', DRY_FUEL_sec,...
                          'DRY_SFC', DRY_SFC,...
                          'WET_SFC', WET_SFC,...
                          'CORE_AIRFLOW', CORE_AIRFLOW,...
                          'COMPRESSION_RATIO', COMPRESSION_RATIO);
end