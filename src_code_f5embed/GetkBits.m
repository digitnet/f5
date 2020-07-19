function SecData=GetkBits(msgfile,k)
% Distribute the information to be hidden on a matrix
% Creating a matrix (SecData) including the Bits stream
% of the secret message file according to (k) value.
% msgfile : File name String.
% k : Embeded data size.
Frmt=['ubit' int2str(k)];
Msgbits=Msgsize(msgfile);
Nb=(Msgbits-mod(Msgbits,k))/k;
SecData=zeros(1,Nb);
fid=fopen(msgfile,'r');
for idx=1:Nb
SecData(idx)= fread(fid,1,Frmt);
end
fclose(fid);
%