function [x1,y1]=shiftb(x,y,b)
%   function to shift curve
flag1=0;
x1=x;
y1=y;
y1=y1+b;
size(y);
[~,ind1]=find(y1<0);
[b1,b2]=size(ind1);

%% cut
if b2~=0
x1(:,ind1(1)-1:end)=[];
y1(:,ind1(1)-1:end)=[];
end
if flag1==1
    figure(21);
    clf;
    hold on;
    plot(x,y);
    plot(x1,y1);
end