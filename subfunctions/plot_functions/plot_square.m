function plot_square(X,Y,Color)
w=X(2)-X(1);
h=Y(2)-Y(1);
if nargin<3
rectangle('Position',[X(1),Y(1),w,h],'LineWidth',1.5);
%     if w==0 && h==0
%         scatter(X(1),Y(1),'X');
%     end
else
rectangle('Position',[X(1),Y(1),w,h],'LineWidth',1.5,'EdgeColor',Color);
    if w==1 && h==1
        scatter(X(1),Y(1),'X');
    end
end
