function varargout = TwoDspec1Q1Q(varargin)
% TWODSPEC1Q1Q MATLAB code for TwoDspec1Q1Q.fig
%      TWODSPEC1Q1Q, by itself, creates a new TWODSPEC1Q1Q or raises the existing
%      singleton*.
%
%      H = TWODSPEC1Q1Q returns the handle to a new TWODSPEC1Q1Q or the handle to
%      the existing singleton*.
%
%      TWODSPEC1Q1Q('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWODSPEC1Q1Q.M with the given input arguments.
%
%      TWODSPEC1Q1Q('Property','Value',...) creates a new TWODSPEC1Q1Q or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TwoDspec1Q1Q_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TwoDspec1Q1Q_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TwoDspec1Q1Q

% Last Modified by GUIDE v2.5 27-Nov-2018 16:57:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TwoDspec1Q1Q_OpeningFcn, ...
                   'gui_OutputFcn',  @TwoDspec1Q1Q_OutputFcn, ...
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
% --- Executes just before TwoDspec1Q1Q is made visible.
function TwoDspec1Q1Q_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TwoDspec1Q1Q (see VARARGIN)

% Choose default command line output for TwoDspec1Q1Q
handles.output = hObject;
%get data from main gui
maindata=varargin{1};
handles.maindata=maindata;
%check data availability
[checkavail,~]=check_input_data(maindata.TDdata.TimeDomainData,...
    maindata.TDdata.tau_vector,...
    maindata.TDdata.T_vector,...
    maindata.TDdata.t_vector);
if ~isfield(maindata,'pcdata')
    checkavail_phases=false;
    msgbox('No phase-cycling data available.')
elseif isempty(maindata.pcdata)
    checkavail_phases=false;
    msgbox('No phase-cycling data available.')
% elseif length(maindata.pcdata.all_phases{1})~=sizeTD(1)
%     checkavail_phases=false;      
%     msgbox('Phase-cycling data set is of incorrect length.')
else
    checkavail_phases=true;
    
end

if checkavail==false
    error('Data not available!');
elseif checkavail_phases==false
    error('Data not available!');
end
% check wether figure was loaded previously
if ~isfield(maindata,'figuredata')
% default values
handles.misc.number_isovalues=11;
handles.misc.xtitle='auto';
handles.misc.Domain='TimeMap';
handles.misc.operation='absolute';
handles.misc.ytitle='auto';
handles.misc.title='auto';
handles.misc.Normalization='No Normalization';
handles.misc.Units='rad/fs';
handles.misc.ZeropaddingImage=1;
handles.misc.ZeropaddingContour=3;
handles.misc.Contour='on';
handles.ROI.ROI_data_x={};
handles.ROI.ROI_data_y={};
handles.ROI.ROI_mask_data={};
Tpos=1;
PCpos=1;
name_of_scheme='default';
handles.misc.omega_center=0;
handles.misc.gamma=0;
handles.misc.Double_omega_tau='off';
handles.misc.Double_omega_t='off';
handles.misc.Flip_w_tau='off';
handles.misc.Flip_w_t='off';
Varpos=1;
else
handles.misc.number_isovalues=maindata.figuredata.contour_isovalues;
handles.misc.xtitle=maindata.figuredata.XLabel;
handles.misc.Domain=maindata.figuredata.Domain;
handles.misc.operation=maindata.figuredata.operation;
handles.misc.ytitle=maindata.figuredata.YLabel;
handles.misc.title=maindata.figuredata.Title;
handles.misc.Normalization=maindata.figuredata.normalization;
handles.misc.Units=maindata.figuredata.Units;
handles.misc.ZeropaddingImage=maindata.figuredata.Zeropadding_Image;
handles.misc.ZeropaddingContour=maindata.figuredata.Zeropadding_Contour;
handles.misc.Contour=maindata.figuredata.Contour;
    if isfield(maindata.figuredata.ROIdata,'ROI_data_x')
        handles.ROI.ROI_data_x=maindata.figuredata.ROIdata.ROI_data_x;
        handles.ROI.ROI_data_y=maindata.figuredata.ROIdata.ROI_data_y;
        handles.ROI.ROI_mask_data=maindata.figuredata.ROIdata.ROI_mask_data;
            cont={};
            for ii=1:length(handles.ROI.ROI_data_x)
                    x=handles.ROI.ROI_data_x{ii};
                    y=handles.ROI.ROI_data_y{ii};
                    str=['dX=' num2str([min(x), max(x)],' %.2f') ' dY=' num2str([min(y), max(y)],' %.2f')];
                    cont{end+1} = str;
                    set(handles.listbox_ROIs,'String',cont);
                    set(handles.listbox_ROIs,'Value',size(cont,1))
            end
    else
        handles.ROI.ROI_data_x={};
        handles.ROI.ROI_data_y={};
        handles.ROI.ROI_mask_data={};
    end
Tpos=maindata.figuredata.Tpos;
PCpos=maindata.figuredata.PCpos;
name_of_scheme=maindata.figuredata.name_of_scheme;
handles.misc.omega_center=maindata.figuredata.omega_center;
handles.misc.gamma=maindata.figuredata.gamma;
handles.misc.Double_omega_tau=maindata.figuredata.Double_omega_tau;
handles.misc.Double_omega_t=maindata.figuredata.Double_omega_t;
if isfield(maindata.figuredata,'Flip_w_tau') %backward comp.
handles.misc.Flip_w_tau=maindata.figuredata.Flip_w_tau;
handles.misc.Flip_w_t=maindata.figuredata.Flip_w_t;
else
handles.misc.Flip_w_tau='off';
handles.misc.Flip_w_t='off';
end

    if ~isfield(maindata.figuredata,'Varpos')
        Varpos=1;
    else Varpos=maindata.figuredata.Varpos;
    end
end

% Perform Calculate and plot for left figure for the first time (constructor)

[handles.figure_1_data]=Calculate_and_plot_1Q1Q(maindata.TDdata.TimeDomainData,...
    handles.misc.Domain,...
    maindata.TDdata.tau_vector,maindata.TDdata.T_vector,maindata.TDdata.t_vector,...
    maindata.pcdata.all_weights{end},...
    handles.TwoD_1Q1Q_Spectrum1,PCpos,Tpos,handles.misc.operation,...
    handles.misc.Normalization,handles.misc.Units,...
    handles.misc.xtitle,handles.misc.ytitle,'auto',handles.misc.ZeropaddingImage,'on',...
    handles.misc.ZeropaddingContour,handles.misc.number_isovalues,name_of_scheme,handles.ROI,...
    handles.misc.omega_center,handles.misc.gamma,...
    handles.misc.Double_omega_tau,...
    handles.misc.Double_omega_t,...
    handles.misc.Flip_w_tau,...
    handles.misc.Flip_w_t,...
    Varpos);
% Perform Calculate and plot for middle figure for the first time
axes(handles.TwoD_1Q1Q_Spectrum2);
[handles.figure_2_data]=Calculate_and_plot_1Q1Q(maindata.TDdata.TimeDomainData,...
    handles.misc.Domain,...
    maindata.TDdata.tau_vector,maindata.TDdata.T_vector,maindata.TDdata.t_vector,...
    maindata.pcdata.all_weights{end},...
    handles.TwoD_1Q1Q_Spectrum2,PCpos,Tpos,handles.misc.operation,...
    handles.misc.Normalization,handles.misc.Units,...
    handles.misc.xtitle,handles.misc.ytitle,'auto',handles.misc.ZeropaddingImage,'on',...
    handles.misc.ZeropaddingContour,handles.misc.number_isovalues,name_of_scheme,handles.ROI,...
    handles.misc.omega_center,handles.misc.gamma,...
    handles.misc.Double_omega_tau,...
    handles.misc.Double_omega_t,...
    handles.misc.Flip_w_tau,...
    handles.misc.Flip_w_t,...
    Varpos);
% Perform Calculate and plot for right figure for the first time
axes(handles.TwoD_1Q1Q_Spectrum3);
[handles.figure_3_data]=Calculate_and_plot_1Q1Q(maindata.TDdata.TimeDomainData,...
    handles.misc.Domain,...
    maindata.TDdata.tau_vector,maindata.TDdata.T_vector,maindata.TDdata.t_vector,...
    maindata.pcdata.all_weights{end},...
    handles.TwoD_1Q1Q_Spectrum3,PCpos,Tpos,handles.misc.operation,...
    handles.misc.Normalization,handles.misc.Units,...
    handles.misc.xtitle,handles.misc.ytitle,'auto',handles.misc.ZeropaddingImage,'on',...
    handles.misc.ZeropaddingContour,handles.misc.number_isovalues,name_of_scheme,handles.ROI,...
    handles.misc.omega_center,handles.misc.gamma,...
    handles.misc.Double_omega_tau,...
    handles.misc.Double_omega_t,...
    handles.misc.Flip_w_tau,...
    handles.misc.Flip_w_t,...
    Varpos);

  


% set checkbolean for length(T)
if length(handles.maindata.TDdata.T_vector)>1
handles.boleans.checkT=true;
else handles.boleans.checkT=false;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set all slider settings%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
if SizeTimeDomainData(1,3)==1
set(handles.slider_T_scan,'Value',0);
set(handles.slider_T_scan,'Visible','off');
else
set(handles.slider_T_scan,'Min',1)
set(handles.slider_T_scan,'Max',SizeTimeDomainData(1,3));
Max=get(handles.slider_T_scan,'Max');
set(handles.slider_T_scan,'SliderStep',[1/(Max-1) 1/(Max-1)]);
set(handles.slider_T_scan,'Value',1);
end

NumDim=ndims(handles.maindata.TDdata.TimeDomainData);
if NumDim<5
set(handles.slider_variable_scan,'Value',0);
set(handles.slider_variable_scan,'Visible','off');
else
set(handles.slider_variable_scan,'Visible','on'); 
set(handles.text_variable_scan_2,'Visible','on');    
set(handles.slider_variable_scan,'Min',1)
set(handles.slider_variable_scan,'Max',SizeTimeDomainData(1,5));
Max=get(handles.slider_variable_scan,'Max');
set(handles.slider_variable_scan,'SliderStep',[1/(Max-1) 1/(Max-1)]);
set(handles.slider_variable_scan,'Value',1);
end



% Update handles structure
guidata(hObject, handles);
% UIWAIT makes TwoDspec1Q1Q wait for user response (see UIRESUME)
% uiwait(handles.TwoD1Q1Q);
% --- Outputs from this function are returned to the command line.
function varargout = TwoDspec1Q1Q_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on selection change in listbox_contribution_spec_plot1.
function listbox_contribution_spec_plot1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_contribution_spec_plot1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_contribution_spec_plot1
contents = cellstr(get(hObject,'String'));
listentry=contents{get(hObject,'Value')};
if ~isempty(listentry)
[weights1,Domain,operation,name_of_scheme]=get_operation_from_list_entry(listentry,...
    handles.maindata.pcdata.all_weights,...
    handles.maindata.pcdata.all_names_of_scheme);
handles.misc.fig1_name_of_scheme=name_of_scheme;
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'weights' 'Domain' 'operation' 'contour_isovalues' 'name_of_scheme'},{weights1 Domain operation handles.misc.number_isovalues name_of_scheme});
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function listbox_contribution_spec_plot1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%get data from main gui
maindata=guidata(CMDSworld);
handles.maindata=maindata;
text=generate_list_entries(maindata.pcdata.all_weights,maindata.pcdata.all_names_of_scheme);
set(hObject,'String',text);
handles.listbox_contribution_spec_plot1=text;
guidata(hObject,handles);
% --- Executes on selection change in listbox_contribution_spec_plot2.
function listbox_contribution_spec_plot2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_contribution_spec_plot2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_contribution_spec_plot2
contents = cellstr(get(hObject,'String'));
listentry=contents{get(hObject,'Value')};
if ~isempty(listentry)
[weights1,Domain,operation,name_of_scheme]=get_operation_from_list_entry(listentry,...
    handles.maindata.pcdata.all_weights,...
    handles.maindata.pcdata.all_names_of_scheme);
