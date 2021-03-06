function [ xlabel,ylabel ] = build_xylabel_specdomain(option,Units)
switch option
    case 'option1'
        switch Units
            case 'eV'
                xlabel='$\hbar \omega_{\tau}$ \sf[eV]';
                ylabel='$\hbar \omega_t$  \sf[eV]';
            case 'meV'
                xlabel='$\hbar \omega_{\tau}$ \sf[meV]';
                ylabel='$\hbar \omega_t$ \sf[meV]';
            case 'Hz'
                xlabel='$\nu_{\tau}$ \sf[Hz]';
                ylabel='$\nu_t$ \sf[Hz]';
            case 'GHz'
                xlabel='$\nu_{\tau}$ \sf[GHz]';
                ylabel='$\nu_t$ \sf[GHz]';
            case 'THz'
                xlabel='$\nu_{\tau}$ \sf[THz]';
                ylabel='$\nu_t$ \sf[THz]';
            case 'PHz'
                xlabel='$\nu_{\tau}$ \sf[PHz]';
                ylabel='$\nu_t$  \sf[PHz]';
            case 'wavenumber'
                xlabel='$\tilde{\nu}_{\tau} [cm^{-1}]$';
                ylabel='$\tilde{\nu}_{t} [cm^{-1}]$';
            case 'rad/fs'
                xlabel='$\omega_{\tau}$ \sf[rad/fs]';
                ylabel='$\omega_{t}$ \sf[rad/fs]';    
        end
end

