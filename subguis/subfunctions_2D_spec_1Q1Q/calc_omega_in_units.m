function [omega_axis_new_units]=calc_omega_in_units(object,units)
omega_rad_fs=object;
switch units
    case 'rad/fs'
        omega_axis_new_units=omega_rad_fs;
    case 'meV'
        % calculate hbar over e
        hbar_e=1.0545718e-34/1.60217662e-19;
        omega_axis_new_units=1000*hbar_e*omega_rad_fs*1e15;
    case 'eV'
    % calculate hbar over e
    hbar_e=1.0545718e-34/1.60217662e-19;
    omega_axis_new_units=hbar_e*omega_rad_fs*1e15;
    case 'Hz'
        omega_axis_new_units=omega_rad_fs/(2*pi)*1e15;
    case 'GHz'
    omega_axis_new_units=omega_rad_fs/(2*pi)*1e15*1e-9;
    case 'THz'
    omega_axis_new_units=omega_rad_fs/(2*pi)*1e15*1e-12;
    case 'PHz'
    omega_axis_new_units=omega_rad_fs/(2*pi)*1e15*1e-15;
    case 'wavenumber'
        %speed of light
    c=299792458;%m/s
    omega_axis_new_units=omega_rad_fs*1e15/(2*pi*c)*1/100;
end
    
end
