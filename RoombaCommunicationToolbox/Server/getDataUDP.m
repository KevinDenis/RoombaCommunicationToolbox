function bytes_received = getDataUDP(udp_obj,data_send)
%bytes_received = getDataUDP(udp_obj,data_send)
%   Detailed explanation goes here

bytes_received=nan;

global comDelay

fail_counter=0; % display only one time failure.
smartFlush(udp_obj); % flush input buffer only if there is data in it.
try
sendDataUDP(udp_obj,data_send);
data_received=fscanf(udp_obj);
% if received nothing within timeout, try again.
while strcmp(data_received,'')    
    if fail_counter == 1
        disp('Nothing received. Trying again.')
        fail_counter=true;
    end
    fprintf(udp_obj,data_send);   
    data_received=fscanf(udp_obj);
end
bytes_received=str2byte(data_received);
catch
    disp('WARNING:  getDataUDP did not terminate correctly.  Output may be unreliable.')
end
pause(comDelay) % set to 0 normaly, in initRoomba
end