function cv=exp4fitfunUI(parameter,t)
% modified exponential Mueller fit for GUI tau dependent of time linearly

A=real(parameter(1));
B=real(parameter(2));
tau=real(parameter(3));
t0=real(parameter(4));
gamma=real(parameter(5));

cv=zeros(1,length(t));
for ii=1:length(t)
   %cv(1,ii)=A+B*t(ii)+exp(-(t(ii)-t0)/(tau+gamma*exp(-lambda*t(ii)))); 
   %cv(1,ii)=A+B*t(ii)+exp(-(t(ii)+t0)/(tau+gamma*t(ii)));
   cv(1,ii)=A+B*t(ii)+0.5*(gamma+sqrt(gamma^2+4*exp(-(t(ii)+t0)/tau)));
end