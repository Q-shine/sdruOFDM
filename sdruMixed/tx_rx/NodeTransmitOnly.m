function NodeTransmitOnly

Receiver = PHYReceive;
Transmitter = PHYTransmit;

for i = 1 : 20e4
    
    
    % Send something
    %MACLayerTransmitter(Receiver,Transmitter,'HelloShannon')
    Transmitter.Run('HelloShannon',1000);
    
end




end
