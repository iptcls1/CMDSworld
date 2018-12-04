function text=define_list_entries_time_domain_datasets(names)

for ii=1:length(names)
  snipped_name=strsplit(names{ii},'.mat');
  tmp_text=[snipped_name{1}];
  if ~exist('text','var')==1
  text=tmp_text;
  else
  text=char(text,tmp_text);
  end
    
end