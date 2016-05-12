
py_udp_send('192.168.1.100',8080,'146,0,0,0,0') %%% drive straight ahead 

%pause(3)


tic
py_udp_send('192.168.1.100',8080,'141,1')  %%%% ceep

py_udp_send('192.168.1.100',8080,'142,7')  %%%% Ask data
pause(.1)
data= py_udp_receive(8080)
% unicode2native(data,'windows-1252')
toc