function TimeDomainData_new=do_TD_normalization(TimeDomainData,Normalization_array)
SizeTDdata=size(TimeDomainData);
TimeDomainData_new=zeros(SizeTDdata);
if ndims(TimeDomainData)==4
   for mm=1:SizeTDdata(1)
       for nn=1:SizeTDdata(3)
           TimeDomainData_new(mm,:,nn,:)=squeeze(TimeDomainData(mm,:,nn,:))./Normalization_array(mm,nn);
       end
   end
elseif ndims(TimeDomainData)==5
    for mm=1:SizeTDdata(1)
       for nn=1:SizeTDdata(3)
           for oo=1:SizeTDdata(5)
           TimeDomainData_new(mm,:,nn,:,oo)=squeeze(TimeDomainData(mm,:,nn,:,oo))./Normalization_array(mm,nn,oo);
           end
       end
    end   
end
   