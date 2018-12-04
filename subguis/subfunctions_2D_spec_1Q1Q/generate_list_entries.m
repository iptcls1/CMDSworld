function text=generate_list_entries(all_weights,all_names_of_scheme)
text=[];


for ii=1:length(all_weights)
  snipped_name=strsplit(all_names_of_scheme{ii},'.mat');
  tmp_text=strvcat(['real - 2DSpec - ' snipped_name{1}],...
      ['imag - 2DSpec - ' snipped_name{1}],...
      ['abs - 2DSpec - ' snipped_name{1}],...
      ['real - TimeMap - ' snipped_name{1}],...
      ['imag - TimeMap - ' snipped_name{1}],...
      ['abs - TimeMap - ' snipped_name{1}]);  
  text=char(text,tmp_text);
end

if length(all_weights)>1
    text=char(text,'Absorptive - 2DSpec');
end







