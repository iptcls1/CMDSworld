function [TimeDomainData, tau_vector, T_vector, t_vector, InputFolder, Time_Domain_Size,variable_vector,file_out]=input_Time_data
% Get 4D Time Domain Data
[file,path] = uigetfile('*.mat','Input 3D, 4D or 5D Time Domain Data','TimeDomainData');
if isequal(file,0)
   disp('User selected Cancel');
   error('no input data!');
else
   TimeDomainData=struct2cell(load(fullfile(path,file)));
   TimeDomainData=TimeDomainData{:,:,:,:};
   InputFolder=path;
end
file_out=file;
[TimeDomainData, T_vector,NumDim]=define_Time_Domain_input_structure(TimeDomainData);
Time_Domain_Size=size(TimeDomainData);
%input tau vector
[file,path] = uigetfile(fullfile(InputFolder,'*.mat'),'Input tau vector');
if isequal(file,0)
   disp('User selected Cancel');
else
   tau_vector=struct2cell(load(fullfile(path,file)));
   tau_vector=tau_vector{:};
   % check consistency with TimeDomainData
   if length(tau_vector)~=Time_Domain_Size(1,2);
       msgbox('tau vector length is inconsistent to time domain dataset')
   end
end
% Check wether T axis consist of single or multiple elements
%input T vector
if isempty(T_vector)
        [file,path] = uigetfile(fullfile(InputFolder,'*.mat'),'Input T vector');
    if isequal(file,0)
       disp('User selected Cancel');
    else
       T_vector=struct2cell(load(fullfile(path,file)));
       T_vector=T_vector{:};
               % check consistency with TimeDomainData
           if length(T_vector)~=Time_Domain_Size(1,3);
               msgbox('T vector length is inconsistent to time domain dataset')
           end
    end
end

%input t vector
[file,path] = uigetfile(fullfile(InputFolder,'*.mat'),'Input t vector');
if isequal(file,0)
   disp('User selected Cancel');
else
   t_vector=struct2cell(load(fullfile(path,file)));
   t_vector=t_vector{:};
       % check consistency with TimeDomainData
           if length(t_vector)~=Time_Domain_Size(1,4) && NumDim<5;
               msgbox('t vector length is inconsistent to time domain dataset')
           end
end
variable_vector=[];
if NumDim==5
       [file,path] = uigetfile(fullfile(InputFolder,'*.mat'),'Input variable vector');
    if isequal(file,0)
       disp('User selected Cancel');
    else
       variable_vector=struct2cell(load(fullfile(path,file)));
       variable_vector=variable_vector{:};
           % check consistency with TimeDomainData
               if length(variable_vector)~=Time_Domain_Size(1,5);
                   msgbox('variable vector length is inconsistent to time domain dataset')
               end
    end 
end
