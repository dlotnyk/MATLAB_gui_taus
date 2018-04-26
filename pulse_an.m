function [c,d,af,temperature]=pulse_an(a,b,nc)
%   fuction for simple linear analysis of pulses
pul_num=6;
cffit=0;
clearvars -global
filt_num=20; % for median filter
num_av=50; % for averaging end-to-end
flag1=0;
flag2=0;
flag3=1;
%% find pulses by search Q FF < 0
id1=find(b(:,5)<0);
c(1,1)=id1(1,1);
%c(1,2)=id1(end,1);
buf=id1(1,1);
counter=1;
for ii=2:length(id1)-1
    
    if id1(ii,1)==buf+1
        buf=buf+1;
    else
        counter=counter+1;
        c(counter,1)=buf-1;
        counter=counter+1;
        c(counter,1)=id1(ii,1)+1;
        %c(counter,2)=id1(end,1);
        buf=id1(ii,1);
    end
end
%c(end,:)=[];
c(1,:)=[];
%% pulse
dn=ceil(length(c)/2);
d=zeros(dn,2);
coun=1;
for ii=1:length(c)
    if mod(ii,2)==0
        c(ii,1)=c(ii,1)-nc;
        d(coun,2)=c(ii,1);
        coun=coun+1;
    else
        c(ii,1)=c(ii,1)+nc;
        d(coun,1)=c(ii,1);
        
    end
end
%% filter

%[af1,n11]=filtering(b,d(pul_num,1),d(pul_num,2),filt_num);
%% pulse analysis
if cffit==1
    b=a;
end
for jj=1:1
    [af1,n11]=filtering(b,d(jj,1),d(jj,2),filt_num);
    [af2,n21]=filtering(b,d(jj+1,1),d(jj+1,2),filt_num);
    plot(b(n11:d(jj,2),1),af1);
    plot(b(n21:d(jj+1,2),1),af2);
    %af=[af1;af2];
    % end to end
    mean1x=mean(b(d(jj,2)-num_av:d(jj,2),1));
    mean1y=mean(af1(end-num_av:end));
    mean2x=mean(b(d(jj+1,2)-num_av:d(jj+1,2),1));
    mean2y=mean(af2(end-num_av:end));
    k=(mean2y-mean1y)/(mean2x-mean1x);
    b1=mean1y-k*mean1x;
    xx=[mean1x,mean2x];
    yy=[mean1y,mean2y];
    plot(xx,yy,'-r','LineWidth',2.0);
    daf1(:)=af1(:)-k.*b(n11:d(jj,2),1)-b1;
    daf2(:)=abs(daf1(:));
    daf1=daf2;
    % shift time to zero
    time(:)=b(n11:d(jj,2),1)-b(n11,1);
    size(time);
    [time,daf1]=shiftb(time,daf1,0.09);
    adaf1(:)=abs(daf1(:));
    figure(5);
    clf;
    hold on;
    plot(time,daf1);
    plot(time,adaf1);
    drawnow;
    lndaf1(:)=log(adaf1(:));
    % fit
    temperature=mean(b(n11:n11+num_av,12));
    %af=expofit(time,adaf1);
    %ff1=linofit(time,lndaf1);
    [af,expf,linf]=doublef(time,adaf1);
    draw_fit(time,adaf1,expf,linf,af,temperature);
end
[~,idd]=find(daf1<1);

yyn(:)=daf1(idd(1):end);
lyd(:)=log(yyn(:));
if flag2==1
    figure(16);
    clf;
    plot(1:length(lyd),lyd)
end
%% plotting
if flag1==1
figure(2);
clf;
hold on;
plot(b(n1:n2,1),b(n1:n2,5));
plot(b(n1:n2,1),af(maxn+1:end,1));
end
