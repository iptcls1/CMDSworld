function varargout = define_input_structure(varargin)
% DEFINE_INPUT_STRUCTURE MATLAB code for define_input_structure.fig
%      DEFINE_INPUT_STRUCTURE, by itself, creates a new DEFINE_INPUT_STRUCTURE or raises the existing
%      singleton*.
%
%      H = DEFINE_INPUT_STRUCTURE returns the handle to a new DEFINE_INPUT_STRUCTURE or the handle to
%      the existing singleton*.
%
%      DEFINE_INPUT_STRUCTURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINE_INPUT_STRUCTURE.M with the given input arguments.
%
%      DEFINE_INPUT_STRUCTURE('Property','Value',...) creates a new DEFINE_INPUT_STRUCTURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before define_input_structure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to define_input_structure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help define_input_structure

% Last Modified by GUIDE v2.5 26-Jun-2018 09:17:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @define_input_structure_OpeningFcn, ...
                   'gui_OutputFcn',  @define_input_structure_OutputFcn, ...
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


% --- Executes just before define_input_structure is made visible.
function define_input_structure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to define_input_structure (see VARARGIN)

% Choose default command line output for define_input_structure
handles.output = 'D(pc,tau,T,t)';


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes define_input_structure wait for user response (see UIRESUME)
 uiwait(handles.DefInput);


% --- Outputs from this function are returned to the command line.
function varargout = define_input_structure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.DefInput);


% --- Executes during object creation, after setting all properties.
function DefInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DefInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
uiresume(handles.DefInput);


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output='Cancel';
guidata(hObject,handles);
uiresume(handles.DefInput);


% --- Executes on button press in radiobutton_option1.
function radiobutton_option1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_option1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton_option1
state=get(hObject,'Value');
if state==1
    handles.output='D(pc,tau,T,t)';
end
guidata(hObject,handles);


% --- Executes on button press in radiobutton_option2.
function radiobutton_option2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_option2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1
    handles.output='D(pc,tau,t,variable)';
end
guidata(hObject,handles);


% --- Executes when user attempts to close DefInput.
function DefInput_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to DefInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject,'waitstatus'),'waiting')
    handles.output='Cancel';
    guidata(hObject,handles);
    uiresume(hObject);
else
delete(hObject);
end
