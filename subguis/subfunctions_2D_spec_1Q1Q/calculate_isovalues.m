function contour_isovalues=calculate_isovalues(input_data,contour_isovalues,operation,normalization)
switch operation
    case 'absolute'
        contour_isovalues=linspace(min(min(min(input_data))),max(max(max(input_data))),contour_isovalues+2);%min and max is always included! Results in contour_isovalues between min and max
    case 'realpart'
        contour_isovalues=linspace(-max(max(max(abs(input_data)))),max(max(max(abs(input_data)))),contour_isovalues+2);%min and max is always included! Results in contour_isovalues between min and max
    case 'imagpart'
        contour_isovalues=linspace(-max(max(max(abs(input_data)))),max(max(max(abs(input_data)))),contour_isovalues+2);%min and max is always included! Results in contour_isovalues between min and max
    case 'absorptive'
        contour_isovalues=linspace(-max(max(max(abs(input_data)))),max(max(max(abs(input_data)))),contour_isovalues+2);%min and max is always included! Results in contour_isovalues between min and max

end

switch normalization
    case 'No Normalization'
        %do nothing
    case 'Normalization'
        contour_isovalues=contour_isovalues/max(max(max(abs(input_data))));
end