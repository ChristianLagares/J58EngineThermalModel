%% Altitude Converter
%
%
%% Code

function [length] = altitude_converter(z, given_units, required_units)
    % Docstring
    given_units = lower(given_units);
    required_units = lower(required_units);
    if given_units == 'ft'
        if required_units == 'm'
            length = z .* 0.3;
        elseif required_units == 'km'
            length = (z .* 0.3)./1000;
        end
    elseif given_units == 'm'
       if required_units == 'ft'
           length = z .* 3.281;
       elseif required_units == 'km'
           length = z./1000;
       end
    elseif given_units == 'km'
        z = z .* 1000;
        if required_units == 'm'
            length = z;
        else
            length = altitude_converter(z, 'm', required_units);
        end
    end
            
end