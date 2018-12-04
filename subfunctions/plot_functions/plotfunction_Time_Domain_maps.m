%this plot function plot Time Domain Maps tau vs t for T_increment of
%T_vector and phase-cycling step pcstep
function plotfunction_Time_Domain_maps(TimeDomainData,tau_vector,T_vector,t_vector,pcstep,T_increment,operation,...
        Contour,...
        Time_data_contour,...
        tau_vector_contour,...
        T_vector_contour,...
        t_vector_contour,...
        contour_isovalues,...
        ROIdata)

if nargin <7
plotcolor_fine=generate_color_map(1000);
%>>>>>>>>>>>>>>>>>actual plotting: remember that SpecDomainData is plotted as matrix, hence
%the first index is rows, which corresponds to the y axis of a cartesian coordinate
%system. <<<<<<<<<<<<<<<<<<<<<<<

imagesc(t_vector,tau_vector,squeeze(TimeDomainData(pcstep,:,T_increment,:))');
plotcolor_fine=generate_color_map_positive_values(1000);

else
            plotcolor_fine=generate_color_map_positive_values(1000);
    switch operation
        case 'absolute' 
            plotcolor_fine=generate_color_map_positive_values(1000);
        case 'realpart'
            plotcolor_fine=generate_color_map_positive_negative_values(1000);
        case 'imagpart'
            plotcolor_fine=generate_color_map_positive_negative_values(1000);
    end
%>>>>>>>>>>>>>>>>>actual plotting: remember that SpecDomainData is plotted as matrix, hence
%the first index is rows, which corresponds to the y axis of a cartesian coordinate
%system. <<<<<<<<<<<<<<<<<<<<<<<
    if ndims(TimeDomainData)==3
    imagesc(t_vector,tau_vector,squeeze(TimeDomainData(:,T_increment,:))');
    elseif ndims(TimeDomainData)>3
    imagesc(t_vector,tau_vector,squeeze(TimeDomainData(pcstep,:,T_increment,:))')    
    end
end

axis xy;
box on
ax=gca;

ax.BoxStyle='full';
ax.LineWidth=1.5;
ax.FontSize=14;
ax.GridAlpha=.1;
ax.FontName='Arial';
set(ax,'dataaspectratio',[1 1 1]);

colormap(ax,plotcolor_fine);
% axis labels
[xlabelstring,ylabelstring]=build_xylabel_timedomain('option1');
xlabel(xlabelstring);
ylabel(ylabelstring);

title('Time Domain Map');

ax.YTick=ax.XTick;

%colorbar
colb=colorbar;
colb.LineWidth=1.5;
% colb.XColor=[34,139,34]/255;%forest green;
% colb.YColor=[34,139,34]/255;%forest green;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
drawnow;

% define colorbar limits and colorplot limits
if nargin >=7
switch operation
    case 'realpart'
        set(ax,'Clim',[-max(max(max(max(abs(TimeDomainData))))) max(max(max(max(abs(TimeDomainData)))))]);
        set(colb,'Limits',[-max(max(max(max(abs(TimeDomainData))))) max(max(max(max(abs(TimeDomainData)))))]);
    case 'imagpart'
        set(ax,'Clim',[-max(max(max(max(abs(TimeDomainData))))) max(max(max(max(abs(TimeDomainData)))))]);
        set(colb,'Limits',[-max(max(max(max(abs(TimeDomainData))))) max(max(max(max(abs(TimeDomainData)))))]);
    case 'absolute'
        set(ax,'Clim',[min(min(min(min(TimeDomainData)))) max(max(max(max(TimeDomainData))))]);
        set(colb,'Limits',[min(min(min(min(TimeDomainData)))) max(max(max(max(TimeDomainData))))]);
end 
else
        set(ax,'Clim',[min(min(min(min(TimeDomainData)))) max(max(max(max(TimeDomainData))))]);
        set(colb,'Limits',[min(min(min(min(TimeDomainData)))) max(max(max(max(TimeDomainData))))]);

end


%add contour lines
if nargin > 7        
    switch Contour
        case 'off'
            %do nothing
        case 'on'
            hold on
            contour(tau_vector_contour,t_vector_contour,...
                squeeze(permute(Time_data_contour(:,T_increment,:),[3 2 1])),...
                '-k', 'LevelList', contour_isovalues,...
                'LineWidth',1);
            hold off
    end   
end        

if exist('ROIdata','var')==1 && ~isempty(ROIdata)==1
  ColorOrder=lines(10);
  for nn=1:length(ROIdata.ROI_data_x)
        %check for polygon or rectangles
        if length(ROIdata.ROI_data_x{nn})==2
           plot_square(ROIdata.ROI_data_x{nn},ROIdata.ROI_data_y{nn},ColorOrder(nn,:));
        else
           plot_polygon(ROIdata.ROI_data_x{nn},ROIdata.ROI_data_y{nn},ColorOrder(nn,:));    
        end
  end
end



