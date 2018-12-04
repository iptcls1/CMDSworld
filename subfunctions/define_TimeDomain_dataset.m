function varargout = define_TimeDomain_dataset(varargin)
%DEFINE_TIMEDOMAIN_DATASET M-file for define_TimeDomain_dataset.fig
%      DEFINE_TIMEDOMAIN_DATASET, by itself, creates a new DEFINE_TIMEDOMAIN_DATASET or raises the existing
%      singleton*.
%
%      H = DEFINE_TIMEDOMAIN_DATASET returns the handle to a new DEFINE_TIMEDOMAIN_DATASET or the handle to
%      the existing singleton*.
%
%      DEFINE_TIMEDOMAIN_DATASET('Property','Value',...) creates a new DEFINE_TIMEDOMAIN_DATASET using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to define_TimeDomain_dataset_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      DEFINE_TIMEDOMAIN_DATASET('CALLBACK') and DEFINE_TIMEDOMAIN_DATASET('CALLBACK',hObject,...) call the
%      local function named CALLBACK in DEFINE_TIMEDOMAIN_DATASET.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help define_TimeDomain_dataset

% Last Modified by GUIDE v2.5 09-Aug-2018 15:57:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @define_TimeDomain_dataset_OpeningFcn, ...
                   'gui_OutputFcn',  @define_TimeDomain_dataset_OutputFcn, ...
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


% --- Executes just before define_TimeDomain_dataset is made visible.
function define_TimeDomain_dataset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for define_TimeDomain_dataset
handles.output = hObject;
handles.input.all_names_of_time_domain_datasets=varargin{1};

text=define_list_entries_time_domain_datasets(handles.input.all_names_of_time_domain_datasets);
set(handles.list_TD_maps,'String',text);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes define_TimeDomain_dataset wait for user response (see UIRESUME)
 uiwait(handles.define_TD_dataset);


% --- Outputs from this function are returned to the command line.
function varargout = define_TimeDomain_dataset_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name_out={handles.name};
number_out={handles.number};
% Get default command line output from handles structure
varargout{1} = name_out;
varargout{2}= number_out;
delete(handles.define_TD_dataset);



% --- Executes on selection change in list_TD_maps.
function list_TD_maps_Callback(hObject, eventdata, handles)
% hObject    handle to list_TD_maps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));
name=contents{get(hObject,'Value')};

logical=0;
loc=0;
ii=1;
while logical==0 
logical=strcmp(contents{ii},name);
loc=loc+1;
ii=ii+1;
end
handles.name=name;
handles.number=loc;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function list_TD_maps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_TD_maps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_ok.
function push_ok_Callback(hObject, eventdata, handles)
% hObject    handle to push_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'name') && isfield(handles,'number')
guidata(hObject,handles);

uiresume(handles.define_TD_dataset);
else
guidata(hObject,handles);    
end

% --- Executes on button press in push_cancel.
function push_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to push_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.name=[];
handles.number=[];
guidata(hObject,handles);
uiresume(handles.define_TD_dataset);


% --- Executes when user attempts to close define_TD_dataset.
function define_TD_dataset_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to define_TD_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject,'waitstatus'),'waiting')

    guidata(hObject,handles);
    uiresume(hObject);
else
delete(hObject);
end

