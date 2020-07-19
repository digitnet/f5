clear all; close all; clc;
OriginalImg='CoverImage1.JPG'; % Original image file - Cover Image.
Messagefile='Message1.txt'; % Secret Message file, whatever the extension.
SteganoImg='StegoImage1.JPG'; % Resulting image file - Stego Image.
Msgbits=Msgsize(Messagefile);
JPG=jpeg_read(OriginalImg); % Reading original image file / Huffman decoding.
mat1=JPG.coef_arrays{1}; % Y component matrix
Qtb1=JPG.quant_tables{JPG.comp_info(1).quant_tbl_no};
% img1= Qdct2Img(mat1,Qtb1);
% figure(1);
% imshow(img1); % showing Y component of the Original image.
Cap=MediCap(mat1); % Calculating Nonzero coefficients.
siz=size(mat1);
Rw=siz(1); % rows : Height.
Cl=siz(2); % columms : Width.
CoefNb=Cl*Rw;
TmpBuff=zeros(1,CoefNb); % Temporary Buffer.
RltBuff=zeros(1,CoefNb); % Resulting Buffer.
%
indx=0;
for xx=1:Rw
for yy=1:Cl
indx=indx+1;
TmpBuff(indx)=mat1(xx,yy);
end
end
% Now, we have (indx=CoefNb).

% ....................
% At this point, a permutation should be applied to the Temporary Buffer : TmpBuff
% ....................
Embrate= 100*(Msgbits/Cap);
Encod=MatEncod(Embrate); % Calculating Matrix Encoding.
% .................... Main Processing LOOP ....................
WrkCn=0; % Counter of work process
WrkDone=0;
while(WrkDone==0) % Main Processing LOOP
WrkCn=WrkCn+1;
% Available codewords number (Cap/n).
AvalCdWd=(Cap-mod(Cap,Encod(2)))/Encod(2);
% Needed codewords number (Msgbits/k).
NeedCdWd=(Msgbits-mod(Msgbits,Encod(3)))/Encod(3);
% Stego Operation, We have : AvalCdWd > NeedCdWd
SecData=GetkBits(Messagefile,Encod(3));
mBuff=zeros(1,1);
ShkgCn=0; % Shrinkage counter.
cont=0; % (n) nonzero counter.
indx=1;
ix=1;
CdWd=1; % Codeword index.
while ((CdWd<=NeedCdWd) && (indx <= CoefNb))
while ((cont<Encod(2)) && (indx <= CoefNb))
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
if(indx <= CoefNb)
m=ix-1; % the buffered number.
% Now, we have (cont=Encod(2)).
MBuff_shk=DoEmbed(mBuff,m,Encod(2),SecData(CdWd));
if (MBuff_shk{1,2}==0) % No Shrinkage.
OutBuffs{1,CdWd}=MBuff_shk{1,1};
CdWd=CdWd+1;
mBuff=zeros(1,1);
cont=0;
ix=1;
elseif (MBuff_shk{1,2}==1) % Shrinkage.
ShkgCn=ShkgCn+1;
ShkPot=MBuff_shk{1,3};
mBuff(ShkPot)=0;
cont=cont-1;
end
end
end

if (indx > CoefNb) % The case where (indx) exceeded (CoefNb)
Embrate=100*(Encod(3)/Encod(2));
Encod=MatEncod(Embrate); % Recalculating Encod
WrkDone=0; % The work is NOT done
end
if (CdWd > NeedCdWd) % The case where the work is done
WrkDone=1;
end
end % End of Main Processing LOOP
% .................................................................
% ……………End of Main Processing LOOP………………
% .................................................................
ChgMax=ShkgCn+NeedCdWd; % Maximum number of changes.
BffLmt=indx-1; % Reached limit in TmpBuff.
% End of Stego Operation
%
% Constructing Resulting Buffer : RltBuff
Concat=[OutBuffs{1,1} OutBuffs{1,2}];
for i=3:NeedCdWd % Concatenation.
Concat=[Concat OutBuffs{1,i}];
end
Sz=size(Concat);
for i=1:Sz(2)
RltBuff(i)=Concat(i);
end
for i=Sz(2)+1:CoefNb
RltBuff(i)=TmpBuff(i);
end

% ....................
% At this point, In case we used Permutation, The inverse Permutation
% should be applied to the Resulting Buffer : RltBuff
% ....................
% Histogram of resulting Buffer.
figure(2);
HH=HistPlot(RltBuff,25,0,0);
% Constructing New Coefficients Matrix.
siz=size(mat1);
Rw=siz(1); % rows : Height.
Cl=siz(2); % columms : Width.
Nmat1=zeros(Rw,Cl);
inx=0;
for xx=1:Rw
for yy=1:Cl
inx=inx+1;
Nmat1(xx,yy)=RltBuff(inx);
end
end
% Now, we have (inx=CoefNb).
%
% Stego image Reconstruction
JPG.coef_arrays{1}=Nmat1; % New Coefficients Matrix (Y component).
jpeg_write(JPG,SteganoImg);
%

% showing the Stego image (Y component).
JPG=jpeg_read(SteganoImg);
mat1=JPG.coef_arrays{1};
Qtb1=JPG.quant_tables{JPG.comp_info(1).quant_tbl_no};
% img2= Qdct2Img(mat1,Qtb1);
% figure(3);
% imshow(img2);
%