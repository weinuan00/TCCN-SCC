function [ P0,P1 ] = reP( P0,P1,C0,lamda,phi,n )
%由于是space-efficient版本，只需存取C0中的码字信息，无需访问C1
%在每一次调用reP结束后，注意必须进行概率归一化，因为似然概率值的大小随码长增加以2的幂次速度减小，不归一化概率会下溢变成NaN，无法计算
if lamda==0   %当层数变为0时开始回溯
   return
end
psi = floor(phi/2); %层数不为0就继续调用reP
if mod(phi,2)==0
   [ P0,P1 ] = reP( P0,P1,C0,lamda-1,psi,n); 
end
 Max = 0;    %预设变量Max存储当前层最大值，以供归一化使用
for beta = 0:(2^(n-lamda)-1)
    index1 = 2^lamda*beta;            %根据层数和子树分支计算要访问的位置
    index2 = 2^(lamda-1)*2*beta;
    index3 = 2^(lamda-1)*(2*beta+1);
   if mod(phi,2)==0            %计算公式和phi的奇偶有关
      P0(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P0(lamda,index3+1)+0.5*P1(lamda,index2+1)*P1(lamda,index3+1);  %matlab不支持0索引，要加1
      P1(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P0(lamda,index3+1)+0.5*P0(lamda,index2+1)*P1(lamda,index3+1);
       Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1))); %更新最大值
   else
      index4 = 2^lamda*beta;
      if C0(lamda+1,index4+1)==0
         P0(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P0(lamda,index3+1);
         P1(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P1(lamda,index3+1);
          Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1)));  %更新最大值
      else
         P0(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P0(lamda,index3+1);   
         P1(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P1(lamda,index3+1);
          Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1)));  %更新最大值
      end
   end
end
 P0(lamda+1,:) = P0(lamda+1,:)./Max;  %归一化并存储当前层计算结果
 P1(lamda+1,:) = P1(lamda+1,:)./Max;
         
  



