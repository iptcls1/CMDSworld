function [weights,TimeOrSpec,operation,name_of_scheme]=get_operation_from_list_entry(listentry,all_weights,all_names_of_scheme,value)
snipped_text=strsplit(listentry,' ');
switch snipped_text{1}
    case 'real'
        operation='realpart';
    case 'imag'
        operation='imagpart';
    case 'abs'
        operation='absolute';
    case 'Absorptive';
        operation='absorptive';
end
switch snipped_text{3}
    case '2DSpec'
        TimeOrSpec='2DSpectrum';
    case 'TimeMap'
        TimeOrSpec='TimeMap';
end

logical=0;
loc=0;
ii=1;
if strcmp(operation,'absorptive')==0 
    name_of_scheme=[snipped_text{5} '.mat'];
    while logical==0
    if strcmp('default.mat',name_of_scheme)==1;
        loc=1;
        logical=1;
    else
    logical=strcmp(all_names_of_scheme{ii},name_of_scheme);
    loc=loc+1;
    ii=ii+1;
    end
    weights=all_weights{loc};
    end
elseif strcmp(operation,'absorptive')==1 
    [outweights, outnames]=define_rephasing_nonrephasing(all_names_of_scheme,all_weights);
    if isempty(outweights)==0
        weights=outweights;
        name_of_scheme=outnames;
    else
        weights=all_weights{1};
        operation='abs';
    end
        
end
