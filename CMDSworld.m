function varargout = CMDSworld(varargin)
% CMDSWORLD MATLAB code for CMDSworld.fig
%      CMDSWORLD, by itself, creates a new CMDSWORLD or raises the existing
%      singleton*.
%
%      H = CMDSWORLD returns the handle to a new CMDSWORLD or the handle to
%      the existing singleton*.
%
%      CMDSWORLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CMDSWORLD.M with the given input arguments.
%
%      CMDSWORLD('Property','Value',...) creates a new CMDSWORLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CMDSworld_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CMDSworld_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CMDSworld

% Last Modified by GUIDE v2.5 23-Oct-2018 17:18:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CMDSworld_OpeningFcn, ...
                   'gui_OutputFcn',  @CMDSworld_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before CMDSworld is made visible.
function CMDSworld_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CMDSworld (see VARARGIN)

% Choose default command line output for CMDSworld
handles.output = hObject;
addpath(genpath('L:\Matlab Scripts\CMDSworld\subfunctions'),...
    genpath('L:\Matlab Scripts\CMDSworld\subguis'),...
    genpath('L:\Matlab Scripts\CMDSworld\demo_arrays'));

opengl hardware;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes CMDSworld wait for user response (see UIRESUME)
% uwait(handles.CMDSworld);
% --- Outputs from this function are returned to the command line.
function varargout = CMDSworld_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --------------------------------------------------------------------
function Menu_file_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Menu_File_Import_T_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_Import_T_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'TDdata')==1
handles.TDdata.TimeDomainData={};
handles.TDdata.tau_vector={};
handles.TDdata.T_vector={};
handles.TDdata.t_vector={};
handles.TDdata.variable_vector={};
handles.TDdata.name_of_TD_dataset={};
end

if ~isfield(handles,'structure')==1
handles.structure={};
end

[TimeDomainData, tau_vector, T_vector, t_vector, InputFolder,~,variable_vector,filename]=input_Time_data;
%store data in handles
handles.TDdata.TimeDomainData{end+1}=TimeDomainData;
handles.TDdata.tau_vector{end+1}=tau_vector;
handles.TDdata.T_vector{end+1}=T_vector;
handles.TDdata.t_vector{end+1}=t_vector;
handles.TDdata.variable_vector{end+1}=variable_vector;
handles.TDdata.name_of_TD_dataset{end+1}=filename;
handles.structure.InputFolder=InputFolder;

text='';
for ii=1:length(handles.TDdata.TimeDomainData)
    if isempty(variable_vector)
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii});
    else
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii},handles.TDdata.variable_vector{ii});
    end
    text=char(text,tmp_text);
end
    set(handles.textbox_input_summary,'Visible','on','String',text,'HorizontalAlignment','left',...
        'FontSize',10);

%enable TimeDomainMaps function
set(handles.Data_Time_Domain_Maps,'Enable','on');
set(handles.Menu_Data_2Dspec1Q1Q,'Enable','on');
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_file_exit_Callback(hObject, eventdata, handles)
out=modal_exit_question;
if strcmp(out,'Yes')
delete(handles.CMDSworld);
else
end
% --------------------------------------------------------------------
function Menu_File_import_phase_cycling_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_import_phase_cycling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'pcdata')==1
handles.pcdata.all_phases={};
handles.pcdata.all_weights={};
handles.pcdata.all_names_of_scheme={};
end

if ~isfield(handles,'structure')==1
handles.structure={};
end


if isfield(handles.structure,'InputFolder')==1
[phases,weights,name_of_scheme]=input_phase_cycling(handles.structure.InputFolder);
else
[phases,weights,name_of_scheme]=input_phase_cycling();
end
handles.pcdata.all_phases{end+1}=phases;
handles.pcdata.all_weights{end+1}=weights;
handles.pcdata.all_names_of_scheme{end+1}=name_of_scheme;
text='';
for ii=1:length(handles.pcdata.all_names_of_scheme)
tmp_text=generate_text_pc_input_summary(handles.pcdata.all_weights{ii},handles.pcdata.all_names_of_scheme{ii});
text=char(text,tmp_text);   
end

set(handles.text_pc_input_summary,'Visible','on','String',text,'FontSize',10,...
    'HorizontalAlignment','left');

guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_data_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Data_Time_Domain_Maps_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Time_Domain_Maps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(handles.TDdata.name_of_TD_dataset)>1
[name,number]=define_TimeDomain_dataset(handles.TDdata.name_of_TD_dataset);
number=number{1};
elseif length(handles.TDdata.name_of_TD_dataset)==1
 number=1;
