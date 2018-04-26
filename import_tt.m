function [cf,ff]=import_tt()
%   function to import data of thermal conductivity
path1=[pwd,'/CF2mKheat.dat'];
path2=[pwd,'/FF2mKheat.dat'];
cf1=importdata(path1);
ff1=importdata(path2);
cf=str2double(cf1.textdata(2:end,2:end));
ff=str2double(ff1.textdata(2:end,2:end));
cf(:,1)=cf(:,1)-cf(1,1);
ff(:,1)=ff(:,1)-ff(1,1);
cf(:,end)=[];
ff(:,end)=[];
%cf=cf1.textdata(2:end,2:end);
%ff=ff1.textdata(2:end,2:end);