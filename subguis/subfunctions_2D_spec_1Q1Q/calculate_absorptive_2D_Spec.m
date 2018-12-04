function [SpecDomainData_absorptive]=calculate_absorptive_2D_Spec(PC_time_data_rephasing,PC_time_data_nonrephasing,tau_vector,T_vector,t_vector)
SpecDomainData_rephasing=zeros(length(tau_vector),length(T_vector),length(t_vector));
SpecDomainData_nonrephasing=zeros(length(tau_vector),length(T_vector),length(t_vector));
SpecDomainData_absorptive=zeros(length(tau_vector),length(T_vector),length(t_vector));
% calculate Rephasing
for ii=1:length(T_vector)
SpecDomainData_rephasing(:,ii,:) = fftshift(fft2(squeeze(PC_time_data_rephasing(:,ii,:)),length(tau_vector),length(t_vector)));
end

% calculate Nonrephasing
for ii=1:length(T_vector)
SpecDomainData_nonrephasing(:,ii,:) = fftshift(fft2(squeeze(PC_time_data_nonrephasing(:,ii,:)),length(tau_vector),length(t_vector)));
end

% calculate Absorptive

for ii=1:length(T_vector)
%SpecDomainData_absorptive(:,ii,:) = real(fliplr(squeeze(SpecDomainData_rephasing(:,ii,:)))+...
%        squeeze(SpecDomainData_nonrephasing(:,ii,:)));
    if mod(length(tau_vector),2)==1 && mod(length(t_vector),2)==1
    SpecDomainData_absorptive(:,ii,:) = real(flip(squeeze(SpecDomainData_rephasing(:,ii,:)),1)+...
            squeeze(SpecDomainData_nonrephasing(:,ii,:)));
    elseif mod(length(tau_vector),2)==0 
    % in case of even number of tau_vector elements, the 0 freq is not in the
    % center, hence, the position will change when the matrix is flipped. In
    % order to match the zero positions of rephasing and nonrephasing
    % contribution the matrix has to be shifted
    Flipped_rephasing=flip(squeeze(SpecDomainData_rephasing(:,ii,:)),1);
    Shifted_rephasing=zeros(size(Flipped_rephasing));
    Shifted_rephasing(2:end,:)=Flipped_rephasing(1:end-1,:);

    SpecDomainData_absorptive(:,ii,:) = real(Shifted_rephasing+...
            squeeze(SpecDomainData_nonrephasing(:,ii,:)));     
    SpecDomainData_absorptive(1,ii,:)=0;  
    elseif mod(length(tau_vector),2)==1 && mod(length(t_vector),2)==0
    SpecDomainData_absorptive(:,ii,:) = real(flip(squeeze(SpecDomainData_rephasing(:,ii,:)),1)+...
            squeeze(SpecDomainData_nonrephasing(:,ii,:)));
    end

end

