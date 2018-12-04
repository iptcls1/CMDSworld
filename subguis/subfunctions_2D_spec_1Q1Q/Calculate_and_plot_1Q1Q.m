function [figuredata]=Calculate_and_plot_1Q1Q(TimeDomainData,Domain,tau_vector,T_vector,t_vector,weights,axeshandle,PCpos,Tpos,...
    operation,normalization,Units,XLabel,YLabel,Title,ZeropaddingImage,Contour,ZeropaddingContour,contour_isovalues,name_of_scheme,ROIdata,...
    omega_center,gamma,Double_omega_tau,Double_omega_t,Flip_w_tau,Flip_w_t,Varpos,var_vector)
if ~iscell(weights)==1
    temp{1}=weights;
    weights=temp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Calculate omega axes and time axes %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate omega axes and time axes for image 
[w_tau_image, tau_vector_image]=generate_omega_vector(tau_vector,ZeropaddingImage,omega_center,gamma,Double_omega_tau);
[w_t_image, t_vector_image]=generate_omega_vector(t_vector,ZeropaddingImage, omega_center,gamma,Double_omega_t);
[w_tau_image]=calc_omega_in_units(w_tau_image,Units);
[w_t_image]=calc_omega_in_units(w_t_image,Units);
% calculate omega axes and time axes for contour
[w_tau_contour, tau_vector_contour]=generate_omega_vector(tau_vector,ZeropaddingContour,omega_center,gamma,Double_omega_tau);
[w_t_contour, t_vector_contour]=generate_omega_vector(t_vector,ZeropaddingContour,omega_center,gamma,Double_omega_t);
[w_tau_contour]=calc_omega_in_units(w_tau_contour,Units);
[w_t_contour]=calc_omega_in_units(w_t_contour,Units);
% calculate raw omega axes and time axes without zero padding 
[w_tau_raw, ~]=generate_omega_vector(tau_vector,1, omega_center,gamma,Double_omega_tau);
[w_t_raw, ~]=generate_omega_vector(t_vector,1, omega_center,gamma,Double_omega_t);
[w_tau_raw]=calc_omega_in_units(w_tau_raw,Units);
[w_t_raw]=calc_omega_in_units(w_t_raw,Units);

% Cut Data at Varpos if Number of Dimensions is 5 or more
if length(Varpos)==1 && ndims(TimeDomainData)==5
    TimeDomainData_uncutted=TimeDomainData;
    TimeDomainData_temp=TimeDomainData(:,:,:,:,Varpos);
    TimeDomainData=TimeDomainData_temp;
% elseif length(Varpos)==1 && ndims(TimeDomainData)==4
%         TimeDomainData_temp=TimeDomainData(:,:,:,Varpos);
%     TimeDomainData=TimeDomainData_temp;
elseif length(Varpos)==2&& ndims(TimeDomainData)==6
    TimeDomainData_uncutted=TimeDomainData;
    TimeDomainData_temp=TimeDomainData(:,:,:,:,Varpos);
    TimeDomainData=TimeDomainData_temp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Perform phase cycling and 2D FFT %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% perform phase cycling without zero padding and with Jakub method (raw data) 
PC_time_data_raw=perform_phase_cycling(TimeDomainData,...
    weights{1},1);
% calculate 2D Fourier transform (raw data)
SpecDomainData_raw=calculate_2D_fouriertrafo(PC_time_data_raw,...
    tau_vector,...
    T_vector,...
    t_vector);
% perform phase cycling with zero padding 'ZeropaddingImage' and Jakub method
PC_time_data_Image=perform_phase_cycling(TimeDomainData,...
    weights{1},ZeropaddingImage);
% calculate 2D Fourier transform
SpecDomainData_image=calculate_2D_fouriertrafo(PC_time_data_Image,...
    tau_vector_image,...
    T_vector,...
    t_vector_image);

% perform phase cycling with zero padding 'ZeropaddingContour' and Jakub method
PC_time_data_contour=perform_phase_cycling(TimeDomainData,...
    weights{1},ZeropaddingContour);
