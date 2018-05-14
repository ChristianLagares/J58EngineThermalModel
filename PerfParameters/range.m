%% Range
%
% INSERT DOC
%% CODE
function [S] = range(eta_overall, LHV, L2D)
    % This function assumes full tank to near empty tank.
    m1 = 78000; % kg
    m2 = 30600; % kg
    S = ((eta_overall.*LHV)./9.81).*L2D.*(log(m1./m2));
end