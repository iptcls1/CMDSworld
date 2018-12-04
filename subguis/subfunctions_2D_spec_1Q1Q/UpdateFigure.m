function [figuredata]=UpdateFigure(figuredata,axeshandle,Names,newvalues)
for ii=1:length(Names)
   temp=Names{ii};
   newvalue=newvalues{ii};
   figuredata=setfield(figuredata,temp,newvalue);     
end

TimeDomainData=figuredata.TimeDomainData;
tau_vector=figuredata.tau_vector_raw;
T_vector=figuredata.T_vector_raw;
t_vector=figuredata.t_vector_raw;
weights=figuredata.weights;
Units=figuredata.Units;
Domain=figuredata.Domain;
PCpos=figuredata.PCpos;
Tpos=figuredata.Tpos;
operation=figuredata.operation;
normalization=figuredata.normalization;
ZeropaddingImage=figuredata.Zeropadding_Image;
XLabel=figuredata.XLabel;
YLabel=figuredata.XLabel;
Title=figuredata.Title;
Contour=figuredata.Contour;
ZeropaddingContour=figuredata.Zeropadding_Contour;
contour_isovalues=figuredata.contour_isovalues;
name_of_scheme=figuredata.name_of_scheme;
ROIdata=figuredata.ROIdata;
omega_center=figuredata.omega_center;
Varpos=figuredata.Varpos;
gamma=figuredata.gamma;
Double_omega_tau=figuredata.Double_omega_tau;
Double_omega_t=figuredata.Double_omega_t;
Flip_w_tau=figuredata.Flip_w_tau;
Flip_w_t=figuredata.Flip_w_t;
if isfield(figuredata,'variable_vector')
    variable_vector=figuredata.variable_vector;
    [figuredata]=Calculate_and_plot_1Q1Q(figuredata.TimeDomainData_uncutted,Domain,tau_vector,T_vector,t_vector,weights,axeshandle,PCpos,Tpos,...
    operation,normalization,Units,XLabel,YLabel,Title,ZeropaddingImage,Contour,ZeropaddingContour,contour_isovalues,name_of_scheme,...
    ROIdata,omega_center,gamma,Double_omega_tau,Double_omega_t,Flip_w_tau,Flip_w_t,Varpos,variable_vector);
    
else
    [figuredata]=Calculate_and_plot_1Q1Q(TimeDomainData,Domain,tau_vector,T_vector,t_vector,weights,axeshandle,PCpos,Tpos,...
    operation,normalization,Units,XLabel,YLabel,Title,ZeropaddingImage,Contour,ZeropaddingContour,contour_isovalues,name_of_scheme,...
    ROIdata,omega_center,gamma,Double_omega_tau,Double_omega_t,Flip_w_tau,Flip_w_t,Varpos);    
end

