function textout=generate_text_weights(weights,pc_scheme)
SizePhases=size(weights);
for ii=1:SizePhases(1);

        textarray{ii}=num2str(weights(ii,1:SizePhases(2))*prod(pc_scheme),'% 5.3f');

end
textout=strvcat(textarray);