handles.misc.fig2_name_of_scheme=name_of_scheme;
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'weights' 'Domain' 'operation' 'contour_isovalues' 'name_of_scheme'},{weights1 Domain operation handles.misc.number_isovalues name_of_scheme});

end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function listbox_contribution_spec_plot2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
maindata=guidata(CMDSworld);
handles.maindata=maindata;
text=generate_list_entries(maindata.pcdata.all_weights,maindata.pcdata.all_names_of_scheme);
set(hObject,'String',text);
handles.listbox_contribution_spec_plot2=text;
guidata(hObject,handles);
% --- Executes on selection change in listbox_contribution_spec_plot3.
function listbox_contribution_spec_plot3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_contribution_spec_plot3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_contribution_spec_plot3
contents = cellstr(get(hObject,'String'));
listentry=contents{get(hObject,'Value')}; 
if ~isempty(listentry)
[weights1,Domain,operation,name_of_scheme]=get_operation_from_list_entry(listentry,...
    handles.maindata.pcdata.all_weights,...
    handles.maindata.pcdata.all_names_of_scheme);
handles.misc.fig3_name_of_scheme=name_of_scheme;
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'weights' 'Domain' 'operation' 'contour_isovalues' 'name_of_scheme'},{weights1 Domain operation handles.misc.number_isovalues name_of_scheme});

