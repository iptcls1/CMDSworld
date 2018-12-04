function plot_polygon(X,Y,Color)
X(end+1)=X(1);
Y(end+1)=Y(1);
if nargin<3
hold on
plot(X,Y,'.-','LineWidth',1.5)
hold off
else
hold on
plot(X,Y,'.-','LineWidth',1.5,'Color',Color);    
hold off
end
