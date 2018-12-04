function varargout = pc_weights_calculator_gui(varargin)
% PC_WEIGHTS_CALCULATOR_GUI MATLAB code for pc_weights_calculator_gui.fig
%      PC_WEIGHTS_CALCULATOR_GUI, by itself, creates a new PC_WEIGHTS_CALCULATOR_GUI or raises the existing
%      singleton*.
%
%      H = PC_WEIGHTS_CALCULATOR_GUI returns the handle to a new PC_WEIGHTS_CALCULATOR_GUI or the handle to
%      the existing singleton*.
%
%      PC_WEIGHTS_CALCULATOR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PC_WEIGHTS_CALCULATOR_GUI.M with the given input arguments.
%
%      PC_WEIGHTS_CALCULATOR_GUI('Property','Value',...) creates a new PC_WEIGHTS_CALCULATOR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pc_weights_calculator_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pc_weights_calculator_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pc_weights_calculator_gui

% Last Modified by GUIDE v2.5 26-Jun-2018 14:07:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pc_weights_calculator_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @pc_weights_calculator_gui_OutputFcn, ...
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


% --- Executes just before pc_weights_calculator_gui is made visible.
function pc_weights_calculator_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pc_weights_calculator_gui (see VARARGIN)

% Choose default command line output for pc_weights_calculator_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pc_weights_calculator_gui wait for user response (see UIRESUME)
uiwait(handles.pc_weights_calculator);


% --- Outputs from this function are returned to the command line.
function varargout = pc_weights_calculator_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get default command line output from handles structure
varargout{1} = handles.phases;
varargout{2} = handles.weights;
varargout{3} = handles.name_of_scheme;
varargout{4} = handles.contribution;
varargout{5} = handles.pc_scheme;

delete(handles.pc_weights_calculator);


function edit_contribution_Callback(hObject, eventdata, handles)
% hObject    handle to edit_contribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_contribution as text
%        str2double(get(hObject,'String')) returns contents of edit_contribution as a double
outstring=(get(hObject,'String'));

Cutted_strings = strsplit(outstring,',');
handles.contribution=[];
for ii=1:length(Cutted_strings)
    temp=str2double(Cutted_strings{1,ii});
    handles.contribution(ii)=temp;
end

if ~isempty(handles.pc_scheme) && size(handles.pc_scheme,2)==size(handles.contribution,2)
    [handles.phases,handles.weights]=pc_weights_calculator(handles.contribution,handles.pc_scheme);
    textarrayphases=generate_text_phases(handles.phases);    
    set(handles.text_list_phases,'String',textarrayphases);
    textarrayweights=generate_text_weights(handles.weights,handles.pc_scheme);
    set(handles.text_list_weights,'String',textarrayweights);
    set(handles.text_weights,'String',['Weights [1/' num2str(prod(handles.pc_scheme)) ']']); 
    set(handles.pushbutton_add_to_session,'Visible','on');
    set(handles.pushbutton_save_to_file,'Visible','on');    
 
elseif ~isempty(handles.pc_scheme)
    text='Contribution and scheme must be of same size!';
    set(handles.text_list_phases,'String',text);
    set(handles.text_list_weights,'String','');
end

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_contribution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_contribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.contribution=[];
guidata(hObject,handles);


function edit_pc_scheme_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pc_scheme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pc_scheme as text
%        str2double(get(hObject,'String')) returns contents of edit_pc_scheme as a double
outstring=(get(hObject,'String'));
Cutted_strings = strsplit(outstring,'x');
handles.pc_scheme=[];
for ii=1:length(Cutted_strings)
    temp=str2double(Cutted_strings{1,ii});
    handles.pc_scheme(ii)=temp;
end

if ~isempty(handles.contribution) && size(handles.pc_scheme,2)==size(handles.contribution,2)
    [handles.phases,handles.weights]=pc_weights_calculator(handles.contribution,handles.pc_scheme);
    textarray=generate_text_phases(handles.phases);
    set(handles.text_list_phases,'String',textarray);
    textarrayweights=generate_text_weights(handles.weights,handles.pc_scheme);    
    set(handles.text_list_weights,'String',textarrayweights);
    set(handles.text_weights,'String',['Weights [1/' num2str(prod(handles.pc_scheme)) ']']); 
    set(handles.pushbutton_add_to_session,'Visible','on');
    set(handles.pushbutton_save_to_file,'Visible','on');
elseif ~isempty(handles.pc_scheme)
    text='Contribution and scheme must be of same size!';
    set(handles.text_list_phases,'String',text);
    set(handles.text_list_weights,'String','');
end

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_pc_scheme_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pc_scheme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.pc_scheme=[];
guidata(hObject,handles);


% --- Executes on button press in pushbutton_add_to_session.
function pushbutton_add_to_session_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_to_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename_out=inputdlg({'Set pc scheme name'},'',1,{''});
handles.name_of_scheme=strcat(filename_out, '.mat');
guidata(hObject,handles);
uiresume(handles.pc_weights_calculator);


% --- Executes on button press in pushbutton_save_to_file.
function pushbutton_save_to_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_to_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save_dir=uigetdir('M:\');
filename_out=inputdlg({'Set file name'},'',1,{''});
filename_out=fullfile(save_dir,filename_out);
phases=handles.phases;
weights=handles.weights;
save([filename_out{1} '.mat'],'phases','weights');
guidata(hObject,handles);




% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.contribution=[];
handles.pc_scheme=[];
handles.phases=[];
handles.weights=[];
handles.name_of_scheme=[];
guidata(hObject,handles);
uiresume(handles.pc_weights_calculator);