end

maindata.TDdata.TimeDomainData=handles.TDdata.TimeDomainData{number};
maindata.TDdata.tau_vector=handles.TDdata.tau_vector{number};
maindata.TDdata.T_vector=handles.TDdata.T_vector{number};
maindata.TDdata.t_vector=handles.TDdata.t_vector{number};
maindata.TDdata.variable_vector=handles.TDdata.variable_vector{number};

[out1,out2,out3,out4,out5,out6]=Time_Domain_Maps(maindata);
handles.TDdata.name_of_TD_dataset{end+1}=out1{1};
handles.TDdata.TimeDomainData{end+1}=out2;
handles.TDdata.tau_vector{end+1}=out3;
handles.TDdata.T_vector{end+1}=out4;
handles.TDdata.t_vector{end+1}=out5;
if isfield(handles.TDdata,'variable_vector')
    handles.TDdata.variable_vector{end+1}=out6;
end
text='';
for ii=1:length(handles.TDdata.TimeDomainData)
    if isempty(handles.TDdata.variable_vector)
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii});
    else
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii},handles.TDdata.variable_vector{ii});
    end
    text=char(text,tmp_text);
end
    set(handles.textbox_input_summary,'Visible','on','String',text,'HorizontalAlignment','left',...
        'FontSize',10);
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_Data_2Dspec1Q1Q_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Data_2Dspec1Q1Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(handles.TDdata.name_of_TD_dataset)>1
[name,number]=define_TimeDomain_dataset(handles.TDdata.name_of_TD_dataset);
number=number{1};
elseif length(handles.TDdata.name_of_TD_dataset)==1
 number=1;
end

maindata.TDdata.TimeDomainData=handles.TDdata.TimeDomainData{number};
maindata.TDdata.tau_vector=handles.TDdata.tau_vector{number};
maindata.TDdata.T_vector=handles.TDdata.T_vector{number};
maindata.TDdata.t_vector=handles.TDdata.t_vector{number};
if ~isempty(handles.TDdata.variable_vector)
maindata.TDdata.variable_vector=handles.TDdata.variable_vector{number};
end
maindata.pcdata=handles.pcdata;
if isfield(handles,'figuredata')
   maindata.figuredata=handles.figuredata;
end
TwoDspec1Q1Q(maindata);
% --------------------------------------------------------------------
function Menu_File_import_CMDSfigure_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_import_CMDSfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'TDdata')==1
handles.TDdata.TimeDomainData={};
handles.TDdata.tau_vector={};
handles.TDdata.T_vector={};
handles.TDdata.t_vector={};
handles.TDdata.variable_vector={};
handles.TDdata.name_of_TD_dataset={};
end
[handles.figuredata, handles.structure.InputFolder,file]=input_CMDSfigure_file;
handles.TDdata.name_of_TD_dataset{end+1}=file;
handles.TDdata.TimeDomainData{end+1}=handles.figuredata.TimeDomainData;
handles.TDdata.tau_vector{end+1}=handles.figuredata.tau_vector_raw;
handles.TDdata.T_vector{end+1}=handles.figuredata.T_vector_raw;
handles.TDdata.t_vector{end+1}=handles.figuredata.t_vector_raw;
if isfield(handles.figuredata,'variable_vector')
  handles.TDdata.variable_vector{end+1}=handles.figuredata.variable_vector;
else
  handles.TDdata.variable_vector{end+1}=[];  
end
text='';
for ii=1:length(handles.TDdata.TimeDomainData)
    if isempty(handles.TDdata.variable_vector{ii})
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii});
    else
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii},handles.TDdata.variable_vector{ii});
    end
    text=char(text,tmp_text);
end
    set(handles.textbox_input_summary,'Visible','on','String',text,'HorizontalAlignment','left',...
        'FontSize',10);
set(handles.textbox_input_summary,'String',text,'Visible','on');

handles.SDdata.PC_SpecData_raw=handles.figuredata.PC_SpecData_raw;
handles.SDdata.w_tau_vector_raw=handles.figuredata.tau_vector_raw;
%handles.SDdata.T_vector=handles.figuredata.T_vector_raw;
handles.SDdata.w_t_vector_raw=handles.figuredata.t_vector_raw;
text=generate_text_input_summary_SpecDomain(handles.SDdata.PC_SpecData_raw,...
    handles.SDdata.w_tau_vector_raw,...
    handles.SDdata.w_t_vector_raw);
