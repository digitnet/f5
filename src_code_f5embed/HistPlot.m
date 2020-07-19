function HH=HistPlot(Vec,Rang,MaxCH,MaxCnt)
HH=zeros(1,3);
siz=size(Vec);
[n,xout]=hist(Vec,-Rang:Rang);
ToTNb=sum(n);
HH(1)=ToTNb;
XNb=(2*Rang)+1;
HH(2)=n(1)+n(XNb);
%%%
n(1)=0;
n(XNb)=0;
if (ToTNb==siz(2) && MaxCH==1)
for i=1:XNb
if(xout(i)==0)
HH(3)=n(i);
n(i)=MaxCnt;
end
end
end
bar(xout,n);
%