function [text] = generarte_list_entries_def_reph_nonreph(all_names_of_scheme,all_weights)


for ii=1:length(all_weights)
  snipped_name=strsplit(all_names_of_scheme{ii},'.mat');
  tmp_text=[snipped_name{1}];
  if ~exist('text','var')==1
  text=tmp_text;
  else
  text=char(text,tmp_text);
  end
end





