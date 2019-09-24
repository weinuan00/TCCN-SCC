function [ P0,P1 ] = reP( P0,P1,C0,lamda,phi,n )
%������space-efficient�汾��ֻ���ȡC0�е�������Ϣ���������C1
%��ÿһ�ε���reP������ע�������и��ʹ�һ������Ϊ��Ȼ����ֵ�Ĵ�С���볤������2���ݴ��ٶȼ�С������һ�����ʻ�������NaN���޷�����
if lamda==0   %��������Ϊ0ʱ��ʼ����
   return
end
psi = floor(phi/2); %������Ϊ0�ͼ�������reP
if mod(phi,2)==0
   [ P0,P1 ] = reP( P0,P1,C0,lamda-1,psi,n); 
end
 Max = 0;    %Ԥ�����Max�洢��ǰ�����ֵ���Թ���һ��ʹ��
for beta = 0:(2^(n-lamda)-1)
    index1 = 2^lamda*beta;            %���ݲ�����������֧����Ҫ���ʵ�λ��
    index2 = 2^(lamda-1)*2*beta;
    index3 = 2^(lamda-1)*(2*beta+1);
   if mod(phi,2)==0            %���㹫ʽ��phi����ż�й�
      P0(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P0(lamda,index3+1)+0.5*P1(lamda,index2+1)*P1(lamda,index3+1);  %matlab��֧��0������Ҫ��1
      P1(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P0(lamda,index3+1)+0.5*P0(lamda,index2+1)*P1(lamda,index3+1);
       Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1))); %�������ֵ
   else
      index4 = 2^lamda*beta;
      if C0(lamda+1,index4+1)==0
         P0(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P0(lamda,index3+1);
         P1(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P1(lamda,index3+1);
          Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1)));  %�������ֵ
      else
         P0(lamda+1,index1+1) = 0.5*P1(lamda,index2+1)*P0(lamda,index3+1);   
         P1(lamda+1,index1+1) = 0.5*P0(lamda,index2+1)*P1(lamda,index3+1);
          Max = max(P1(lamda+1,index1+1),max(Max,P0(lamda+1,index1+1)));  %�������ֵ
      end
   end
end
 P0(lamda+1,:) = P0(lamda+1,:)./Max;  %��һ�����洢��ǰ�������
 P1(lamda+1,:) = P1(lamda+1,:)./Max;
         
  



