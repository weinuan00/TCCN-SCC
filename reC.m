function [ C0,C1 ] = reC( lamda,phi,C0,C1,m )
%REC 此处显示有关此函数的摘要
%   此处显示详细说明
psi = floor(phi/2);
for beta=0:2^(m-lamda)-1
   index1 = 2^(lamda-1)*2*beta;
   index2 = 2^(lamda-1)*(2*beta+1);
   index3 = 2^lamda*beta; 
   if mod(psi,2)==0
      C0(lamda,index1+1) = mod(C0(lamda+1,index3+1)+C1(lamda+1,index3+1),2);
      C0(lamda,index2+1) = C1(lamda+1,index3+1);
   else
      C1(lamda,index1+1) = mod(C0(lamda+1,index3+1)+C1(lamda+1,index3+1),2);
      C1(lamda,index2+1) = C1(lamda+1,index3+1);
      
   end
end
   if mod(psi,2)==1
       [ C0,C1 ]=reC(lamda-1,psi,C0,C1,m);
   end