set(handles.text_spec_input_summary,'String',text,'Visible','on');

if ~isfield(handles,'pcdata')==1
handles.pcdata.all_phases={};
handles.pcdata.all_weights={};
handles.pcdata.all_names_of_scheme={};
end

if ~iscell(handles.figuredata.name_of_scheme)==1
    temp{1}=handles.figuredata.name_of_scheme;
    handles.figuredata.name_of_scheme=temp;
else
    for jj=1:length(handles.figuredata.name_of_scheme)
        handles.figuredata.name_of_scheme{jj}=[handles.figuredata.name_of_scheme{jj} '.mat'];
    end
    
end



for jj=1:length(handles.figuredata.name_of_scheme)
handles.pcdata.all_phases{end+1}={[0 0 0 0]};
handles.pcdata.all_weights{end+1}=handles.figuredata.weights{jj};
handles.pcdata.all_names_of_scheme{end+1}=handles.figuredata.name_of_scheme{jj};%.mat is necessary for 2D analyzer program to find the string
text='';
end

for ii=1:length(handles.pcdata.all_names_of_scheme)
tmp_text=generate_text_pc_input_summary(handles.pcdata.all_weights{ii},handles.pcdata.all_names_of_scheme{ii});
text=char(text,tmp_text);   
end

set(handles.text_pc_input_summary,'Visible','on','String',text,'FontSize',10,...
    'HorizontalAlignment','left');
set(handles.Data_Time_Domain_Maps,'Enable','on');
set(handles.Menu_Data_2Dspec1Q1Q,'Enable','on');
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_phase_cycling_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Menu_phase_cycling_phases_weights_calculator_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_phase_cycling_phases_weights_calculator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'pcdata')==1
handles.pcdata.all_phases={};
handles.pcdata.all_weights={};
handles.pcdata.all_names_of_scheme={};
end

if ~isfield(handles,'structure')==1
handles.structure={};
end

[phases,weights,name_of_scheme]=pc_weights_calculator_gui;
if ~isempty(phases)
    handles.pcdata.all_phases{end+1}=phases;
    handles.pcdata.all_weights{end+1}=weights;
    handles.pcdata.all_names_of_scheme{end+1}=name_of_scheme{1};
    text='';
    for ii=1:length(handles.pcdata.all_names_of_scheme)
    tmp_text=generate_text_pc_input_summary(handles.pcdata.all_weights{ii},handles.pcdata.all_names_of_scheme{ii});
    text=char(text,tmp_text);   
    end

    set(handles.text_pc_input_summary,'Visible','on','String',text,'FontSize',10,...
        'HorizontalAlignment','left');
end
guidata(hObject,handles);
% --------------------------------------------------------------------
function Data_Time_Domain_Calculations_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Time_Domain_Calculations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Output_TimeDomainData,Output_tau_vector,Output_T_vector,Output_t_vector,Output_variable_vector,Output_name]=...
    Time_Domain_Calculations(handles.TDdata.TimeDomainData,handles.TDdata.tau_vector,handles.TDdata.T_vector,...
    handles.TDdata.t_vector,handles.TDdata.variable_vector,handles.TDdata.name_of_TD_dataset);

handles.TDdata.name_of_TD_dataset{end+1}=Output_name{1};
handles.TDdata.TimeDomainData{end+1}=Output_TimeDomainData;
handles.TDdata.tau_vector{end+1}=Output_tau_vector;
handles.TDdata.T_vector{end+1}=Output_T_vector;
handles.TDdata.t_vector{end+1}=Output_t_vector;
if isfield(handles.TDdata,'variable_vector')
    handles.TDdata.variable_vector{end+1}=Output_variable_vector;
end
text='';
for ii=1:length(handles.TDdata.TimeDomainData)
    if isempty(handles.TDdata.variable_vector)
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii});
    else
    tmp_text=generate_text_input_summary(handles.TDdata.name_of_TD_dataset{ii},handles.TDdata.TimeDomainData{ii}, handles.TDdata.tau_vector{ii}, handles.TDdata.T_vector{ii}, handles.TDdata.t_vector{ii},handles.TDdata.variable_vector{ii});
    end
    text=char(text,tmp_text);
end
    set(handles.textbox_input_summary,'Visible','on','String',text,'HorizontalAlignment','left',...
        'FontSize',10);
guidata(hObject,handles);
