function [ C0,C1,P0,P1,activePath,inactivePathIndices,inactivePathIndicesForC,contForks,U] = Copy_of_Path_cloned_Killed( C0,C1,P0,P1,phi,n,activePath,inactivePathIndices,U,start_ornot,set_conforks)   %����������
%PATH_CLONED_KILLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
L = length(activePath);
probForks = zeros(L,2);
activepath_Number = 0;
contForks = zeros(L,2);
for path=0:(L-1)
   if (activePath(path+1)==0)             %δ����·��
      probForks(path+1,1) = -1;
      probForks(path+1,2) = -1;
   else                                   %����·��
      P_0 = P0(:,:,path+1);
      P_1 = P1(:,:,path+1);
      probForks(path+1,1) = P_0(n+1,1);
      probForks(path+1,2) = P_1(n+1,1);
      activepath_Number = activepath_Number + 1;  %%%���activePath���м���1����activePath_NumberֵΪ��
   end
end
if(2*activepath_Number<L)                      %�ж��Ƿ񳬹���ֵL
   rou = 2*activepath_Number;
else
   rou = L;
end
%% �����ҵ���������·��
probForks_temp = zeros(1,2*L);
probForks_temp0 = zeros(1,2*L);
probForks_temp1 = zeros(1,2*L);
for path=0:L-1
   probForks_temp(path+1) = probForks(path+1,1);
   probForks_temp(path+L+1) = probForks(path+1,2);
   probForks_temp0(path+1) = path;
   probForks_temp0(path+L+1) = path;
   probForks_temp1(path+1) = 0;
   probForks_temp1(path+L+1) = 1;
end
exchangeCount = 1;
while(exchangeCount~=0)
   exchangeCount = 0;
   for path=1:2*L-1
      if(probForks_temp(path+1)<=probForks_temp(path))
         continue;
      else
         temp = probForks_temp(path);   %% �����м�����Ա㽻��
         temp0 = probForks_temp0(path);
         temp1 = probForks_temp1(path);
         probForks_temp(path) = probForks_temp(path+1);
         probForks_temp0(path) = probForks_temp0(path+1);
         probForks_temp1(path) = probForks_temp1(path+1);
         probForks_temp(path+1) = temp;
         probForks_temp0(path+1) = temp0;
         probForks_temp1(path+1) = temp1;
         exchangeCount = exchangeCount + 1;
      end
   end
end
for path=0:(rou-1)
   contForks(probForks_temp0(path+1)+1,probForks_temp1(path+1)+1) = 1;
end
if start_ornot==1
    pp4=find(contForks==1);
    pp5=find(set_conforks==1);
    available_path=setdiff(pp4,pp5);
    fix_path=setdiff(pp5,pp4);
    %corrr4_path=intersect(pp4,pp5);
    for ii5=1:length(fix_path)
        contForks(fix_path(ii5))=1;
        contForks(available_path(ii5))=0;
    end
end

for path=0:(L-1)
   if (activePath(path+1)==0)          %δ����·��
      continue;
   end
   if ((contForks(path+1,1)==0)&&(contForks(path+1,2)==0))   %����֧��������·����չ����
      activePath(path+1) = 0;                                %��·����Ϊ�Ǽ���·��
      inactivePathIndices = [inactivePathIndices,path];      
   end
end
   inactivePathIndicesForC_temp = [];
   inactivePathIndicesForC = [];
   while (~isempty(inactivePathIndices))          %���е�����ѹ�����
      index = inactivePathIndices(end);
      inactivePathIndices(end) = [];
      inactivePathIndicesForC_temp = [inactivePathIndicesForC_temp,index];     
   end
   while (~isempty(inactivePathIndicesForC_temp))  %���е�����ѹ�����
      index = inactivePathIndicesForC_temp(end);
      inactivePathIndicesForC_temp(end) = [];
      inactivePathIndices = [inactivePathIndices,index];
      inactivePathIndicesForC = [inactivePathIndicesForC,index];
   end
   for path=0:(L-1)
      if (activePath(path+1)==0)
      continue;
      end
      if ((contForks(path+1,1)==1)&&(contForks(path+1,2)==1))  %·����չǰ�ġ���¡������
         clone_index = inactivePathIndices(end);
         inactivePathIndices(end) = [];
         initial_index = path;
         activePath(clone_index+1) = 1;
            P_0_initial = P0(:,:,initial_index+1);
            P_1_initial = P1(:,:,initial_index+1);
            P0(:,:,clone_index+1) = P_0_initial;
            P1(:,:,clone_index+1) = P_1_initial;
            C_0_initial = C0(:,:,initial_index+1);
            C_1_initial = C1(:,:,initial_index+1);
            C0(:,:,clone_index+1) = C_0_initial;
            C1(:,:,clone_index+1) = C_1_initial;
            U(clone_index+1,:) = U(initial_index+1,:);   
      end
   end
     
      
  
      
   
   
   
   
   
 
         
   
   

   











      
      
      
      
      



