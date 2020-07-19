function stegoBuff=DoStego(Buff,n,DesiredVal)
% Buff contains (n) qDCTs coefficients.
% DesiredVal is the desired value to be embedded.
% DesiredVal will be within [0,1,..,n].
%
% Calculating the current Hash value.
CurrentVal=F5Hash(Buff,n);
% XORing desired and current values
% in order to find bit location (S) to modify.
S= bitxor(DesiredVal,CurrentVal);
% Applying the (d=1) modification :
% changing the buffer by One change
NewBuff=DoChange(Buff,S);
% Calculating the New Hash value.
NewVal=F5Hash(NewBuff,n);
% Comparing between
% New and Desired values
% Returning the stego Buffer.
if (NewVal==DesiredVal) % Must be always true.
stegoBuff=NewBuff;
elseif (NewVal~=DesiredVal)
stegoBuff=0;
end
%