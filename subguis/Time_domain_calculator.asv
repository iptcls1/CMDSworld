function OutputTimeDomainMap=Time_domain_calculator(TimeDomainMap1,TimeDomainMap2,operation)
%check dimensions
% in this version operation is only possible if all dimensions are equal

if isequal(size(TimeDomainMap1),size(TimeDomainMap2))==0
    msgbox('Dimensions of Time Maps are not equal. Calculation not possible!');
    error('Dimensions of Time Maps are not equal. Calculation not possible!');
else
    TDsize=size(TimeDomainMap1);
    OutputTimeDomainMap=zeros(TDsize);
   switch operation
       case 'ADD     ' 
           
           for ii=1:TDsize(1) %for all pc steps
            if ndims(TimeDomainMap1)==4   
            OutputTimeDomainMap(ii,:,:,:)=squeeze(TimeDomainMap1(ii,:,:,:))+squeeze(TimeDomainMap2(ii,:,:,:));
            elseif ndims(TimeDomainMap1)==5
            OutputTimeDomainMap(ii,:,:,:,:)=squeeze(TimeDomainMap1(ii,:,:,:,:))+squeeze(TimeDomainMap2(ii,:,:,:,:));
            end
           end
       case 'SUBTRACT'
                      
           for ii=1:TDsize(1) %for all pc steps
            if ndims(TimeDomainMap1)==4   
            OutputTimeDomainMap(ii,:,:,:)=squeeze(TimeDomainMap1(ii,:,:,:))-squeeze(TimeDomainMap2(ii,:,:,:));
            elseif ndims(TimeDomainMap1)==5
            OutputTimeDomainMap(ii,:,:,:,:)=squeeze(TimeDomainMap1(ii,:,:,:,:))-squeeze(TimeDomainMap2(ii,:,:,:,:));
            end
           end
   end
end
