clear all
close all 
clc
n=100;
t=zeros(n,1);
port=8080;
% echoudp('on',port)

Roomba= udp('127.0.0.1',port);

if strcmp(Roomba.status,'open')
    fclose(Roomba)
end
fopen(Roomba);
for i=1:n
    fprintf(Roomba,num2str(1:100));
end

for i=1:n
    tic
    fscanf(Roomba);
    t(i)=toc;
end
disp(1/mean(t))

for i=1:n
    fprintf(Roomba,num2str(1:100));
    tic
    fscanf(Roomba);
    t(i)=toc;
end
disp(1/mean(t))