end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function listbox_contribution_spec_plot3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_contribution_spec_plot3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
maindata=guidata(CMDSworld);
handles.maindata=maindata;
text=generate_list_entries(maindata.pcdata.all_weights,maindata.pcdata.all_names_of_scheme);
set(hObject,'String',text);
handles.listbox_contribution_spec_plot3=text;
guidata(hObject,handles);
% --- Executes on button press in radio_normalization.
function radio_normalization_Callback(hObject, eventdata, handles)
% hObject    handle to radio_normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_normalization
if get(hObject,'Value')==0
    handles.misc.normalization='No Normalization';    
else
    handles.misc.normalization='Normalization'; 
end
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function radio_normalization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radio_normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% --------------------------------------------------------------------
function Menu_File_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Menu_Units_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Menu_file_fs_rad_fs_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_fs_rad_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_Units,'Visible','on');
setinvisible({handles.uibuttongroup_Units_eV handles.uipanel_wavenumber handles.uibuttongroup_units_THz});
set(handles.uipanel_rad_fs,'Visible','on');
handles.misc.units='rad/fs';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});



guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_file_fs_THz_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_fs_THz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_Units,'Visible','on');
setinvisible({handles.uipanel_wavenumber handles.uipanel_rad_fs handles.uibuttongroup_Units_eV});
set(handles.uibuttongroup_units_THz,'Visible','on');
set(handles.radiobutton_Units_THz,'Value',1);
handles.misc.units='THz';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});

guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_file_fs_eV_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_fs_eV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%setinvisible({handles.}
set(handles.uipanel_Units,'Visible','on');
setinvisible({handles.uipanel_wavenumber handles.uipanel_rad_fs handles.uibuttongroup_units_THz});
set(handles.uibuttongroup_Units_eV,'Visible','on');
set(handles.radiobutton_units_meV,'Value',1);
set(handles.radiobutton_units_eV,'Value',0);
handles.misc.units='meV';

[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_file_fs_wavenumber_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_fs_wavenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_Units,'Visible','on');
setinvisible({handles.uibuttongroup_Units_eV handles.uipanel_rad_fs handles.uibuttongroup_units_THz});
set(handles.uipanel_wavenumber,'Visible','on');
handles.misc.units='wavenumber';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_file_copy_all_to_figures_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_copy_all_to_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
h1=figure('Name','1Q1Q Figure 1','Position',[680   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum1,h1);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])

h2=figure('Name','1Q1Q Figure 2','Position',[700   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum2,h2);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])

h3=figure('Name','1Q1Q Figure 3','Position',[720   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum3,h3);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
function Menu_file_copy_selected_to_figure_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_copy_selected_to_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
num=handles.misc.active_figure;
if num==1
ax=handles.TwoD_1Q1Q_Spectrum1;
elseif num==2
ax=handles.TwoD_1Q1Q_Spectrum2;
elseif num==3
ax=handles.TwoD_1Q1Q_Spectrum3;
end
h1=figure('Name',['1Q1Q Figure ' num2str(num)],'Position',[680   558   468   340]);
copyobj(ax,h1);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
function Menu_File_Save_All_Figure_and_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_Save_All_Figure_and_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
save_dir=uigetdir('M:\');
filename_out=inputdlg({'Set file name'},'',1,{''});
filename_out=fullfile(save_dir,filename_out);



h1=figure('Name','1Q1Q Figure 1','Position',[680   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum1,h1);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
%data are saved in UserData of figure
h1.UserData=handles.figure_1_data;

h2=figure('Name','1Q1Q Figure 2','Position',[700   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum2,h2);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
%data are saved in UserData of figure
h2.UserData=handles.figure_2_data;

h3=figure('Name','1Q1Q Figure 3','Position',[720   558   468   340]);
copyobj(handles.TwoD_1Q1Q_Spectrum3,h3);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
set(h1,'PaperPositionMode','auto');
set(h2,'PaperPositionMode','auto');
set(h3,'PaperPositionMode','auto');
%data are saved in UserData of figure
h3.UserData=handles.figure_3_data;

figure_data=handles.figure_1_data;
save([filename_out{1} '_1_CMDSfigure'],'figure_data');
figure_data=handles.figure_2_data;
save([filename_out{1} '_2_CMDSfigure'],'figure_data');
figure_data=handles.figure_3_data;
save([filename_out{1} '_3_CMDSfigure'],'figure_data');

% printeps(get(h1,'Number'),[filename_out{1} '_1']);
saveas(h1,[filename_out{1} '_1_CMDSfigure' '.fig']);
saveas(h1,[filename_out{1} '_1_CMDSfigure' '.pdf']);
saveas(h1,[filename_out{1} '_1_CMDSfigure' '.png']);

% printeps(get(h2,'Number'),[filename_out{1} '_2']);
saveas(h2,[filename_out{1} '_2_CMDSfigure' '.fig']);
saveas(h2,[filename_out{1} '_2_CMDSfigure' '.pdf']);
saveas(h2,[filename_out{1} '_2_CMDSfigure' '.png']);

% printeps(get(h3,'Number'),[filename_out{1} '_3']);
saveas(h3,[filename_out{1} '_3_CMDSfigure' '.fig']);
saveas(h3,[filename_out{1} '_3_CMDSfigure' '.pdf']);
saveas(h3,[filename_out{1} '_3_CMDSfigure' '.png']);
function Menu_File_Save_selected_figure_and_data_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_Save_selected_figure_and_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
num=handles.misc.active_figure;
save_dir=uigetdir('M:\');
filename_out=inputdlg({'Set file name'},'',1,{''});
filename_out=fullfile(save_dir,filename_out);


if num==1
ax=handles.TwoD_1Q1Q_Spectrum1;
figure_data=handles.figure_1_data;
elseif num==2
ax=handles.TwoD_1Q1Q_Spectrum2;
figure_data=handles.figure_2_data;
elseif num==3
ax=handles.TwoD_1Q1Q_Spectrum3;
figure_data=handles.figure_3_data;
end
h1=figure('Name',['1Q1Q Figure ' num2str(num)],'Position',[680   558   468   340]);
copyobj(ax,h1);
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
set(h1,'PaperPositionMode','auto');
h1.UserData=figure_data;

save([filename_out{1} num2str(num) '_CMDSfigure'],'figure_data');
% printeps(get(h1,'Number'),[filename_out{1} num2str(num) '_CMDSfigure']);
saveas(h1,[filename_out{1} num2str(num) '_CMDSfigure.fig']);
saveas(h1,[filename_out{1} num2str(num) '_CMDSfigure.pdf']);
saveas(h1,[filename_out{1} num2str(num) '_CMDSfigure.png']);
function Menu_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
out=modal_exit_question;
if strcmp(out,'Yes')
delete(handles.TwoD1Q1Q);
else
end
function Menu_Data_Settings_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Data_Settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Menu_Data_Settings_Normalization_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Data_Settings_Normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_data_settings,'Visible','on');
set(handles.radio_normalization,'Value',1);
handles.misc.normalization='Normalization';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'normalization' 'contour_isovalues'},{handles.misc.normalization handles.misc.number_isovalues});
guidata(hObject,handles);
function edit_zero_padding_image_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zero_padding_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zero_padding_image as text
%        str2double(get(hObject,'String')) returns contents of edit_zero_padding_image as a double
handles.misc.zero_padding_image=str2double(get(hObject,'String'));
%check for integer
if floor(handles.misc.zero_padding_image)==handles.misc.zero_padding_image
    
  [handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Zeropadding_Image'},{handles.misc.zero_padding_image});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Zeropadding_Image'},{handles.misc.zero_padding_image});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Zeropadding_Image'},{handles.misc.zero_padding_image});  
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function edit_zero_padding_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zero_padding_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------------------------------------------------------------------
function Menu_Zero_Padding_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Zero_Padding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_data_settings,'Visible','on');
function edit_zero_padding_contour_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zero_padding_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zero_padding_contour as text
%        str2double(get(hObject,'String')) returns contents of edit_zero_padding_contour as a double
handles.misc.zero_padding_contour=str2double(get(hObject,'String'));
%check for integer
if floor(handles.misc.zero_padding_contour)==handles.misc.zero_padding_contour
    
  [handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Zeropadding_Contour'},{handles.misc.zero_padding_contour});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Zeropadding_Contour'},{handles.misc.zero_padding_contour});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Zeropadding_Contour'},{handles.misc.zero_padding_contour});  
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function edit_zero_padding_contour_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zero_padding_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in radiobutton_units_eV.
function radiobutton_units_eV_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_units_eV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton_units_eV
state=get(hObject,'Value');
if state==1
    handles.misc.units='eV';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


