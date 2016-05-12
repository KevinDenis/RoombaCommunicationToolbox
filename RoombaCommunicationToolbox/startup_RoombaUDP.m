path = fileparts( mfilename('fullpath') );

roombapath = fullfile(path, 'Roomba');
if exist(roombapath,'dir')
    addpath(roombapath);
end

serverpath = fullfile(path, 'Server');
if exist(serverpath,'dir')
    addpath(serverpath);
end

miscpath = fullfile(path, 'MISC');
if exist(miscpath,'dir')
    addpath(miscpath);
end

lidarpath = fullfile(path, 'Lidar');
if exist(lidarpath,'dir')
    addpath(lidarpath);
end

debugpath = fullfile(path, 'DEBUG');
if exist(debugpath,'dir')
    addpath(debugpath);
end

clear path roombapath serverpath miscpath lidarpath debugpath
