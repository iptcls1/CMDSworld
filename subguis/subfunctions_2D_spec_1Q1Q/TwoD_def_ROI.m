function [x,y,local_mask]=TwoD_def_ROI(type,activated_figure,Domain,tau_vector_image,t_vector_image,w_tau_vector_image,w_t_vector_image)
% watch out: x axis in plot is t axis in plot
% watch out: y axis in plot is tau axis in plot
axes(activated_figure);
local_mask=zeros(length(t_vector_image),length(tau_vector_image));

switch type
 case '2 point input'
    [x,y] = ginput(2);
 
    if x(1) > x(2)
    x_dummy = x(1);
    x(1) = x(2);
    x(2) = x_dummy;
    end  
    if y(1) > y(2)
    y_dummy = y(1);
    y(1) = y(2);
    y(2) =  y_dummy;
    end
 case 'manual input'
     str_ROI_values=inputdlg({'x_min value of ROI','x_max value of ROI','y_min value of ROI','y_max value of ROI'},'Manual definition of the ROI',1,{'1','20','1','20'});
     x(1)=str2double(str_ROI_values(1));
     x(2)=str2double(str_ROI_values(2));
     y(1)=str2double(str_ROI_values(3));
     y(2)=str2double(str_ROI_values(4));

    if x(1) > x(2)
    x_dummy = x(1);
    x(1) = x(2);
    x(2) = x_dummy;
    end  
    if y(1) > y(2)
    y_dummy = y(1);
    y(1) = y(2);
    y(2) =  y_dummy;
    end
    
 case 'fixed size'
    str_ROI_values=inputdlg({'Size of ROI in X dim','Size of ROI in Y dim'},'Definition of fixed area ROI',1,{'1','1'});
    Xdim=str2double(str_ROI_values(1));
    Ydim=str2double(str_ROI_values(2));
    
    [xcenter,ycenter] = ginput(1);
    x(1)=xcenter-Xdim/2;
    x(2)=xcenter+Xdim/2;
    y(1)=ycenter-Ydim/2;
    y(2)=ycenter+Ydim/2;      
    if x(1) > x(2)
    x_dummy = x(1);
    x(1) = x(2);
    x(2) = x_dummy;
    end  
    if y(1) > y(2)
    y_dummy = y(1);
    y(1) = y(2);
    y(2) =  y_dummy;
    end
    plot_square(x,y);
    
  case 'polygon'
    [x, y] = ginput; %polygon points, you have to select them
    %generate Polygon mask

    %plot_polygon(x,y);  
end

switch Domain
    case 'TimeMap'
        if strcmp(type,'polygon')==0;
            [c, index_x1] = min(abs(t_vector_image-x(1)));
            x(1)= t_vector_image(index_x1);
            [c, index_x2] = min(abs(t_vector_image-x(2)));
            x(2)= t_vector_image(index_x2);
            [c, index_y1] = min(abs(tau_vector_image-y(1)));
            y(1)= tau_vector_image(index_y1);
            [c, index_y2] = min(abs(tau_vector_image-y(2)));
            y(2)= t_vector_image(index_y2);
            local_mask(index_y1:index_y2,index_x1:index_x2)=1;
        else
            for ii=1:length(x)
            [c, index_x(ii)]= min(abs(t_vector_image-x(ii)));
                x(ii)= t_vector_image(index_x(ii));
            [c, index_y(ii)]= min(abs(tau_vector_image-y(ii)));
                y(ii)= tau_vector_image(index_y(ii));
            end
            [xRect,yRect,local_mask]=generate_Polymask_2D(index_x,index_y,local_mask);
            
        end
    case '2DSpectrum'

        if strcmp(type,'polygon')==0;
            [c, index_x1] = min(abs(w_t_vector_image-x(1)));
            x(1)= w_t_vector_image(index_x1);
            [c, index_x2] = min(abs(w_t_vector_image-x(2)));
            x(2)= w_t_vector_image(index_x2);
            [c, index_y1] = min(abs(w_tau_vector_image-y(1)));
            y(1)= w_tau_vector_image(index_y1);
            [c, index_y2] = min(abs(w_tau_vector_image-y(2)));
            y(2)= w_tau_vector_image(index_y2);
            local_mask(index_y1:index_y2,index_x1:index_x2)=1;
        else
            for ii=1:length(x)
            [c, index_x(ii)]= min(abs(w_t_vector_image-x(ii)));
                x(ii)= w_t_vector_image(index_x(ii));
            [c, index_y(ii)]= min(abs(w_tau_vector_image-y(ii)));
                y(ii)= w_tau_vector_image(index_y(ii));
            
            
            end
            [xRect,yRect,local_mask]=generate_Polymask_2D(index_x,index_y,local_mask);
        end


end



    
