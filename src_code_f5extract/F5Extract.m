clear all;close all; clc;
% In order to extract the hidden file correctly, the Value
% of Encod (Matrix Encoding) must be set as calculated in
% the embedding process : F5Embed.m .
% Used Matrix Encoding
Encod=[1 7 3]; % [1 7 3],[1,31,5],[1,63,6],[1,255,8][1 15 4];
%
StegoIm='StegoImage1.JPG'; % Received Stego Image file.
Rcvmsg='Extracted1.txt'; % Extracted Hidden Message file.
%
JPG=jpeg_read(StegoIm);
mat1=JPG.coef_arrays{1};
Cap=MediCap(mat1);
% Available codewords number (Cap/n).
AvalCdWd=(Cap-mod(Cap,Encod(2)))/Encod(2);
%
siz=size(mat1);
Rw=siz(1); % rows : Height.
Cl=siz(2); % columms : Width.
CoefNb=Cl*Rw;
TmpBuff=zeros(1,CoefNb);
mBuff=zeros(1,1);
%
indx=0;
for xx=1:Rw
for yy=1:Cl
indx=indx+1;
TmpBuff(indx)=mat1(xx,yy);
end
end


% ....................
% At this point, we should apply the same permutation
% which was used in the embedding process to TmpBuff.
% ....................
cont=0;
CdWd=1;
indx=1;
ix=1;
ExVal=0;
while(CdWd<=AvalCdWd) % Extraction LOOP
while (cont<Encod(2))
if (TmpBuff(indx)==0)
mBuff(ix)=TmpBuff(indx);
indx=indx+1;
ix=ix+1;
elseif (TmpBuff(indx)~=0)
mBuff(ix)=TmpBuff(indx);
cont=cont+1;
indx=indx+1;
ix=ix+1;
end
end
m=ix-1; % The bufferd number.
ExVal=[ExVal DoExtract(mBuff,m,Encod(2))];
CdWd=CdWd+1;
mBuff=zeros(1,1);
ix=1;
cont=0;
end % End of Extraction LOOP
% .................... % End of Extraction LOOP
% ............................................................
% Writing extracted Bits stream to a file (secret message file).
k=Encod(3);
Frmt=['ubit' int2str(k)];
fid=fopen(Rcvmsg,'w');
for i=2:AvalCdWd+1
count = fwrite(fid,ExVal(i),Frmt); % Creating the output file.
end
fclose(fid);
%

