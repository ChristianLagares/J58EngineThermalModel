%% Nominal Exhaust Gas Temperature 
%
%
%% CODE
function egt = nominalEGT(CompressorInletTemperature)
    if max(size(CompressorInletTemperature)) == 1
        if CompressorInletTemperature <= 10
            egt = 570 + ((810 - 570)/(10-(-50)))*CompressorInletTemperature;
        elseif CompressorInletTemperature > 10 && CompressorInletTemperature < 50
            egt = 820 + ((780-810)/(50-10))*(CompressorInletTemperature - 10);
        elseif CompressorInletTemperature >= 50
            egt = 795;
        end
    else
        egt = zeros(1,max(size(CompressorInletTemperature)));
        for ii = [1:max(size(CompressorInletTemperature))]
            if CompressorInletTemperature(ii) <= 10
                egt(ii) = 570 + ((810 - 570)/(10-(-50)))*CompressorInletTemperature(ii);
            elseif CompressorInletTemperature(ii) > 10 && CompressorInletTemperature(ii) < 50
                egt(ii) = 820 + ((780-810)/(50-10))*(CompressorInletTemperature(ii) - 10);
            elseif CompressorInletTemperature(ii) >= 50
                egt(ii) = 795;
            end
        end
    end
end