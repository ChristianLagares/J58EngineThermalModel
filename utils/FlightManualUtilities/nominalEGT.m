%% Nominal Exhaust Gas Temperature 
%
%
%% CODE
function egt = nominalEGT(CompressorInletTemperature)
    assert(all(CompressorInletTemperature) > -50, 'Off Limits');
    egt = zeros(size(CompressorInletTemperature));

    egt(CompressorInletTemperature <= 10) = 570 + ((810 - 570)/(10-(-50)))*(CompressorInletTemperature(CompressorInletTemperature <= 10)+50);
    egt(CompressorInletTemperature > 10 & CompressorInletTemperature < 50) = 820 + ((780-810)/(50-10))*(CompressorInletTemperature(CompressorInletTemperature > 10 & CompressorInletTemperature < 50) - 10);
    egt(CompressorInletTemperature >= 50) = 795;
end