% calculate 2D Fourier transform
SpecDomainData_contour=calculate_2D_fouriertrafo(PC_time_data_Image,...
    tau_vector_contour,...
    T_vector,...
    t_vector_contour);

switch operation
    case 'absolute'
        PC_time_data_Image=abs(PC_time_data_Image);
        PC_time_data_contour=abs(PC_time_data_contour);
        SpecDomainData_image=abs(SpecDomainData_image);
        SpecDomainData_contour=abs(SpecDomainData_contour);
    case 'realpart'
        PC_time_data_Image=real(PC_time_data_Image);
        PC_time_data_contour=real(PC_time_data_contour);
        SpecDomainData_image=real(SpecDomainData_image);
        SpecDomainData_contour=real(SpecDomainData_contour);
    case 'imagpart'
        PC_time_data_Image=imag(PC_time_data_Image);
        PC_time_data_contour=imag(PC_time_data_contour);
        SpecDomainData_image=imag(SpecDomainData_image);
        SpecDomainData_contour=imag(SpecDomainData_contour);
    case 'absorptive'
        [PC_time_data_raw_rephasing,PC_time_data_raw_nonrephasing]=...
            calculate_absorptive_time_data(TimeDomainData,weights,1);
        [PC_time_data_Image_rephasing,PC_time_data_Image_nonrephasing]=...
            calculate_absorptive_time_data(TimeDomainData,weights,ZeropaddingImage);
        [PC_time_data_Contour_rephasing,PC_time_data_Contour_nonrephasing]=...
            calculate_absorptive_time_data(TimeDomainData,weights,ZeropaddingContour);
        
        [SpecDomainData_absorptive_raw]=calculate_absorptive_2D_Spec(PC_time_data_raw_rephasing,PC_time_data_raw_nonrephasing,...
                tau_vector,T_vector,t_vector);
        [SpecDomainData_absorptive_image]=calculate_absorptive_2D_Spec(PC_time_data_Image_rephasing,PC_time_data_Image_nonrephasing,...
                tau_vector_image,T_vector,t_vector_image);
        [SpecDomainData_absorptive_contour]=calculate_absorptive_2D_Spec(PC_time_data_Contour_rephasing,PC_time_data_Contour_nonrephasing,...
                tau_vector_contour,T_vector,t_vector_contour);   

        SpecDomainData_raw=SpecDomainData_absorptive_raw;
        SpecDomainData_image=SpecDomainData_absorptive_image;
        SpecDomainData_contour=SpecDomainData_absorptive_contour;
end

switch normalization
    case 'No Normalization'
        %SpecDomainData=SpecDomainData
    case 'Normalization'
        PC_time_data_Image=PC_time_data_Image/max(max(max(abs(PC_time_data_Image))));
        PC_time_data_contour=PC_time_data_contour/max(max(max(abs(PC_time_data_contour))));
        
        SpecDomainData_image=SpecDomainData_image/max(max(max(abs(SpecDomainData_image))));
        SpecDomainData_contour=SpecDomainData_contour/max(max(max(abs(SpecDomainData_contour))));
end

switch Flip_w_tau
    case 'off'
        %do nothing
    case 'on'
        SpecDomainData_raw=flip(SpecDomainData_raw,1);
        SpecDomainData_image=flip(SpecDomainData_image,1);
        SpecDomainData_contour=flip(SpecDomainData_contour,1);
        % flip and shift if length of omega vector is even
            w_tau_raw=-flip(w_tau_raw);
            w_tau_contour=-flip(w_tau_contour);
            w_tau_image=-flip(w_tau_image);
end

switch Flip_w_t
    case 'off'
        %do nothing
    case 'on'
        SpecDomainData_raw=flip(SpecDomainData_raw,3);
        SpecDomainData_image=flip(SpecDomainData_image,3);
        SpecDomainData_contour=flip(SpecDomainData_contour,3);
        % flip and shift if length of omega vector is even
            w_t_raw=-flip(w_t_raw);
            w_t_contour=-flip(w_t_contour);
            w_t_image=-flip(w_t_image);
end

