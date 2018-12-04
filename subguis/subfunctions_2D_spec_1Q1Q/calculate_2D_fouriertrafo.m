function SpecDomainData= calculate_2D_fouriertrafo(PC_TimeDomainData,tau_vector,T_vector,t_vector)
SpecDomainData=zeros(length(tau_vector),length(T_vector),length(t_vector));
for ii=1:length(T_vector)
SpecDomainData(:,ii,:) = fftshift(fft2(squeeze(PC_TimeDomainData(:,ii,:)),length(tau_vector),length(t_vector)));
end