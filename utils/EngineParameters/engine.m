%% Engine Specs
%
% mf

%% CODE
function [engine_specs] = engine(args)
% DOCSTRING
    WET_THRUST = 34000; % lbf
    DRY_THRUST 
    SFC = 1.9; % lb/lbf
    engine_specs = struct('WET_THRUST', WET_THRUST);
end