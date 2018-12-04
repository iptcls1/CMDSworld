function plotfunction_2D_spec_1Q1Q(SpecDomainData,w_tau_vector,T_vector,w_t_vector,Tpos,operation,...
        Contour,...
        SpecDomainData_contour,...
        w_tau_contour,...
        T_vector_contour,...
        w_t_contour,...
        contour_isovalues,...
        Units,...
        ROIdata)

switch operation
    case 'absolute' 
        plotcolor_fine=generate_color_map_positive_values(1000);
    case 'realpart'
        plotcolor_fine=generate_color_map_positive_negative_values(1000);
    case 'imagpart'
        plotcolor_fine=generate_color_map_positive_negative_values(1000);
    case 'absorptive'
        plotcolor_fine=generate_color_map_positive_negative_values(1000);
end
         

%>>>>>>>>>>>>>>>>>actual plotting: remember that SpecDomainData is plotted as matrix, hence
%the first index is rows, which corresponds to the y axis of a cartesian coordinate
%system. This is fixed by transposing the Specdomaindata<<<<<<<<<<<<<<<<<<<<<<<
imagesc(w_tau_vector,w_t_vector,squeeze(SpecDomainData(:,Tpos,:))');


axis xy;
box on
ax=gca;
[ xlabelstring,ylabelstring ] = build_xylabel_specdomain('option1',Units);
xlabel(xlabelstring, 'Interpreter', 'latex');
ylabel(ylabelstring, 'Interpreter', 'latex');
titlestring=build_title_1Q1Q(operation,Tpos,T_vector);
title(titlestring);
ax.XLim=[min(w_tau_vector) max(w_tau_vector)];
ax.YLim=[min(w_t_vector) max(w_t_vector)];
ax.BoxStyle='full';
ax.LineWidth=1.5;
ax.FontSize=14;
ax.GridAlpha=.1;
ax.FontName='Arial';
set(ax,'dataaspectratio',[1 1 1]);
colormap(ax,plotcolor_fine);
%ax.YTick=ax.XTick;
%colorbar
colb=colorbar;
colb.LineWidth=1.5;
colb.TickDirection='out';
colb.FontSize=16;
colb.FontName='Arial';
axis tight;
switch operation
    case 'realpart'
        set(ax,'Clim',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);
        set(colb,'Limits',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);
    case 'imagpart'
        set(ax,'Clim',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);
        set(colb,'Limits',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);
    case 'absolute'
        set(ax,'Clim',[min(min(min(SpecDomainData))) max(max(max(SpecDomainData)))]);
        set(colb,'Limits',[min(min(min(SpecDomainData))) max(max(max(SpecDomainData)))]);
    case 'absorptive'
        set(ax,'Clim',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);
        set(colb,'Limits',[-max(max(max(abs(SpecDomainData)))) max(max(max(abs(SpecDomainData))))]);    
end

if nargin > 7        
    switch Contour
        case 'off'
            %do nothing
        case 'on'
            hold on
            if all(contour_isovalues>=0)
            contour(w_tau_contour,w_t_contour,...
                squeeze(permute(SpecDomainData_contour(:,Tpos,:),[3 2 1])),...
                '-k', 'LevelList', contour_isovalues,...
                'LineWidth',1);
            else 
            contour_isovalues_positive=contour_isovalues(contour_isovalues>=0);
            contour_isovalues_negative=contour_isovalues(contour_isovalues< 0);
            contour(w_tau_contour,w_t_contour,...
                squeeze(permute(SpecDomainData_contour(:,Tpos,:),[3 2 1])),...
                '-k', 'LevelList', contour_isovalues_positive,...
                'LineWidth',1);
            contour(w_tau_contour,w_t_contour,...
                squeeze(permute(SpecDomainData_contour(:,Tpos,:),[3 2 1])),...
                '-.k', 'LevelList', contour_isovalues_negative,...
                'LineWidth',1);
            
            end
            hold off
    end
    
end        

if exist('ROIdata','var')==1 && ~isempty(ROIdata)==1
        ColorOrder=lines(10);
        ColorOrder=flipud(ColorOrder);
  for nn=1:length(ROIdata.ROI_data_x)

        %check for polygon or rectangles
        if length(ROIdata.ROI_data_x{nn})==2
           if sum(sum(ROIdata.ROI_mask_data{nn}))>1;
           plot_square(ROIdata.ROI_data_x{nn},ROIdata.ROI_data_y{nn},ColorOrder(nn,:));
           else
           plot_point(ROIdata.ROI_data_x{nn}(1,1),ROIdata.ROI_data_y{nn}(1,1),ColorOrder(nn,:));    
           end
        else
           if sum(sum(ROIdata.ROI_mask_data{nn}))>1;
           plot_polygon(ROIdata.ROI_data_x{nn},ROIdata.ROI_data_y{nn},ColorOrder(nn,:));
           else
           plot_point(ROIdata.ROI_data_x{nn},ROIdata.ROI_data_y{nn},ColorOrder(nn,:));    
           end
        end
  end
end

end

