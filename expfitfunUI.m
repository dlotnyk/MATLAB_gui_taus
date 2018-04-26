function cv=expfitfunUI(parameter,t)
% exponential fit for GUI

A=real(parameter(1));
t0=real(parameter(2));
tau=real(parameter(3));
B=real(parameter(4));
cv=zeros(1,length(t));

for ii=1:length(t)
   cv(1,ii)=A*exp(-(t(ii)-t0)/tau)+B;    
end