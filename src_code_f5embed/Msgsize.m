function bitSize=Msgsize(msgfile)
%
fileObj = memmapfile(msgfile);
siz = size(fileObj.data);
FileSiz=siz(1); % File Size in Bytes.
bitSize= FileSiz*8; % File Size in Bits.
%