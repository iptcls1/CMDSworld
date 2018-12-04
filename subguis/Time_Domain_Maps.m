function varargout = Time_Domain_Maps(varargin)
%TIME_DOMAIN_MAPS M-file for Time_Domain_Maps.fig
%      TIME_DOMAIN_MAPS, by itself, creates a new TIME_DOMAIN_MAPS or raises the existing
%      singleton*.
%
%      H = TIME_DOMAIN_MAPS returns the handle to a new TIME_DOMAIN_MAPS or the handle to
%      the existing singleton*.
%
%      TIME_DOMAIN_MAPS('Property','Value',...) creates a new TIME_DOMAIN_MAPS using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Time_Domain_Maps_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TIME_DOMAIN_MAPS('CALLBACK') and TIME_DOMAIN_MAPS('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TIME_DOMAIN_MAPS.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Time_Domain_Maps

% Last Modified by GUIDE v2.5 13-Aug-2018 17:47:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Time_Domain_Maps_OpeningFcn, ...
                   'gui_OutputFcn',  @Time_Domain_Maps_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Time_Domain_Maps is made visible.
function Time_Domain_Maps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Time_Domain_Maps
handles.output = hObject;
maindata=varargin{1};
% Update handles structure
guidata(hObject, handles);
%get data from Main Gui
%maindata=guidata(CMDSworld);
handles.maindata=maindata;

%check data availability

checkavail=check_input_data(maindata.TDdata.TimeDomainData,...
    maindata.TDdata.tau_vector,...
    maindata.TDdata.T_vector,...
    maindata.TDdata.t_vector);

if checkavail==false
    error('Data not available!');
end
% call first plot function


handles.Tpos=1;
handles.PCpos=1;
handles.ROI_norm.ROIdata.ROI_data_x=[];
handles.ROI_norm.ROIdata.ROI_data_y=[];


if isfield(maindata,'figuredata')
    if isfield(maindata.figuredata,'Varpos');
        handles.Varpos=maindata.figuredata.Varpos;
    else 
        handles.Varpos=1;
    end
else
  handles.Varpos=1; 
end
if ndims(maindata.TDdata.TimeDomainData)<5
    TimeDomainData=squeeze(handles.maindata.TDdata.TimeDomainData);
else
    TimeDomainData(:,:,:,:)=handles.maindata.TDdata.TimeDomainData(:,:,:,:,handles.Varpos);
end


axes(handles.Time_Domain_axes);
plotfunction_Time_Domain_maps(TimeDomainData,...
    handles.maindata.TDdata.tau_vector,...
    handles.maindata.TDdata.T_vector,...
    handles.maindata.TDdata.t_vector,...
    handles.PCpos,handles.Tpos,'','',[],[],[],[],[],...
    handles.ROI_norm.ROIdata);
set(handles.text_time_T,'String',['Time T = ' num2str(maindata.TDdata.T_vector(handles.Tpos)) ' fs']);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%set slider presettings
%%%%%%%%%%%%%%%%%%%%%%%%%%
SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
set(handles.slider_pc_step,'Min',1)
set(handles.slider_pc_step,'Max',SizeTimeDomainData(1,1));
Max=get(handles.slider_pc_step,'Max');
set(handles.slider_pc_step,'SliderStep',[1/(Max-1) 1/(Max-1)]);
set(handles.slider_pc_step,'Value',1);

NumDim=ndims(handles.maindata.TDdata.TimeDomainData);
if NumDim<5
set(handles.slider_varible_step_position,'Value',0);
set(handles.slider_varible_step_position,'Visible','off');
else
set(handles.text_variable_scan,'Visible','on');    
set(handles.slider_varible_step_position,'Visible','on');
set(handles.slider_varible_step_position,'Min',1);
set(handles.slider_varible_step_position,'Max',SizeTimeDomainData(1,5));
Max=get(handles.slider_varible_step_position,'Max');
set(handles.slider_varible_step_position,'SliderStep',[1/(Max-1) 1/(Max-1)]);
set(handles.slider_varible_step_position,'Value',1);
end

if SizeTimeDomainData(1,3)==1
set(handles.slider_T_step,'Value',0);    
else
set(handles.slider_T_step,'Min',1)
set(handles.slider_T_step,'Max',SizeTimeDomainData(1,3));
Max=get(handles.slider_T_step,'Max');
set(handles.slider_T_step,'SliderStep',[1/(Max-1) 1/(Max-1)]);
set(handles.slider_T_step,'Value',1);
end

guidata(hObject,handles);



% UIWAIT makes Time_Domain_Maps wait for user response (see UIRESUME)
 uiwait(handles.Time_domain_maps);


% --- Outputs from this function are returned to the command line.
function varargout = Time_Domain_Maps_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.new_TimaDomainMap_name;
varargout{2} = handles.new_TimeDomainMap;
varargout{3} = handles.maindata.TDdata.tau_vector;
varargout{4} = handles.maindata.TDdata.T_vector;
varargout{5} = handles.maindata.TDdata.t_vector;
if isfield(handles.maindata.TDdata,'variable_vector')
varargout{6} = handles.maindata.TDdata.variable_vector;
else 
    varargout{6}=[];
end

% --- Executes on slider movement.
function slider_pc_step_Callback(hObject, eventdata, handles)
% hObject    handle to slider_pc_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
set(hObject,'Min',1)
set(hObject,'Max',SizeTimeDomainData(1,1));
Max=get(hObject,'Max');
set(hObject,'SliderStep',[1/(Max-1) 1/(Max-1)]);
PCpos=get(hObject,'Value');
handles.PCpos=round(PCpos);
if exist('handles.Tpos','var')==0;
    handles.Tpos=1;
end
if ndims(handles.maindata.TDdata.TimeDomainData)<5
    TimeDomainData=handles.maindata.TDdata.TimeDomainData;
else
    TimeDomainData(:,:,:,:)=handles.maindata.TDdata.TimeDomainData(:,:,:,:,handles.Varpos);
end


plotfunction_Time_Domain_maps(TimeDomainData,...
    handles.maindata.TDdata.tau_vector,...
    handles.maindata.TDdata.T_vector,...
    handles.maindata.TDdata.t_vector,...
    handles.PCpos,...
    handles.Tpos,'','',[],[],[],[],[],...
    handles.ROI_norm.ROIdata);
set(handles.text_pc_step,'Visible','on','String',['PC step ' num2str(round(PCpos))]);

if isfield(handles.ROI_norm,'Normalization_array')==1
    if ismatrix(handles.ROI_norm.Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos)));
    elseif ndims(handles.ROI_norm.Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
    end
end


guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_pc_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_pc_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%maindata=guidata(CMDSworld);
%handles.maindata=maindata;


guidata(hObject,handles);
% --- Executes on slider movement.
function slider_T_step_Callback(hObject, eventdata, handles)
% hObject    handle to slider_T_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
set(hObject,'Min',1)
set(hObject,'Max',SizeTimeDomainData(1,3));
Max=get(hObject,'Max');
set(hObject,'SliderStep',[1/(Max-1) 1/(Max-1)]);

Tpos=get(hObject,'Value');
handles.Tpos=round(Tpos);
if isempty(handles.PCpos)
    handles.PCpos=1;
end
if ndims(handles.maindata.TDdata.TimeDomainData)<5
    TimeDomainData=handles.maindata.TDdata.TimeDomainData;
else
    TimeDomainData=squeeze(handles.maindata.TDdata.TimeDomainData(:,:,:,:,handles.Varpos));
end

plotfunction_Time_Domain_maps(TimeDomainData,...
    handles.maindata.TDdata.tau_vector,...
    handles.maindata.TDdata.T_vector,...
    handles.maindata.TDdata.t_vector,...
    handles.PCpos,...
    handles.Tpos,'','',[],[],[],[],[],...
    handles.ROI_norm.ROIdata)
set(handles.text_time_T,'String',['Time T = ' num2str(handles.maindata.TDdata.T_vector(handles.Tpos)) ' fs']);

if isfield(handles.ROI_norm,'Normalization_array')==1
    if ismatrix(handles.ROI_norm.Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos)));
    elseif ndims(handles.ROI_norm.Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
    end
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_T_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_T_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%maindata=guidata(CMDSworld);
%handles.maindata=maindata;

guidata(hObject,handles);   


% --- Executes on slider movement.
function slider_varible_step_position_Callback(hObject, eventdata, handles)
% hObject    handle to slider_varible_step_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.Varpos=get(hObject,'Value');
handles.TDdata.Varpos(1)=round(handles.Varpos);
handles.Varpos=handles.TDdata.Varpos(1);
set(handles.text_variable_scan,'String',['Variable = ' num2str(handles.maindata.TDdata.variable_vector(handles.TDdata.Varpos(1))) ' [arb.u.]']);
if ndims(handles.maindata.TDdata.TimeDomainData)<5
    TimeDomainData=handles.maindata.TDdata.TimeDomainData;
else
    TimeDomainData(:,:,:,:)=handles.maindata.TDdata.TimeDomainData(:,:,:,:,handles.Varpos);
end
    plotfunction_Time_Domain_maps(TimeDomainData,...
    handles.maindata.TDdata.tau_vector,...
    handles.maindata.TDdata.T_vector,...
    handles.maindata.TDdata.t_vector,...
    handles.PCpos,...
    handles.Tpos,'','',[],[],[],[],[],...
    handles.ROI_norm.ROIdata)

if isfield(handles.ROI_norm,'Normalization_array')==1
    if ismatrix(handles.ROI_norm.Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos)));
    elseif ndims(handles.ROI_norm.Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(handles.ROI_norm.Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_varible_step_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_varible_step_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%maindata=guidata(CMDSworld);

%handles.maindata=maindata;

guidata(hObject,handles);  

% --- Executes during object creation, after setting all properties.
function text_variable_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_variable_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
maindata=guidata(CMDSworld);

handles.maindata=maindata;
NumDim=ndims(handles.maindata.TDdata.TimeDomainData);
if NumDim>=5
    set(hObject,'Visible','on');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_Data_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menu_Data_define_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Data_define_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_define_ROI,'Visible','on');
handles.ROI_norm.ROI_percentage=0.1;
[Normalization_array,ROI_pos_tau,ROI_pos_t]=...
    calculate_predef_ROI_mean(handles.maindata.TDdata.TimeDomainData,...
            handles.maindata.TDdata.tau_vector,handles.maindata.TDdata.t_vector,handles.ROI_norm.ROI_percentage);
handles.ROI_norm.ROIdata.ROI_data_x{1}=ROI_pos_tau;
handles.ROI_norm.ROIdata.ROI_data_y{1}=ROI_pos_t;
handles.ROI_norm.Normalization_array=Normalization_array;
if ismatrix(Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos)));
elseif ndims(Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
end
guidata(hObject,handles);
% --- Executes on button press in button_last10percent.
function button_last10percent_Callback(hObject, eventdata, handles)
% hObject    handle to button_last10percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_last10percent
state=get(hObject,'Value');
if state==1
    handles.ROI_norm.ROI_percentage=0.1;
end
[Normalization_array,ROI_pos_tau,ROI_pos_t]=...
    calculate_predef_ROI_mean(handles.maindata.TDdata.TimeDomainData,...
            handles.maindata.TDdata.tau_vector,handles.maindata.TDdata.t_vector,handles.ROI_norm.ROI_percentage);
handles.ROI_norm.ROIdata.ROI_data_x{1}=ROI_pos_tau;
handles.ROI_norm.ROIdata.ROI_data_y{1}=ROI_pos_t;
handles.ROI_norm.Normalization_array=Normalization_array;
if ismatrix(Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos)));
elseif ndims(Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
end
guidata(hObject,handles);
% --- Executes on button press in button_last15percent.
function button_last15percent_Callback(hObject, eventdata, handles)
% hObject    handle to button_last15percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_last15percent
state=get(hObject,'Value');
if state==1
    handles.ROI_norm.ROI_percentage=0.15;
end
[Normalization_array,ROI_pos_tau,ROI_pos_t]=...
    calculate_predef_ROI_mean(handles.maindata.TDdata.TimeDomainData,...
            handles.maindata.TDdata.tau_vector,handles.maindata.TDdata.t_vector,handles.ROI_norm.ROI_percentage);
handles.ROI_norm.ROIdata.ROI_data_x{1}=ROI_pos_tau;
handles.ROI_norm.ROIdata.ROI_data_y{1}=ROI_pos_t;
handles.ROI_norm.Normalization_array=Normalization_array;
if ismatrix(Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos)));
elseif ndims(Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
end
guidata(hObject,handles);
% --- Executes on button press in button_last20percent.
function button_last20percent_Callback(hObject, eventdata, handles)
% hObject    handle to button_last20percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1
    handles.ROI_norm.ROI_percentage=0.15;
end
[Normalization_array,ROI_pos_tau,ROI_pos_t]=...
    calculate_predef_ROI_mean(handles.maindata.TDdata.TimeDomainData,...
            handles.maindata.TDdata.tau_vector,handles.maindata.TDdata.t_vector,handles.ROI_norm.ROI_percentage);
handles.ROI_norm.ROIdata.ROI_data_x{1}=ROI_pos_tau;
handles.ROI_norm.ROIdata.ROI_data_y{1}=ROI_pos_t;
handles.ROI_norm.Normalization_array=Normalization_array;
if ismatrix(Normalization_array)==1;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos)));
elseif ndims(Normalization_array)==3;
    set(handles.text_current_mean_value,'String',num2str(Normalization_array(handles.PCpos,handles.Tpos,handles.Varpos)));
end
guidata(hObject,handles);
% --- Executes on button press in radio_Normalize_to_ROI_mean.
function radio_Normalize_to_ROI_mean_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Normalize_to_ROI_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Normalize_to_ROI_mean
state=get(hObject,'Value');
TimeDomainData=handles.maindata.TDdata.TimeDomainData;
Normalization_array=handles.ROI_norm.Normalization_array;
if state==1
TimeDomainData=do_TD_normalization(TimeDomainData,Normalization_array);   
elseif state ==0
TimeDomainData=undo_TD_normalization(TimeDomainData,Normalization_array);         
end
handles.maindata.TDdata.TimeDomainData=TimeDomainData;
guidata(hObject,handles);
% --- Executes on button press in push_add_to_current_session.
function push_add_to_current_session_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_to_current_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.new_TimeDomainMap=handles.maindata.TDdata.TimeDomainData;
handles.new_TimaDomainMap_name = inputdlg({'Set dataset name'},'',1,{''});
guidata(hObject,handles);
uiresume(handles.Time_domain_maps);