switch Domain
    case 'TimeMap'                    
                % if necessary calculate isovalues
        if length(contour_isovalues)==1 && floor(contour_isovalues)==contour_isovalues
            isuneven=mod(contour_isovalues,2);
            contour_isovalues=calculate_isovalues(PC_time_data_contour,contour_isovalues,operation,normalization);  
            %if number of contour lines is uneven, set middle contour line
            %exactly to zero
            if isuneven==1
                contour_isovalues(ceil(end/2))=0;
            end
         
        end   
        axes(axeshandle);
        cla(gca);                  
        plotfunction_Time_Domain_maps(PC_time_data_Image,...
            tau_vector_image,...
            T_vector,...
            t_vector_image,...
            PCpos,...
            Tpos,...
            operation,...
            Contour,...
            PC_time_data_contour,...
            tau_vector_contour,...
            T_vector,...
            t_vector_contour,...
            contour_isovalues,...
            ROIdata);       
    case '2DSpectrum'  
                % if necessary calculate isovalues
        if length(contour_isovalues)==1 && floor(contour_isovalues)==contour_isovalues
            isuneven=mod(contour_isovalues,2);
            contour_isovalues=calculate_isovalues(SpecDomainData_contour,contour_isovalues,operation,normalization);  
            if isuneven==1
                contour_isovalues(ceil(end/2))=0;
            end
        end
                
        axes(axeshandle);
        cla(gca);
        % call plotfunction
        plotfunction_2D_spec_1Q1Q(SpecDomainData_image,...
            w_tau_image,...
            T_vector,...
            w_t_image,...
            Tpos,...
            operation,...
            Contour,...
            SpecDomainData_contour,...
            w_tau_contour,...
            T_vector,...
            w_t_contour,...
            contour_isovalues,...
            Units,...
            ROIdata);
end
%summary of figure data
figuredata.TimeDomainData=TimeDomainData;
figuredata.tau_vector_raw=tau_vector;
figuredata.T_vector_raw=T_vector;
figuredata.t_vector_raw=t_vector;
figuredata.tau_vector_image=tau_vector_image;
figuredata.T_vector_image=T_vector;
figuredata.t_vector_image=t_vector_image;
figuredata.tau_vector_contour=tau_vector_contour;
figuredata.T_vector_contour=T_vector;
figuredata.t_vector_contour=t_vector_contour;
figuredata.w_tau_raw=w_tau_raw;
figuredata.w_t_raw=w_t_raw;
figuredata.w_tau_image=w_tau_image;
figuredata.w_t_image=w_t_image;
figuredata.w_tau_contour=w_tau_contour;
figuredata.w_t_contour=w_t_contour;
figuredata.weights=weights;
figuredata.PC_TimeData_Image=PC_time_data_Image;
figuredata.PC_SpecData_Image=SpecDomainData_image;
figuredata.PC_TimeData_Contour=PC_time_data_contour;
figuredata.PC_SpecData_Contour=SpecDomainData_contour;
figuredata.PC_TimeData_raw=PC_time_data_raw;
figuredata.PC_SpecData_raw=SpecDomainData_raw;
figuredata.Units=Units;
figuredata.Domain=Domain;
figuredata.PCpos=PCpos;
figuredata.Tpos=Tpos;
figuredata.operation=operation;
figuredata.normalization=normalization;
figuredata.Zeropadding_Image=ZeropaddingImage;
figuredata.XLabel=XLabel;
figuredata.YLabel=YLabel;
figuredata.Title=Title;
figuredata.Contour=Contour;
figuredata.Zeropadding_Contour=ZeropaddingContour;
figuredata.contour_isovalues=contour_isovalues;
figuredata.name_of_scheme=name_of_scheme;
figuredata.ROIdata=ROIdata;
figuredata.omega_center=omega_center;
figuredata.gamma=gamma;
figuredata.Double_omega_tau=Double_omega_tau;
figuredata.Double_omega_t=Double_omega_t;
figuredata.Flip_w_tau=Flip_w_tau;
figuredata.Flip_w_t=Flip_w_t;
figuredata.Varpos=Varpos;
if exist('var_vector','var')==1
    figuredata.variable_vector=var_vector;
end
if exist('TimeDomainData_uncutted','var')==1
    figuredata.TimeDomainData_uncutted=TimeDomainData_uncutted;
end
