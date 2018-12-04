function[outputboolean,Size_TimeDomainData]=check_input_data(TimeDomainData,tau_vector,T_vector,t_vector)
Size_TimeDomainData=size(TimeDomainData);
if ~isempty(TimeDomainData) && ~isempty(tau_vector) && ~isempty(T_vector) && ~isempty (t_vector)
   if length(tau_vector)==Size_TimeDomainData(1,2)
       outputboolean=true;
   end
   if length(T_vector)==Size_TimeDomainData(1,2)
       outputboolean=true;
   end
   if length(t_vector)==Size_TimeDomainData(1,2)
        outputboolean=true;
   end
else    
   outputboolean=false;
end
