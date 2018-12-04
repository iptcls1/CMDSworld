% function imports phase cycling .mat file
function [phases,weights,name_of_scheme]=input_phase_cycling(InputFolder)
if nargin>0
[file,path] = uigetfile(fullfile([InputFolder '*.mat']),'Input phase-cycling data');
else
[file,path] = uigetfile('\*.mat','Input phase-cycling data','phase_cycling_scheme');
end
if isequal(file,0)
   disp('User selected Cancel');
   error('no input data!');
else
   tmp=struct2cell(load(fullfile(path,file)));
   phases=tmp{1};
   weights=tmp{2};
   name_of_scheme=file;
end
