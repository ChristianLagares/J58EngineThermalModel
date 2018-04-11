%% Nominal Exhaust Gas Temperature 
%
%
%% CODE
function egt = nominalEGT(CompressorInletTemperature)
    assert(CompressorInletTemperature > -50, 'Off Limits');
    if CompressorInletTemperature <= 10
        egt = 570 + ((810 - 570)/(10-(-50)))*(CompressorInletTemperature+50);
    elseif CompressorInletTemperature > 10 && CompressorInletTemperature < 50
        egt = 820 + ((780-810)/(50-10))*(CompressorInletTemperature - 10);
    elseif CompressorInletTemperature >= 50
        egt = 795;
    end
end