function T_scan_data=calculate_T_scan_1Q1Q(InputData,ROIdata,T_vector)
for ii=1:length(ROIdata.ROI_data_x)
    for nn=1:length(T_vector)
        SizeArea=sum(ROIdata.ROI_mask_data{ii}(:)==1);
        T_scan_data(ii,nn)=sum(sum(squeeze(InputData(:,nn,:)).*ROIdata.ROI_mask_data{ii}))/SizeArea;
    end
end