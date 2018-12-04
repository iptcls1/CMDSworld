function [phase_cycled_time_data_rephasing,phase_cycled_time_data_nonrephasing]=...
    calculate_absorptive_time_data(TimeDomainData,weights,Zeropadding)

SizeTimeDomain=size(TimeDomainData);
SizeWeights=size(weights{1});   
Delaysteps_tau=SizeTimeDomain(2);
Delaysteps_T=SizeTimeDomain(3);
Delaysteps_t=SizeTimeDomain(4);

% perform phase cycling in time domain for rephasing nonrephasing

if SizeTimeDomain(1,1)~=SizeWeights(1,1)
    msgbox('PC data and time domain data are not consistent');
    error('PC data and time domain data are not consistent');
else
    %calculate rephasing time data
    phase_cycled_time_data_rephasing=zeros(SizeTimeDomain(2:4));
    
    for ii=1:SizeWeights(1,1)
    phase_cycled_time_data_rephasing = phase_cycled_time_data_rephasing+weights{1}(ii)*...
       reshape(TimeDomainData(ii,:,:,:),[SizeTimeDomain(2:end) 1]);
    end
        %perform zero padding
    if Zeropadding>1
        phase_cycled_time_data_zp=zeros(Delaysteps_tau*Zeropadding,Delaysteps_T,Delaysteps_t*Zeropadding);
        phase_cycled_time_data_zp(1:Delaysteps_tau,1:Delaysteps_T,1:Delaysteps_t)=phase_cycled_time_data_rephasing;
        phase_cycled_time_data_rephasing=phase_cycled_time_data_zp;
    end
    
    phase_cycled_time_data_rephasing(1,:)=0.5*phase_cycled_time_data_rephasing(1,:);
    phase_cycled_time_data_rephasing(:,1)=0.5*phase_cycled_time_data_rephasing(:,1);  
    phase_cycled_time_data_rephasing(1,1)=2*phase_cycled_time_data_rephasing(1,1);
    
    
    
    %calculate nonrephasing time data
    phase_cycled_time_data_nonrephasing=zeros(SizeTimeDomain(2:4));    
    for ii=1:SizeWeights(1,1)
    phase_cycled_time_data_nonrephasing = phase_cycled_time_data_nonrephasing+weights{2}(ii)*...
       reshape(TimeDomainData(ii,:,:,:),[SizeTimeDomain(2:end) 1]);
    end
        %perform zero padding
    if Zeropadding>1
        phase_cycled_time_data_zp=zeros(Delaysteps_tau*Zeropadding,Delaysteps_T,Delaysteps_t*Zeropadding);
        phase_cycled_time_data_zp(1:Delaysteps_tau,1:Delaysteps_T,1:Delaysteps_t)=phase_cycled_time_data_nonrephasing;
        phase_cycled_time_data_nonrephasing=phase_cycled_time_data_zp;
    end
    
    phase_cycled_time_data_nonrephasing(1,:)=0.5*phase_cycled_time_data_nonrephasing(1,:);
    phase_cycled_time_data_nonrephasing(:,1)=0.5*phase_cycled_time_data_nonrephasing(:,1);  
    phase_cycled_time_data_nonrephasing(1,1)=2*phase_cycled_time_data_nonrephasing(1,1);
end