end
% --- Executes on button press in radiobutton_units_eV.
function radiobutton_units_meV_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_units_eV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton_units_eV
state=get(hObject,'Value');
if state==1
    handles.misc.units='meV';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


end
% --- Executes on button press in radiobutton_Units_Hz.
function radiobutton_Units_Hz_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Units_Hz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1
handles.misc.units='Hz';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


end
guidata(hObject,handles);
% --- Executes on button press in radiobutton_units_GHz.
function radiobutton_units_GHz_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_units_GHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_units_GHz
state=get(hObject,'Value');
if state==1
handles.misc.units='GHz';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});

end
guidata(hObject,handles);
% --- Executes on button press in radiobutton_Units_THz.
function radiobutton_Units_THz_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Units_THz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Units_THz
state=get(hObject,'Value');
if state==1
handles.misc.units='THz';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});


end
guidata(hObject,handles);
% --- Executes on button press in radiobutton_Units_PHz.
function radiobutton_Units_PHz_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Units_PHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Units_PHz
state=get(hObject,'Value');
if state==1
handles.misc.units='PHz';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Units'},{handles.misc.units});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Units'},{handles.misc.units});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Units'},{handles.misc.units});

end
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_plot_settings_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_plot_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_plot_settings,'Visible','on');
% --- Executes on button press in radiobutton_plot_contour.
function radiobutton_plot_contour_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plot_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1
    handles.misc.contour='on';
elseif state==0
    handles.misc.contour='off';
end

