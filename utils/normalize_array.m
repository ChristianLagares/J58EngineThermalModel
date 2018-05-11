%% Normalize

function [normalized_output] = normalize_array(x)
    % normalize returns the input array with a zero mean and a standard
    % deviation of one.
    normalized_output = (x-mean(x))./std(x);
end