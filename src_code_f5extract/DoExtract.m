function ExVal=DoExtract(mBuff,m,n)
%
nBuff=zeros(1,n);
j=0;
for i=1:m
if (mBuff(i)~=0) % Nonzero values.
j=j+1;
nBuff(j)=mBuff(i);
end
end
% Now, we have (j=n).
% Calculating the F5 Hash value.
ExVal=F5Hash(nBuff,n);
%