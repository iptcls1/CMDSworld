function varargout = Time_Domain_Calculations(varargin)
% TIME_DOMAIN_CALCULATIONS MATLAB code for Time_Domain_Calculations.fig
%      TIME_DOMAIN_CALCULATIONS, by itself, creates a new TIME_DOMAIN_CALCULATIONS or raises the existing
%      singleton*.
%
%      H = TIME_DOMAIN_CALCULATIONS returns the handle to a new TIME_DOMAIN_CALCULATIONS or the handle to
%      the existing singleton*.
%
%      TIME_DOMAIN_CALCULATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIME_DOMAIN_CALCULATIONS.M with the given input arguments.
%
%      TIME_DOMAIN_CALCULATIONS('Property','Value',...) creates a new TIME_DOMAIN_CALCULATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Time_Domain_Calculations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Time_Domain_Calculations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Time_Domain_Calculations

% Last Modified by GUIDE v2.5 13-Aug-2018 18:00:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Time_Domain_Calculations_OpeningFcn, ...
                   'gui_OutputFcn',  @Time_Domain_Calculations_OutputFcn, ...
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


% --- Executes just before Time_Domain_Calculations is made visible.
function Time_Domain_Calculations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Time_Domain_Calculations (see VARARGIN)

% Choose default command line output for Time_Domain_Calculations
% input variables
handles.output = hObject;
handles.TDdata.TimeDomainData=varargin{1};
handles.TDdata.tau_vector=varargin{2};
handles.TDdata.T_vector=varargin{3};
handles.TDdata.t_vector=varargin{4};
handles.TDdata.variable_vector=varargin{5};
handles.TDdata.name_of_TD_dataset=varargin{6};
% set list entries time domain datasets
text=define_list_entries_time_domain_datasets(handles.TDdata.name_of_TD_dataset);
set(handles.list_input_time_domain_map1,'String',text);
set(handles.list_input_time_domain_map1,'Value',1);
set(handles.list_input_time_domain_map2,'String',text);
set(handles.list_input_time_domain_map2,'Value',1);
% set list entries operations
text=define_operations_list(2);
set(handles.list_time_domain_operation,'String',text);
set(handles.list_time_domain_operation,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Time_Domain_Calculations wait for user response (see UIRESUME)
uiwait(handles.fig_time_domain_calculations);


% --- Outputs from this function are returned to the command line.
function varargout = Time_Domain_Calculations_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.TDdata.OutputTimeData;
varargout{2}=handles.TDdata.tau_vector{1};
varargout{3}=handles.TDdata.T_vector{1};
varargout{4}=handles.TDdata.t_vector{1};
varargout{5}=handles.TDdata.variable_vector{1};
varargout{6}=handles.TDdata.Output_TimaDomainMap_name;

delete(handles.fig_time_domain_calculations);




% --- Executes on selection change in list_input_time_domain_map1.
function list_input_time_domain_map1_Callback(hObject, eventdata, handles)
% hObject    handle to list_input_time_domain_map1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_input_time_domain_map1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_input_time_domain_map1


% --- Executes during object creation, after setting all properties.
function list_input_time_domain_map1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_input_time_domain_map1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_input_time_domain_map2.
function list_input_time_domain_map2_Callback(hObject, eventdata, handles)
% hObject    handle to list_input_time_domain_map2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_input_time_domain_map2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_input_time_domain_map2


% --- Executes during object creation, after setting all properties.
function list_input_time_domain_map2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_input_time_domain_map2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_time_domain_operation.
function list_time_domain_operation_Callback(hObject, eventdata, handles)
% hObject    handle to list_time_domain_operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_time_domain_operation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_time_domain_operation


% --- Executes during object creation, after setting all properties.
function list_time_domain_operation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_time_domain_operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_calculate.
function push_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to push_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num1=get(handles.list_input_time_domain_map1,'Value');
TimeData1.TimeDomainMap=handles.TDdata.TimeDomainData{num1};
TimeData1.tau_vector=handles.TDdata.tau_vector{num1};
TimeData1.T_vector=handles.TDdata.T_vector{num1};
TimeData1.t_vector=handles.TDdata.t_vector{num1};
TimeData1.variable_vector=handles.TDdata.variable_vector{num1};
num2=get(handles.list_input_time_domain_map2,'Value');
TimeData2.TimeDomainMap=handles.TDdata.TimeDomainData{num2};
TimeData2.tau_vector=handles.TDdata.tau_vector{num1};
TimeData2.T_vector=handles.TDdata.T_vector{num1};
TimeData2.t_vector=handles.TDdata.t_vector{num1};
TimeData2.variable_vector=handles.TDdata.variable_vector{num1};
operation=get(handles.list_time_domain_operation,'String');
numop=get(handles.list_time_domain_operation,'Value');
operation=operation(numop,:);
%here the calculation takes place
OutputTimeData=Time_domain_calculator(TimeData1.TimeDomainMap,TimeData2.TimeDomainMap,operation);

%view output
set(handles.text_output,'Visible','on');
text=['Output operation ' operation ' : ' num2str(size(OutputTimeData))];
set(handles.text_output,'String',text);

set(handles.push_save_to_current_session,'Visible','on');
handles.TDdata.OutputTimeData=OutputTimeData;
guidata(hObject,handles);

% --- Executes on button press in push_cancel.
function push_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to push_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_save_to_current_session.
function push_save_to_current_session_Callback(hObject, eventdata, handles)
% hObject    handle to push_save_to_current_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TDdata.Output_TimaDomainMap_name = inputdlg({'Set dataset name'},'',1,{''});
guidata(hObject,handles);
uiresume(handles.fig_time_domain_calculations);
