clear all
close all
clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
    echoudp('off')

end


n=100;
dt=zeros(n,1);
echoudp('on',4012)
UDP = udp('127.0.0.1',4012);
UDP.InputBufferSize=6000;
fopen(UDP);



% for i=1:n
%     for j=1:100
%         fwrite(UDP,j)
%     end
% 
%     tic
%     while UDP.BytesAvailable ~= 0
%         data=fread(UDP);
%     end
%     dt(i)=toc;
% 
% end
% disp(data)
% % fread(UDP)
% % fread(UDP)
% % 
% pd = fitdist(dt,'Normal');
% % 
% freq=1/pd.mu;
% disp(freq)

fclose(UDP);
for i=1:n
    tic
    fopen(UDP);
    dt_temp=toc;
   for j=1:100
        fwrite(UDP,j)
   end
    tic
    fclose(UDP);
    dt(i)=toc+dt_temp;
end
% fread(UDP)

pd = fitdist(dt,'Normal');

freq=1/pd.mu;
disp(freq)