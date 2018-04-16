%% Main Routine
%
% This file contains the main routine for the J58 Thermal Model.
%
% All other files are required to be in the same directory.
%% Routine Body
%
[altitude, Mach, Afterburner] = condition_vectorizer();
[P2, T2] = inlet(altitude, Mach, 0);
