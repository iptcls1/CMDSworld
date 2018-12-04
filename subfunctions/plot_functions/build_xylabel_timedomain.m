function [ xlabel,ylabel ] = build_xylabel_timedomain(option)

switch option
    case 'option1'
        xlabel='Delay \tau [fs]';
        ylabel='Delay t [fs]';
end
end