[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Contour'},{handles.misc.contour});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Contour'},{handles.misc.contour});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Contour'},{handles.misc.contour});
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_Plot_settings_countour_lines_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Plot_settings_countour_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton_plot_contour,'Value',1);
handles.misc.contour='on';
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Contour'},{handles.misc.contour});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Contour'},{handles.misc.contour});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Contour'},{handles.misc.contour});
guidata(hObject,handles);
function edit_number_of_lines_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_of_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_of_lines as text
%        str2double(get(hObject,'String')) returns contents of edit_number_of_lines as a double
num_isovalues=str2double(get(hObject,'String'));
if floor(num_isovalues)==num_isovalues
    handles.misc.number_isovalues=num_isovalues;
    [handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
        handles.TwoD_1Q1Q_Spectrum1,...
        {'contour_isovalues'},{handles.misc.number_isovalues});
    [handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
        handles.TwoD_1Q1Q_Spectrum2,...
        {'contour_isovalues'},{handles.misc.number_isovalues});
    [handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
        handles.TwoD_1Q1Q_Spectrum3,...
        {'contour_isovalues'},{handles.misc.number_isovalues});
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function edit_number_of_lines_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_of_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on slider movement.
function slider_T_scan_Callback(hObject, eventdata, handles)
% hObject    handle to slider_T_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
set(hObject,'Min',1)
set(hObject,'Max',SizeTimeDomainData(1,3));
Max=get(hObject,'Max');
set(hObject,'SliderStep',[1/(Max-1) 1/(Max-1)]);
Tpos=get(hObject,'Value');
handles.TDdata.Tpos=round(Tpos);
round(Tpos)
set(handles.text_T_scan,'String',['T = ' num2str(handles.maindata.TDdata.T_vector(handles.TDdata.Tpos)) ' fs']);
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
        handles.TwoD_1Q1Q_Spectrum1,...
        {'Tpos'},{handles.TDdata.Tpos});
    [handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
        handles.TwoD_1Q1Q_Spectrum2,...
        {'Tpos'},{handles.TDdata.Tpos});
    [handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
        handles.TwoD_1Q1Q_Spectrum3,...
        {'Tpos'},{handles.TDdata.Tpos});
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_T_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_T_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


guidata(hObject,handles);   
% --- Executes on button press in radiobutton_active_figure1.
function radiobutton_active_figure1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_active_figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_active_figure1
state=get(hObject,'Value');
if state==0;
set(hObject,'Value',1);
end
handles.misc.active_figure=1;
set(handles.radiobutton_active_figure3,'Value',0)
set(handles.radiobutton_active_figure2,'Value',0)
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function radiobutton_active_figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_active_figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% --- Executes on button press in radiobutton_active_figure3.
handles.misc.active_figure=1;
guidata(hObject,handles);
function radiobutton_active_figure3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_active_figure3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0;
set(hObject,'Value',1);
end
handles.misc.active_figure=3;
set(handles.radiobutton_active_figure2,'Value',0)
set(handles.radiobutton_active_figure1,'Value',0)
guidata(hObject,handles);
% --- Executes on button press in radiobutton_active_figure2.
function radiobutton_active_figure2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_active_figure2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0;
set(hObject,'Value',1);
end
handles.misc.active_figure=2;
set(handles.radiobutton_active_figure3,'Value',0)
set(handles.radiobutton_active_figure1,'Value',0)
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_Data_Def_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Data_Def_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%add ROI to Roi list in listbox
set(handles.panel_data_settings,'Visible','on');

guidata(hObject,handles);
% --- Executes on button press in pushbutton_add_ROI.
function pushbutton_add_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
type=handles.ROI.type;
if handles.misc.active_figure==1
dat=handles.figure_1_data;
ax=handles.TwoD_1Q1Q_Spectrum1;
elseif handles.misc.active_figure==2
dat=handles.figure_2_data;
ax=handles.TwoD_1Q1Q_Spectrum2;
elseif handles.misc.active_figure==3
dat=handles.figure_3_data;
ax=handles.TwoD_1Q1Q_Spectrum3;
end

[x,y,local_mask]=TwoD_def_ROI(type,ax,dat.Domain,dat.tau_vector_image,...
    dat.t_vector_image,dat.w_tau_image,dat.w_t_image);
str=['dX=' num2str([min(x), max(x)],' %.2f') ' dY=' num2str([min(y), max(y)],' %.2f')];
contents = get(handles.listbox_ROIs,'String');
contents{end+1} = str;
set(handles.listbox_ROIs,'String',contents);
set(handles.listbox_ROIs,'Value',size(contents,1))
%add ROI in ROI data list
if isempty( handles.ROI.ROI_data_x)
    handles.ROI.ROI_data_x{1}=x;
    handles.ROI.ROI_data_y{1}=y;
    %add ROI mask to ROI mask data list+
    handles.ROI.ROI_mask_data{1}=local_mask;
else
    handles.ROI.ROI_data_x{end+1}=x;
    handles.ROI.ROI_data_y{end+1}=y;
    %add ROI mask to ROI mask data list+
    handles.ROI.ROI_mask_data{end+1}=local_mask;
end

