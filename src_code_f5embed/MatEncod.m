function Encod=MatEncod(Embrate)
% Calculating the matrix encoding
Encod=[1 1 1];
k=0;
Diff=1;
while (Diff>0)
k=k+1;
R=100*(k /((2^k)-1));
Diff=R-Embrate;
end
k=k-1;
n=(2^k)-1;
Encod(2)=n;
Encod(3)=k;
%