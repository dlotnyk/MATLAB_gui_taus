function yf=testL(x)
%   test function to find linear fit of temperature in SF
flag1=0;
y=x;
s=find(isnan(x(:,12)));
x(s,:)=[];
f=polyfit(x(:,1),x(:,12),1);
yf=polyval(f,y(:,1));
if flag1==1
figure(1);
clf;
hold on;
plot(x(:,1),x(:,12),'.b');
plot(x(:,1),yf,'-r');
end