function [xvalues,yvalues,mask_local]=generate_Polymask_2D(xPoly,yPoly,ZeroMask)

% round to integer pixel
xPoly=round(xPoly);
yPoly=round(yPoly);

% define rectangle with two points in which the polygon is located.
xvalues=[min(xPoly),max(xPoly)];
yvalues=[min(yPoly),max(yPoly)];
%define width and heigth of rectangle in which polygon is located
w=max(xPoly)-min(xPoly)+1;
h=max(yPoly)-min(yPoly)+1;

%generate linear Index
Ind=1:w*h;

%generate indices of array with dim w*h
[I,J]=ind2sub([w,h],Ind);


[in,~]=inpolygon(I,J,xPoly-min(xPoly),yPoly-min(yPoly));

mask_local=reshape((in)*1,[w,h]);
mask_local=mask_local';



%generate global mask for whole picture

ZeroMask(min(yPoly):max(yPoly),min(xPoly):max(xPoly))=mask_local;
mask_local=ZeroMask;



