function [ C0,C1 ] = reC_list( lamda,phi,C0,C1,m,activePath )
%REC_LIST 此处显示有关此函数的摘要
%   此处显示详细说明
psi = floor(phi/2);
L = length(activePath);
for path=0:(L-1)
   if (activePath(path+1)==0)
      continue;
   end
   C_0 = C0(:,:,path+1);
   C_1 = C1(:,:,path+1);
   for beta=0:2^(m-lamda)-1                 %对当前层进行计算，更新码字信息
      index1 = 2^(lamda-1)*2*beta;
      index2 = 2^(lamda-1)*(2*beta+1);
      index3 = 2^lamda*beta;
      if mod(psi,2)==0
      C_0(lamda,index1+1) = mod(C_0(lamda+1,index3+1)+C_1(lamda+1,index3+1),2);
      C_0(lamda,index2+1) = C_1(lamda+1,index3+1);
      else
      C_1(lamda,index1+1) = mod(C_0(lamda+1,index3+1)+C_1(lamda+1,index3+1),2);
      C_1(lamda,index2+1) = C_1(lamda+1,index3+1);
      end
   end
   C0(:,:,path+1) = C_0;
   C1(:,:,path+1) = C_1;
end
clear C_0;
clear C_1;
if mod(psi,2)==1
   [ C0,C1 ] = reC_list(lamda-1,psi,C0,C1,m,activePath);   %递归
end
      
      
   
   



