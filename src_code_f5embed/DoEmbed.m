function MBuff_shk=DoEmbed(mBuff,m,n,DesiredVal)
% mBuff has the size (m) and contains (m) qDCT coefficients.
% mBuff contains (n) Nonzero qDCT coefficients.
% m >= n
% m : loop-changeable value.
% n : the encoding value, Matrix Encoding =(1,n,k).
% DesiredVal : the desired value to be embedded.
% DesiredVal will be within [0,1,..,n], k Bits.
nBuff=zeros(1,n);
j=0;
for i=1:m
if (mBuff(i)~=0) % Nonzero values.
j=j+1;
nBuff(j)=mBuff(i);
mBuff(i)=0.5; % Marking the Nonzero value locations.
end
end
% Now, we have (j=n).
NBuff=zeros(1,n);
% Appling F5 algorithm on nBuff.
if(j==n)
NBuff=DoStego(nBuff,n,DesiredVal);
end
% Reforming mBuff.
% Shrinkage Testing in steganographed NBuff.
Shk=0; % Shrinkage Indicator.
ShkPt=0; % Shrinkage Position.
j=0;
for i=1:m
if (mBuff(i)==0.5)
j=j+1;
mBuff(i)=NBuff(j);
if (NBuff(j)==0) % Shrinkage Test.
Shk=1; % Shrinkage Indicator.
ShkPt=i; % Shrinkage Position.
end
end
end
% Now, we have (j=n)
% mBuff has been modified/steganographed.
%
% Returning modified buffer
% and shrinkage indicator.
MBuff=mBuff;
MBuff_shk={MBuff,Shk,ShkPt};
%