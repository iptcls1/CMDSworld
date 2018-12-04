function textout=generate_text_phases(phases)
%textarray

SizePhases=size(phases);
for ii=1:SizePhases(1);

        textarray{ii}=num2str(phases(ii,1:SizePhases(2))/pi,'% 5.4f');

end
textout=strvcat(textarray);