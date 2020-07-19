function Hash = F5Hash(Buff,n)
% F5 algorithm Hash function
% Buff contains (n) qDCTs coefficients.
ABuff= abs(Buff); % (ai) Bits do not change.
B=ones(1,n);
a = bitand(ABuff,B); % Extracting (ai) Bits values.
%%%
indx=zeros(1,n);
for i=1:n
indx(i)=i;
end
%%%
idx=a.*indx; % Multiplying element by element.
%%%
hsh=idx(1);
for i=2:n
hsh= bitxor(hsh,idx(i));
end
Hash=hsh; % Resulting Hash Value.
%