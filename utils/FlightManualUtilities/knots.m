%% knots

%% Code
function speed = knots(x, units)
    % Docstring
    if units == 'ft/s'
        speed = x .* 1.69;
    elseif units == 'mph'
        speed = x .* 1.15;
    elseif units == 'm/s'
        speed = x .* 0.51;
    elseif units == 'km/h'
        speed = x .* 1.85;
    end 
end