function Cap=MediCap(mat)
% mat : Y component matrix.
siz=size(mat);
Rw=siz(1); % rows : Height.
Cl=siz(2); % columms : Width.
% Calculating the number of
% Nonzero coefficients.
cout=0;
for xx=1:Rw
for yy=1:Cl
if (mat(xx,yy)~=0)
cout=cout+1;
end
end
end
Cap=cout;
%