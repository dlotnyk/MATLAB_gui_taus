function [a,bc,counts,h,p,st]=errans(yf,ye,num,res,nbins)
%   function to perform error analysis. yf-fit, ye-experiment, num - number
%   of fit parameters
flag1=0;
b=num;
a=0;
for ii=1:length(yf)
    s=(yf(ii)-ye(ii))^2/yf(ii);
    a=a+s;
end
%c = goodnessOfFit(ye,yf,'NRMSE');
%nbins=19;
mm=mean(res(:));
m1=min(res(:));
m2=max(res(:));
if abs(m2)>abs(m1)
    m3=m2;
else
    m3=abs(m1);
end
bb=linspace(-m3,m3,nbins+1); %edges
bc=zeros(nbins,1); % centers
counts=zeros(nbins,1);
for ii=1:nbins
    bc(ii,1)=(bb(ii)+bb(ii+1))/2;
    for jj=1:length(res)
        if res(jj)>=bb(ii) && res(jj)<=bb(ii+1)
            counts(ii)=counts(ii)+1;
        end
    end
end
[h,p,st] = chi2gof(res,'NBins',nbins,'Nparams',num,'Alpha',0.01);
if flag1==1
figure(1);
clf;
plot(bc,counts,'-x')
end