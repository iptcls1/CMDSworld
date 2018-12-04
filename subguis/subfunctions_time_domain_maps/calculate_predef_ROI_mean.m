function [Normalization_array,pos_tau,pos_t]=calculate_predef_ROI_mean(TimeDomainData,tau_vector,t_vector,Percentage)

SizeTDdata=size(TimeDomainData);
NumberPCsteps=SizeTDdata(1);
NumberTsteps=SizeTDdata(3);
if length(SizeTDdata)==5
NumberVarsteps=SizeTDdata(5);
else
NumberVarsteps=1;
end

% calculate last percentage percent of time vector
perc_tau_vector=round((1-Percentage)*length(tau_vector));
perc_t_vector=round((1-Percentage)*length(t_vector));
pos_tau=[tau_vector(perc_tau_vector) tau_vector(end)];
pos_t=[t_vector(perc_t_vector) t_vector(end)];

if length(SizeTDdata)==5
Normalization_array=zeros(SizeTDdata(1),SizeTDdata(3),SizeTDdata(5));
    for ii=1:NumberPCsteps
            for nn=1:NumberTsteps
                for oo=1:NumberVarsteps
                    Normalization_array(ii,nn,oo)=mean(mean(squeeze(TimeDomainData(ii,perc_tau_vector:end,nn,perc_t_vector:end,oo))));
                end
            end
    end
else
Normalization_array=zeros(SizeTDdata(1),SizeTDdata(3));
    for ii=1:NumberPCsteps
        for nn=1:NumberTsteps
                Normalization_array(ii,nn)=mean(mean(squeeze(TimeDomainData(ii,perc_tau_vector:end,nn,perc_t_vector:end))));
        end
    end
end

