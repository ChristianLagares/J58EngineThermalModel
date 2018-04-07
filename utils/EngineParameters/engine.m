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
% DOCSTRING
    WET_THRUST              = 34000;                       % lbf
    DRY_THRUST              = 25000;                       % lbf
    SFC                     = 1.9;                         % lb/lbf*hr
    AFTERBURNER_FUEL_hr     = SFC * WET_THRUST;            % lb/hr
    NO_AFTERBURNER_FUEL_hr  = SFC * DRY_THRUST;            % lb/hr
    AFTERBURNER_FUEL_sec    = AFTERBURNER_FUEL_hr/3600;    %
    NO_AFTERBURNER_FUEL_sec = NO_AFTERBURNER_FUEL_hr/3600;
    engine_specs = struct('WET_THRUST', WET_THRUST,...
                          'DRY_THRUST', DRY_THRUST,...
                          'AFTERBURNER_FUEL_perHour', AFTERBURNER_FUEL_hr,...
                          'NO_AFTERBURNER_FUEL_perHour', NO_AFTERBURNER_FUEL_hr,...
                          'AFTERBURNER_FUEL_perSecond', AFTERBURNER_FUEL_sec,...
                          'NO_AFTERBURNER_FUEL_perSecond', NO_AFTERBURNER_FUEL_sec);
end