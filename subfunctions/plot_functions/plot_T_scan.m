function plot_T_scan(axeshandle,T_vector,T_scan_data)
axes(axeshandle);
hold on;
ColorOrder=lines(10);
ColorOrder=flipud(ColorOrder);
for ii=1:size(T_scan_data,1)
    h=plot(T_vector,T_scan_data(ii,:),'Color',ColorOrder(ii,:));
    h.LineWidth=1.5;
end  

hold off;
box on;
ax=gca;

ax.BoxStyle='full';
ax.LineWidth=1.5;
ax.FontSize=14;
ax.GridAlpha=.1;
ax.FontName='Arial';


xlabel('Time Delay \Delta T [fs]');
ylabel('ROI Intensity');

title('Population Time Scan ');