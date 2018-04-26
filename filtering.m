function [af,n1]=filtering(b,n1,n2,filt_num)
%   function to filter pulse
% n-step filtering
flag=0;
flag1=0;
nn1=1;
nn2=17;
n=10;
%af=filter(filt_num,3,b(n1:n2,5));
scal = 'one';
af=medfilt1(b(n1:n2,5),filt_num);
%af = wden(b(n1:n2,5),'heursure','s',scal,3,'sym8');
%af = sgolayfilt(b(n1:n2,5), nn1, nn2);
%daf(:)=log(af(:));
%df=medfilt1(daf,filt_num);
%df=sgolayfilt(daf,nn1,nn2);
%af(:)=exp(df(:));
if flag1==1
for ii=1:n
    aff=medfilt1(af,filt_num);
    af(:)=aff(:);
    daf(:)=log(af(:));
    df=medfilt1(daf,filt_num);
    af(:)=exp(df(:));
end
end
%af=movmean(b(n1:n2,5),filt_num);
%af = smoothdata(b(n1:n2,5),'gaussian',filt_num);
af(1,1)=af(2,1);
[~,maxn]=max(af(:,1));
n1=n1+maxn;
af(1:maxn,:)=[];
af(end,1)=af(end-1,1);
%% plot
if flag==0
    figure(3);
    clf;
    hold on;
    plot(b(n1:n2,1),b(n1:n2,5));
    plot(b(n1:n2,1),af);
end