[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'ROIdata'},{handles.ROI});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'ROIdata'},{handles.ROI});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'ROIdata'},{handles.ROI});
guidata(hObject,handles);
% --- Executes on selection change in listbox_ROIs.
function listbox_ROIs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ROIs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ROIs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ROIs
contents = cellstr(get(hObject,'String'));
handles.ROI.selected_ROI=contents{get(hObject,'Value')};
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function listbox_ROIs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ROIs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in radiobutton_square.
function radiobutton_square_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0
set(hObject,'Value',1);
end
set(handles.radiobutton_manual_square,'Value',0);
set(handles.radiobutton_Polygon,'Value',0);
set(handles.radiobutton_fixed_size,'Value',0);
handles.ROI.type='2 point input';
guidata(hObject,handles);
% --- Executes on button press in radiobutton_manual_square.
function radiobutton_manual_square_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_manual_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0
set(hObject,'Value',1);
end
set(handles.radiobutton_square,'Value',0);
set(handles.radiobutton_Polygon,'Value',0);
set(handles.radiobutton_fixed_size,'Value',0);
handles.ROI.type='manual input';
guidata(hObject,handles);
% --- Executes on button press in radiobutton_fixed_size.
function radiobutton_fixed_size_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_fixed_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0
set(hObject,'Value',1);
end
set(handles.radiobutton_square,'Value',0);
set(handles.radiobutton_Polygon,'Value',0);
set(handles.radiobutton_manual_square,'Value',0);
handles.ROI.type='fixed size';
guidata(hObject,handles);
% --- Executes on button press in radiobutton_Polygon.
function radiobutton_Polygon_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Polygon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==0
set(hObject,'Value',1);
end
set(handles.radiobutton_square,'Value',0);
set(handles.radiobutton_fixed_size,'Value',0);
set(handles.radiobutton_manual_square,'Value',0);
handles.ROI.type='polygon';
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function radiobutton_square_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.ROI.type='2 point input';
guidata(hObject,handles);
% --- Executes on button press in pushbutton_delete_ROI.
function pushbutton_delete_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Current ROI list content
contents = get(handles.listbox_ROIs,'String');
%Current selected ROI is handles.selected_ROI, if no ROI has been selected,
%use first item
   truefalse=isfield(handles.ROI,'selected_ROI');
  if truefalse==0
      
      warndlg('You have to create a ROI first or click on the ROI you want to delete.');
      error('You have to create a ROI first or click on the ROI you want to delete.');
  end
%Nasty fix that deleting the last entry will not destroy everything...  
row=get(handles.listbox_ROIs,'Value');
  
contents(row,:)=[];
%Write new ROI_list
set(handles.listbox_ROIs,'String',contents);
if size(handles.listbox_ROIs,1)>0
    set(handles.listbox_ROIs,'Value',size(handles.listbox_ROIs,1));
end    


%update ROI_data_x and ROI_data_y
handles.ROI.ROI_data_x(row)=[];
handles.ROI.ROI_data_y(row)=[];
%update mask cell array
handles.ROI.ROI_mask_data(row)=[];

[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'ROIdata'},{handles.ROI});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'ROIdata'},{handles.ROI});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'ROIdata'},{handles.ROI});

guidata(hObject,handles);
% --- Executes on button press in pushbutton_calc_T_scan.
function pushbutton_calc_T_scan_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calc_T_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.misc.active_figure==1
dat=handles.figure_1_data;
ax=handles.TwoD_1Q1Q_Spectrum1;
elseif handles.misc.active_figure==2
dat=handles.figure_2_data;
ax=handles.TwoD_1Q1Q_Spectrum2;
elseif handles.misc.active_figure==3
dat=handles.figure_3_data;
ax=handles.TwoD_1Q1Q_Spectrum3;
end

T_scan_evaluation(dat);
guidata(hObject,handles);
% --------------------------------------------------------------------
function Menu_Data_Gamma_value_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Data_Gamma_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_data_settings,'Visible','on');
guidata(hObject,handles);
function edit_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gamma as text
%        str2double(get(hObject,'String')) returns contents of edit_gamma as a double
handles.misc.gamma=str2double(get(hObject,'String'));
if handles.misc.gamma<0 || 1<handles.misc.gamma
    msgbox('Gamma must be between 0 and 1!');
    handles.misc.gamma=0;
end
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'gamma'},{handles.misc.gamma});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'gamma'},{handles.misc.gamma});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'gamma'},{handles.misc.gamma});


guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function edit_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_lambda0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lambda0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lambda0 as text
%        str2double(get(hObject,'String')) returns contents of edit_lambda0 as a double
handles.misc.centerwavelength= str2double(get(hObject,'String'));
handles.misc.center_w=2*pi*299792458/(handles.misc.centerwavelength*1e-9)*1e-15;

[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'omega_center'},{handles.misc.center_w});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'omega_center'},{handles.misc.center_w});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'omega_center'},{handles.misc.center_w});

guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function edit_lambda0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lambda0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on slider movement.
function slider_variable_scan_Callback(hObject, eventdata, handles)
% hObject    handle to slider_variable_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%SizeTimeDomainData=size(handles.maindata.TDdata.TimeDomainData);
% set(hObject,'Min',1)
% set(hObject,'Max',SizeTimeDomainData(1,3));
% Max=get(hObject,'Max');
% set(hObject,'SliderStep',[1/(Max-1) 1/(Max-1)]);
Varpos=get(hObject,'Value');
handles.TDdata.Varpos(1)=round(Varpos);
set(handles.text_variable_scan_2,'String',['Variable = ' num2str(handles.maindata.TDdata.variable_vector(handles.TDdata.Varpos(1))) ' [arb.u.]']);
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
        handles.TwoD_1Q1Q_Spectrum1,...
        {'TimeDomainData','Varpos'},{handles.maindata.TDdata.TimeDomainData, handles.TDdata.Varpos(1)});
    [handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
        handles.TwoD_1Q1Q_Spectrum2,...
        {'TimeDomainData','Varpos'},{handles.maindata.TDdata.TimeDomainData,handles.TDdata.Varpos(1)});
    [handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
        handles.TwoD_1Q1Q_Spectrum3,...
        {'TimeDomainData','Varpos'},{handles.maindata.TDdata.TimeDomainData,handles.TDdata.Varpos});
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_variable_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_variable_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


guidata(hObject,handles);  
% --- Executes during object creation, after setting all properties.
function text_variable_scan_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_variable_scan_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
maindata=guidata(CMDSworld);

handles.maindata=maindata;
NumDim=ndims(handles.maindata.TDdata.TimeDomainData);
if NumDim>=5
    set(hObject,'Visible','on');
    set(hObject,'String',['Variable = ' num2str(maindata.TDdata.variable_vector(1)) ' [arb.u.]']);
end
% --- Executes on button press in radiobutton_Double_omega_tau.
function radiobutton_Double_omega_tau_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Double_omega_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1;
    Double_omega_tau='on';
elseif state==0
    Double_omega_tau='off';  
end

    [handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
        handles.TwoD_1Q1Q_Spectrum1,...
        {'Double_omega_tau'},{Double_omega_tau});
    [handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
        handles.TwoD_1Q1Q_Spectrum2,...
        {'Double_omega_tau'},{Double_omega_tau});
    [handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
        handles.TwoD_1Q1Q_Spectrum3,...
        {'Double_omega_tau'},{Double_omega_tau});
guidata(hObject,handles);
% --- Executes on button press in radiobutton_Double_omega_t.
function radiobutton_Double_omega_t_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Double_omega_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(hObject,'Value');
if state==1;
    Double_omega_t='on';
elseif state==0
    Double_omega_t='off';  
end

    [handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
        handles.TwoD_1Q1Q_Spectrum1,...
        {'Double_omega_t'},{Double_omega_t});
    [handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
        handles.TwoD_1Q1Q_Spectrum2,...
        {'Double_omega_t'},{Double_omega_t});
    [handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
        handles.TwoD_1Q1Q_Spectrum3,...
        {'Double_omega_t'},{Double_omega_t});
guidata(hObject,handles);
% --- Executes on button press in radiobutton_spectrum_flip_w_tau.
function radiobutton_spectrum_flip_w_tau_Callback(hObject, eventdata, handles)
state= get(hObject,'Value'); % returns toggle state of radiobutton_spectrum_flip_w_tau
if state==1
   handles.misc.Flip_w_tau='on';
elseif state==0
   handles.misc.Flip_w_tau='off';
end
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Flip_w_tau'},{handles.misc.Flip_w_tau});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Flip_w_tau'},{handles.misc.Flip_w_tau});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Flip_w_tau'},{handles.misc.Flip_w_tau});
guidata(hObject,handles);



% --- Executes on button press in radiobutton_spectrum_flip_w_t.
function radiobutton_spectrum_flip_w_t_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_spectrum_flip_w_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state= get(hObject,'Value'); % returns toggle state of radiobutton_spectrum_flip_w_tau
if state==1
   handles.misc.Flip_w_t='on';
elseif state==0
   handles.misc.Flip_w_t='off';
end
[handles.figure_1_data]=UpdateFigure(handles.figure_1_data,...
    handles.TwoD_1Q1Q_Spectrum1,...
    {'Flip_w_t'},{handles.misc.Flip_w_t});
[handles.figure_2_data]=UpdateFigure(handles.figure_2_data,...
    handles.TwoD_1Q1Q_Spectrum2,...
    {'Flip_w_t'},{handles.misc.Flip_w_t});
[handles.figure_3_data]=UpdateFigure(handles.figure_3_data,...
    handles.TwoD_1Q1Q_Spectrum3,...
    {'Flip_w_t'},{handles.misc.Flip_w_t});
guidata(hObject,handles);


% --------------------------------------------------------------------
function Menu_Plot_settings_flip_axes_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Plot_settings_flip_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_plot_settings,'Visible','on');



