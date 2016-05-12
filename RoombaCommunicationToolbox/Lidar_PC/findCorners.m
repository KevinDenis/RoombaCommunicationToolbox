function [corner_idx] = findCorners(dist_scan,angle_scan)
%FINDCORNERS Summary of this function goes here
%   Detailed explanation goes here

%% parameters
n=length(dist_scan);

ddiff_thr=0.05;
angle_thr=10*pi/180;
%% code
[x_scan,y_scan]=pol2cart(angle_scan,dist_scan);

% 2nd derevative to x
x_ddiff=[0;diff(x_scan,2);0];
y_ddiff=[0;diff(y_scan,2);0];


xy_difff=abs(y_ddiff)+abs(x_ddiff);

corner_angle=zeros(2,1);
corner_idx=zeros(2,1);
j=1;
xy_diff_mod=xy_difff;
for i=1:n
    [val,idx]=max(xy_diff_mod);
    if val>ddiff_thr
        corner_angle(j)=angle_scan(idx);
        corner_idx(j)=idx;
        j=j+1;
        xy_diff_mod(idx-5:1:idx+5,:)=0;
    else
        break
    end
end

figure(2)
scatter(1:length(xy_difff),xy_difff,'b.'); hold on,
scatter(corner_idx,xy_difff(corner_idx,:),'r*')

figure(3)
plot(x_scan,y_scan); hold on;
scatter(x_scan(corner_idx,:),y_scan(corner_idx,:),'r*')
end

