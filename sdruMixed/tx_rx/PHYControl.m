function [ Response ] = PHYControl(Receiver)

% 0 = Call PHY Receiver
% 1 = Timeout
% 2 = Corrupt Message
% 3 = Message Reception Successfull
state = 0;

coder.extrinsic('num2str','disp');

timeouts = 0; % Counter
maxTimeouts = 4;

% Message string holder
coder.varsize('Response', [1, 80], [0 1]);
Response = '';

% Run system
while 1
    % Process Messages
    switch state
        
        %Wait for message
        case 0
            if timeouts > maxTimeouts
                disp('Max timeouts reached');
                Response = 'Timeout';
                return;
            end
            Response = Receiver.Run;
	    disp(['|',Response,'|']);
            if strcmp(Response, 'Timeout')
                state = 1;
            elseif strcmp(Response,'CRC Error')
                state = 2;
            else
                state = 3;
            end
                    
        % Timeout occured    
        case 1
            disp('Timeout occured');
            timeouts = timeouts + 1;
            if timeouts > maxTimeouts
                disp('Max timeouts reached');
                Response = 'Timeout';
                return;
            end
            state = 0;%Get another message
            
        % Message corrupted    
        case 2
            disp('Message corrupted');
            timeouts = timeouts + 1;
            state = 0;%Get another message
            
        % Default: Message successfully received    
        case 3%otherwise
            disp(['MSG: ',Response])
            disp(['Timeouts: ',num2str(timeouts)])
            return;
    end
    
end



end

