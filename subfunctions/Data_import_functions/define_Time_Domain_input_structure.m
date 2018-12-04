function [Output_Time_Domain_Data, T_vector,NumDim]=define_Time_Domain_input_structure(Input_Time_Domain_Data)
SizeInput=size(Input_Time_Domain_Data);

% Get Number of Dimensions of Input Time Domain Data
NumDim=length(SizeInput);


if NumDim==3
    msgbox('Input from three-pulse experiment. Structure of data input has to be D(pc steps,tau vector,t vector)!')
    Output_Time_Domain_Data=zeros(SizeInput(1),SizeInput(2),1,SizeInput(3));
    Output_Time_Domain_Data(:,:,1,:)=Input_Time_Domain_Data;
    T_vector=0;
elseif NumDim==4
    InputStructure=define_input_structure;
    switch InputStructure
        case 'D(pc,tau,T,t)'
            Output_Time_Domain_Data=Input_Time_Domain_Data;
            T_vector=[];
        case 'D(pc,tau,t,variable)'
            %generate 5D array D(pc,tau,T=0,t,variable)
            Output_Time_Domain_Data=zeros(SizeInput(1),SizeInput(2),1,SizeInput(3),SizeInput(4));
            Output_Time_Domain_Data(:,:,1,:,:)=Input_Time_Domain_Data;
            T_vector=0;
            NumDim=5;
        case 'Cancel'
            error('User Canceled input');
    end
elseif NumDim==5
    Output_Time_Domain_Data=Input_Time_Domain_Data;
    T_vector=[];
end
