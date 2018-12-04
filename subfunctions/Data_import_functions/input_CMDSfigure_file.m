function [figure_data,path,file]=input_CMDSfigure_file
[file,path] = uigetfile('*.mat','Input CMDSfigure file','Input CMDSfigure file');
if isequal(file,0)
   disp('User selected Cancel');
   error('no input data!');
else
   figure_data=load(fullfile(path,file));
   figure_data=figure_data.figure_data;
   inputfolder=path;
end