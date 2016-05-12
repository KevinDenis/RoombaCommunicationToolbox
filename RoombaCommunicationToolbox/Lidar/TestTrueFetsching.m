n=50;
dt=zeros(n,1);
for i=1:n
    tic
    scan = getLidarScan(localPort);
    dt(i)=toc;
    pause(0.5)
end
pd = fitdist(dt,'Normal')