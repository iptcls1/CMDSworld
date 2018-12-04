function varargout = define_rephasing_nonrephasing(varargin)
% DEFINE_REPHASING_NONREPHASING MATLAB code for define_rephasing_nonrephasing.fig
%      DEFINE_REPHASING_NONREPHASING, by itself, creates a new DEFINE_REPHASING_NONREPHASING or raises the existing
%      singleton*.
%
%      H = DEFINE_REPHASING_NONREPHASING returns the handle to a new DEFINE_REPHASING_NONREPHASING or the handle to
%      the existing singleton*.
%
%      DEFINE_REPHASING_NONREPHASING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINE_REPHASING_NONREPHASING.M with the given input arguments.
%
%      DEFINE_REPHASING_NONREPHASING('Property','Value',...) creates a new DEFINE_REPHASING_NONREPHASING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before define_rephasing_nonrephasing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to define_rephasing_nonrephasing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help define_rephasing_nonrephasing

% Last Modified by GUIDE v2.5 22-Jun-2018 09:27:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @define_rephasing_nonrephasing_OpeningFcn, ...
                   'gui_OutputFcn',  @define_rephasing_nonrephasing_OutputFcn, ...
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


% --- Executes just before define_rephasing_nonrephasing is made visible.
function define_rephasing_nonrephasing_OpeningFcn(hObject, eventdata, handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to define_rephasing_nonrephasing (see VARARGIN)

% Choose default command line output for define_rephasing_nonrephasing
handles.output = hObject;
handles.input.all_names_of_scheme=varargin{1};
handles.input.all_weights=varargin{2};

[text] = generarte_list_entries_def_reph_nonreph(handles.input.all_names_of_scheme,handles.input.all_weights);
set(handles.listbox_rephasing_contribution,'String',text);
set(handles.listbox_nonrephasing,'String',text);


% Update handles structure
guidata(hObject, handles);



% UIWAIT makes define_rephasing_nonrephasing wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = define_rephasing_nonrephasing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

weights_out={handles.weights_rephasing handles.weights_nonrephasing};
names_of_schemes_out={handles.name_of_scheme_rephasing handles.name_of_scheme_nonrephasing};
% Get default command line output from handles structure
varargout{1} = weights_out;
varargout{2}=names_of_schemes_out;



delete(handles.figure1);

% --- Executes on selection change in listbox_rephasing_contribution.
function listbox_rephasing_contribution_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rephasing_contribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rephasing_contribution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rephasing_contribution
contents = cellstr(get(hObject,'String'));
rephasing_scheme=contents{get(hObject,'Value')};

logical=0;
loc=0;
ii=1;
while logical==0 
logical=strcmp(contents{ii},rephasing_scheme);
loc=loc+1;
ii=ii+1;
end
handles.name_of_scheme_rephasing=rephasing_scheme;
handles.weights_rephasing=handles.input.all_weights{1,loc};


guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox_rephasing_contribution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rephasing_contribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nonrephasing.
function listbox_nonrephasing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nonrephasing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nonrephasing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nonrephasing
contents = cellstr(get(hObject,'String'));
nonrephasing_scheme=contents{get(hObject,'Value')};

logical=0;
loc=0;
ii=1;
while logical==0 
logical=strcmp(contents{ii},nonrephasing_scheme);
loc=loc+1;
ii=ii+1;
end
handles.name_of_scheme_nonrephasing=nonrephasing_scheme;
handles.weights_nonrephasing=handles.input.all_weights{1,loc};
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox_nonrephasing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nonrephasing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'weights_nonrephasing') && isfield(handles,'weights_rephasing')
guidata(hObject,handles);

uiresume(handles.figure1);
else
guidata(hObject,handles);    
end


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.name_of_scheme_rephasing=[];
handles.name_of_scheme_nonrephasing=[];
handles.weights_rephasing=[];
handles.weights_nonrephasing=[];

guidata(hObject,handles);
uiresume(handles.figure1);

% --- Executes during object creation, after setting all properties.
function pushbutton_ok_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
guidata(hObject,handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject,'waitstatus'),'waiting')
    handles.name_of_scheme_rephasing;
    handles.name_of_scheme_nonrephasing;
    handles.weights_rephasing=[];
    handles.weights_nonrephasing=[];

    guidata(hObject,handles);
    uiresume(hObject);
else
delete(hObject);
end
