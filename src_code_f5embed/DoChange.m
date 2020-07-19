function NewBuff=DoChange(Buff,S)
% (S) points to the bit location that must be changed
% Treatement Only in case of (S>0), If (S=0) there is NO changment.
if (S>0)
if (Buff(S)> 0) % Positive qDCT Value.
Buff(S)= Buff(S)-1;
elseif (Buff(S)< 0) % Negative qDCT Value.
Buff(S) = (-1)*(abs(Buff(S))-1);
end
end
NewBuff=Buff;
%