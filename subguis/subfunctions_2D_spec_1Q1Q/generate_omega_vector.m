function [omega_vector_zp,time_vector_zp]=generate_omega_vector(time_vector,zeropadding,center_omega,gamma,Double_omega)
timestep=time_vector(2)-time_vector(1);
time_vector_zp = [time_vector time_vector(end)+timestep:timestep:time_vector(end)+(zeropadding-1)*length(time_vector)*timestep];
% odd number of elements in time_vector_zp
if mod(length(time_vector_zp),2)==1
    omega_vector_zp= -pi/(time_vector_zp(2)-time_vector_zp(1)):2*pi/time_vector_zp(end):pi/(time_vector_zp(2)-time_vector_zp(1));
% even number of elements in time_vector_zp    
else
   omega_vector_zp= (-pi/(time_vector_zp(2)-time_vector_zp(1)):2*pi/time_vector_zp(end):pi/(time_vector_zp(2)-time_vector_zp(1)))-pi/time_vector_zp(end);
end
if nargin >2
omega_vector_zp=omega_vector_zp+(1-gamma)*center_omega;
if exist('Double_omega','var')==1
    switch Double_omega
        case 'on'
            omega_vector_zp=omega_vector_zp+(1-gamma)*center_omega;
        case 'off'
            % Do nothing
    end
    
end
end
