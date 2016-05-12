clear all
close all
clc


n=length(lidarScan);

ddiff_thr=0.05;
angle_thr=10*pi/180;

angle_scan=lidarScan(:,2);
dist_scan=lidarScan(:,1);

tic
[corner_idx] = findCorners(dist_scan,angle_scan)
toc
% figure
% scatter(1:length(xy_difff),xy_difff,'b.'); hold on,
% scatter(corner_angle_idx,xy_difff(corner_angle_idx,:),'r*')
% 
% figure
% plot(x_scan,y_scan); hold on;
% scatter(x_scan(corner_angle_idx,:),y_scan(corner_angle_idx,:),'r*')