%% parameters
n=60000;


%% No preallocation
data=[];
tic
for i=1:n
    data=[data;rand(1,1)];
end
toc

%% Good preallation
data=zeros(n,1);
tic
for i=1:n
    data(i)=rand(1,1);
end
toc


%% Weird preallication
data=zeros(1,1);
tic
for i=1:n
    data(i)=rand(1,1);
end
toc