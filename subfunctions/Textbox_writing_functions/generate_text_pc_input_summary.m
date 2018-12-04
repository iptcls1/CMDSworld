function text=generate_text_pc_input_summary(weights,name_of_scheme)  
text=strvcat(name_of_scheme,['Number of pc steps: ' num2str(length(weights))]);
