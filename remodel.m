function [yfit,tim,n1,n2]=remodel(x,m1,tim,tp,beg,orig,bp,n1,n2,begf)
%   function to remodel the fit
%   x - already fit,     y
%   orig -- raw data    app.ff
%   tim - time from 0   app.tim
%   beg - cut from begin after filtering    app.beg2
%   tp - time of pulses     app.c(app.n_pul,1)
%   bp - background parameters  app.poly_off
%   n1,n2 begin/end pulse app.c(app.n_pul,1) app.c(app.n_pul,2)

flag1=0;
n1=n1+begf;
n2=n2+begf;
x(:)=x(:)+m1;
tsh=orig(n1+beg,1);
tim(:)=tim(:)+tsh;

back = polyval(bp,tim(:));
if tp == 0
    yfit(:)=x(:)+back(:);
else
    yfit(:)=back(:)-x(:);
end
if flag1==1
    figure(1);
    clf;
    hold on;
    plot(orig(n1:n2,1),orig(n1:n2,5),'-b');
    plot(tim,yfit,'-r')
    
end
