function varargout = T_scan_evaluation(varargin)
% T_SCAN_EVALUATION MATLAB code for T_scan_evaluation.fig
%      T_SCAN_EVALUATION, by itself, creates a new T_SCAN_EVALUATION or raises the existing
%      singleton*.
%
%      H = T_SCAN_EVALUATION returns the handle to a new T_SCAN_EVALUATION or the handle to
%      the existing singleton*.
%
%      T_SCAN_EVALUATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in T_SCAN_EVALUATION.M with the given input arguments.
%
%      T_SCAN_EVALUATION('Property','Value',...) creates a new T_SCAN_EVALUATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before T_scan_evaluation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to T_scan_evaluation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help T_scan_evaluation

% Last Modified by GUIDE v2.5 25-Jun-2018 11:33:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @T_scan_evaluation_OpeningFcn, ...
                   'gui_OutputFcn',  @T_scan_evaluation_OutputFcn, ...
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
% --- Executes just before T_scan_evaluation is made visible.
function T_scan_evaluation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to T_scan_evaluation (see VARARGIN)

% Choose default command line output for T_scan_evaluation
handles.output = hObject;
handles.figuredata=varargin{1};
ROIdata=handles.figuredata.ROIdata;
Domain=handles.figuredata.Domain;
if isempty(ROIdata.ROI_data_x)
    msgbox('No ROI data available. Define a ROI first.');
    error('No ROI data available. Define a ROI first.');
    delete(hObject);
    
end


switch Domain
    case 'TimeMap'
        InputData=handles.figuredata.PC_TimeData_Image;
        axes(handles.axes_TwoD_Spectrum);
        plotfunction_Time_Domain_maps(handles.figuredata.PC_TimeData_Image,...
            handles.figuredata.tau_vector_image,...
            handles.figuredata.T_vector_raw,...
            handles.figuredata.t_vector_image,...
            handles.figuredata.PCpos,...
            handles.figuredata.Tpos,...
            handles.figuredata.operation,...
            handles.figuredata.Contour,...
            handles.figuredata.PC_TimeData_Contour,...
            handles.figuredata.tau_vector_contour,...
            handles.figuredata.T_vector_raw,...
            handles.figuredata.t_vector_contour,...
            handles.figuredata.contour_isovalues,...
            handles.figuredata.ROIdata);
        
        
    case '2DSpectrum'
        InputData=handles.figuredata.PC_SpecData_Image;
        axes(handles.axes_TwoD_Spectrum);
        plotfunction_2D_spec_1Q1Q(handles.figuredata.PC_SpecData_Image,...
            handles.figuredata.w_tau_image,...
            handles.figuredata.T_vector_raw,...
            handles.figuredata.w_t_image,...
            handles.figuredata.Tpos,...
            handles.figuredata.operation,...
            handles.figuredata.Contour,...
            handles.figuredata.PC_SpecData_Contour,...
            handles.figuredata.w_tau_contour,...
            handles.figuredata.T_vector_raw,...
            handles.figuredata.w_t_contour,...
            handles.figuredata.contour_isovalues,...
            handles.figuredata.Units,...
            handles.figuredata.ROIdata);
        
        
end
T_vector=handles.figuredata.T_vector_raw;
handles.figuredata.T_scan_data=calculate_T_scan_1Q1Q(InputData,ROIdata,T_vector);
plot_T_scan(handles.axes_T_scan_data,T_vector,handles.figuredata.T_scan_data);



% Update handles structure
guidata(hObject, handles);
% UIWAIT makes T_scan_evaluation wait for user response (see UIRESUME)
% uiwait(handles.T_scan_evaluation);
% --- Outputs from this function are returned to the command line.
function varargout = T_scan_evaluation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --------------------------------------------------------------------
function Menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Menu_File_copy_to_figures_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_copy_to_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1=figure('Name','ROI Positions','Position',[220   600   468   340]);
copyobj(handles.axes_TwoD_Spectrum,h1);
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])

h2=figure('Name','Time T Scan','Position',[700  558   692   420]);
copyobj(handles.axes_T_scan_data,h2);
set(gca,'ActivePositionProperty','outerposition')
set(gca,'Units','normalized')
set(gca,'OuterPosition',[0 0 1 1])
% --------------------------------------------------------------------
function Menu_File_save_fig_and_data_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File_save_fig_and_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save_dir=uigetdir('M:\');
filename_out=inputdlg({'Set file name'},'',1,{''});
filename_out=fullfile(save_dir,filename_out);

% h1=figure('Name','Time T Scan','Position',[406   374   991   420]);
% 
% copyobj(handles.axes_TwoD_Spectrum,h1);
% % set(gca,'ActivePositionProperty','outerposition')
% % set(gca,'Units','normalized')
% % set(gca,'OuterPosition',[0 0 1 1]);
% 
% copyobj(handles.axes_T_scan_data,h1);
% % set(gca,'ActivePositionProperty','outerposition')
% % set(gca,'Units','normalized')
% % set(gca,'OuterPosition',[0 0 1 1])
% %data are saved in UserData of figure
h1=handles.T_scan_evaluation;
h1.UserData=handles.figuredata;
figuredata=handles.figuredata;
save([filename_out{1} '_T_scan'],'figuredata');
%printeps(get(h1,'Number'),[filename_out{1} '_T_scan']);
set(h1,'PaperPositionMode','auto');
saveas(h1,[filename_out{1} '_T_scan' '.fig']);
saveas(h1,[filename_out{1} '_T_scan' '.pdf']);
saveas(h1,[filename_out{1} '_T_scan' '.png']); 
% --------------------------------------------------------------------
function Menu_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
out=modal_exit_question;
if strcmp(out,'Yes')
delete(handles.T_scan_evaluation);
else
end
