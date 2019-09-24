function [ P0,P1 ] = reP_list( P0,P1,C0,lamda,phi,n,activePath )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if (lamda==0)
   return;
end
psi = floor(phi/2);
if mod(phi,2)==0
   [ P0,P1 ] = reP_list( P0,P1,C0,lamda-1,psi,n,activePath);    %递归调用
end
L = length(activePath);          
Max = 0;
for path=0:(L-1)                   %对所有幸存路径开始计算
   if (activePath(path+1)==0)
      continue;                    %结束本次循环
   end                             %找到当前的激活路径进行计算
   P_0 = P0(:,:,path+1);   
   P_1 = P1(:,:,path+1);
   for beta = 0:(2^(n-lamda)-1)
    index1 = 2^lamda*beta;
    index2 = 2^(lamda-1)*2*beta;
    index3 = 2^(lamda-1)*(2*beta+1);
    if mod(phi,2)==0                               %根据奇偶采用不同公式计算
       P_0(lamda+1,index1+1) = 0.5*P_0(lamda,index2+1)*P_0(lamda,index3+1)+0.5*P_1(lamda,index2+1)*P_1(lamda,index3+1);
       P_1(lamda+1,index1+1) = 0.5*P_1(lamda,index2+1)*P_0(lamda,index3+1)+0.5*P_0(lamda,index2+1)*P_1(lamda,index3+1);
       Max = max(P_1(lamda+1,index1+1),max(Max,P_0(lamda+1,index1+1)));
    else
      index4 = 2^lamda*beta;
      C_0 = C0(:,:,path+1); 
      if C_0(lamda+1,index4+1)==0
         P_0(lamda+1,index1+1) = 0.5*P_0(lamda,index2+1)*P_0(lamda,index3+1);
         P_1(lamda+1,index1+1) = 0.5*P_1(lamda,index2+1)*P_1(lamda,index3+1);
         Max = max(P_1(lamda+1,index1+1),max(Max,P_0(lamda+1,index1+1)));
      else
         P_0(lamda+1,index1+1) = 0.5*P_1(lamda,index2+1)*P_0(lamda,index3+1);   
         P_1(lamda+1,index1+1) = 0.5*P_0(lamda,index2+1)*P_1(lamda,index3+1);
         Max = max(P_1(lamda+1,index1+1),max(Max,P_0(lamda+1,index1+1)));
      end
    end
   end
         P0(:,:,path+1) = P_0;
         P1(:,:,path+1) = P_1;
end
for path=0:(L-1)
   if (activePath(path+1)==0)
      continue;
   end
   P_0 = P0(:,:,path+1);   
   P_1 = P1(:,:,path+1);
   P_0(lamda+1,:) = P_0(lamda+1,:)./Max;   %%为防止数据下溢，进行归一化计算
   P_1(lamda+1,:) = P_1(lamda+1,:)./Max;
   P0(:,:,path+1) = P_0;                     
   P1(:,:,path+1) = P_1;
end
   clear P_0;
   clear P_1;
   
   
   
      
   
   



