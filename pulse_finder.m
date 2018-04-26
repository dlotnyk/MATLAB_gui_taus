function d=pulse_finder(b,nc)
%   function to find number of pulses
id1=find(abs(b(:,5))>2000);

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
%coun=coun+1;
d(coun,1)=id1(end)+10;
d(coun,2)=length(b);
d;