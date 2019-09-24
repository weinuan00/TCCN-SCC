function [ U,metric,C0,C1,P0,P1,A_C,soft_in,soft_pm,llr_v,spaceP0,spaceP1,spaceC0,spaceC1,space_act] = SCL_decoder( y,sigma,frozen,L,seg1,soft_in,free1,source1,soft_pm,llr_v,seg_num )
N = length(y);
n = log2(N);
U = zeros(L,N);
Code = zeros(L,N);
metric = zeros(1,L); %��·������
%%Set data structure
C0 = zeros(n+1,N,L);
C1 = zeros(n+1,N,L);
P0 = zeros(n+1,N,L);   %%%L��n+1*N�ľ���ÿ���������ڴ��ÿ���ڵ��Ϊ0����
P1 = zeros(n+1,N,L);
spaceP0=cell(1,seg_num);
spaceP1=cell(1,seg_num);
spaceC0=cell(1,seg_num);
spaceC1=cell(1,seg_num);
space_act=zeros(seg_num,4);
jishu_free=0;
%% initialpath
inactivePathIndices = [];
activePath = zeros(1,L); %%��ʶ����
for path=0:L-1
   inactivePathIndices = [inactivePathIndices,L-1-path];
end                                  %%%���Ϊ[L-1 L-2 L-3��1 0]
%%
path_index = inactivePathIndices(end); %����һ��·��   (��ֵ�������������һ��Ԫ��0��
inactivePathIndices(end) = [];         %%%�������������һ��Ԫ����Ϊ�գ�ȥ����             
activePath(path_index+1) = 1;          %���±�ʶ������ԭ����L��ȫ0��������0+1��Ԫ�ظ�ֵΪ1��
P_0 = P0(:,:,path_index+1);
P_1 = P1(:,:,path_index+1);
for i=1:N                  %��ʼ����Ȼ��Ϣ
   P_0(1,i) = (1/(sqrt(2*pi)*sigma))*exp((-1*((y(i)+1)^2))/(2*sigma^2));
   P_1(1,i) = (1/(sqrt(2*pi)*sigma))*exp((-1*((y(i)-1)^2))/(2*sigma^2));
end
P0(:,:,path_index+1) = P_0;     %%%�Ӷ�path_indexһ����L��ȡֵ��{��ӦP0 P1��n+1,N,L),��L��n+1*N�ľ���}ÿ���������ڴ��ÿ���ڵ��Ϊ0���ʣ�Ϊ1���ʣ�
P1(:,:,path_index+1) = P_1;
clear P_0;
clear P_1;

spaceP0{1,1}=P0;
spaceP1{1,1}=P1;
spaceC0{1,1}=C0;
spaceC1{1,1}=C1;
space_act(1,:)=activePath;
%% ���䶳��λ
A_C = zeros(1,N);
for i=1:N
   if any(i==frozen)
      A_C(i) = 1;     %%%��Ϊ�����ŵ������ŵ����Ϊ1
   end
end
%%     
for phi=0:seg1-1        %%�ݹ�������
   
%     if phi==free1(8);
%         for path8=1:L
%             err_w=find(source1(1:22)~=U(path8,free1(1:22)));
%             if isequal([15],err_w)
%                 eeee=2;
%             end
%         end
%     end
%     
%     if phi==free1(15);
%         ffff=1;
%     end
%     
    [P0,P1] = reP_list(P0,P1,C0,n,phi,n,activePath);   %����reP_list
   if (A_C(phi+1)==1)                %����Ƕ���λ
      for path=0:L-1  %��ѯÿһ��·��
         if (activePath(path+1)==0)
            continue;
         end             %%%if continue������ֹ���ε�forѭ��
         %% SetDataStructure_C(phi,path_index,0);  
         if mod(phi,2)==0                 %���±�����Ϣ
            C_0 = C0(:,:,path+1);
            C_0(n+1,1) = 0;
            C0(:,:,path+1) = C_0;
            clear C_0;
         else
            C_1 = C1(:,:,path+1);
            C_1(n+1,1) = 0;
            C1(:,:,path+1) = C_1;
            clear C_1;
         end
         U(path+1,phi+1) = 0;   
         %%
      end
   else                             %%������Ƕ���λ
       jishu_free=jishu_free+1;
      [C0,C1,P0,P1,activePath,inactivePathIndices,inactivePathIndicesForC,contForks,U] = Path_cloned_Killed(C0,C1,P0,P1,phi,n,activePath,inactivePathIndices,U);  %����Path_cloned_Killed
      
%       if free1(18)-1==phi
% %           temp=P0(n+1,1);
% %           P0(n+1,1)=P1(n+1,1);
% %           P1(n+1,1)=temp;
%           %err1=find(source1(1:21)~=s(free1(1:21))) ;
%           ttt=1;
%       end
      
      for path=0:(L-1)    %��ѯÿһ��·��
         if (activePath(path+1)==0)
            continue;
         end
         llr_value=log(P0(n+1,1,path+1)/P1(n+1,1,path+1));
         llr_v(path+1,jishu_free)=llr_value;
         if (contForks(path+1,1)==0&&contForks(path+1,2)==0)
            continue;
         elseif (contForks(path+1,1)==0&&contForks(path+1,2)==1)  
            %%     SetDataStructure_C(phi,path_index,1)
            if mod(phi,2)==0                 %���±�����Ϣ
               C_0 = C0(:,:,path+1);
               C_0(n+1,1) = 1;
               C0(:,:,path+1) = C_0;
            else
               C_1 = C1(:,:,path+1);
               C_1(n+1,1) = 1;
               C1(:,:,path+1) = C_1;
            end
            U(path+1,phi+1) = 1;
            soft_in(path+1,jishu_free)=P1(n+1,1,path+1);
            if llr_value >0
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=abs(llr_value);
                else 
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1)+abs(llr_value);
                end
            else
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=0;
                else 
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1);
                end
            end
            %%
         elseif (contForks(path+1,1)==1&&contForks(path+1,2)==0)
            %% SetDataStructure_C(phi,path_index,0);
            if mod(phi,2)==0              %���±�����Ϣ
               C_0 = C0(:,:,path+1);
               C_0(n+1,1) = 0;
               C0(:,:,path+1) = C_0;
            else
               C_1 = C1(:,:,path+1);
               C_1(n+1,1) = 0;
               C1(:,:,path+1) = C_1;
            end
            U(path+1,phi+1) = 0; 
            soft_in(path+1,jishu_free)=P0(n+1,1,path+1);
            if llr_value >0
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=0;
                else 
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1);
                end
            else
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=abs(llr_value);
                else
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1)+abs(llr_value);
                end
            end
            %%           
         elseif (contForks(path+1,1)==1&&contForks(path+1,2)==1)
            clone_index = inactivePathIndicesForC(end);           %��¡·�������±�����Ϣ
            inactivePathIndicesForC(end) = [];
            initial_index = path;
            activePath(clone_index+1) = 1;
           %% SetDataStructure_C(phi,initial_index,0);
           if mod(phi,2)==0
               C_0 = C0(:,:,initial_index+1);
               C_0(n+1,1) = 0;
               C0(:,:,initial_index+1) = C_0;
            else
               C_1 = C1(:,:,initial_index+1);
               C_1(n+1,1) = 0;
               C1(:,:,initial_index+1) = C_1;
            end
            U(initial_index+1,phi+1) = 0;
            soft_in(path+1,jishu_free)=P0(n+1,1,path+1);
            if llr_value >0
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=0;
                else 
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1);
                end
            else
                if jishu_free==1
                    soft_pm(path+1,jishu_free)=abs(llr_value);
                else
                    soft_pm(path+1,jishu_free)=soft_pm(path+1,jishu_free-1)+abs(llr_value);
                end
            end
          %%
          %% SetDataStructure_C(phi,cloned_index,1);
            if mod(phi,2)==0                  %Ϊ��¡·����ֵ
               C_0 = C0(:,:,clone_index+1);
               C_0(n+1,1) = 1;
               C0(:,:,clone_index+1) = C_0;
            else
               C_1 = C1(:,:,clone_index+1);
               C_1(n+1,1) = 1;
               C1(:,:,clone_index+1) = C_1;
            end
            U(clone_index+1,phi+1) = 1;
            soft_in(clone_index+1,:)=soft_in(path+1,:);
            soft_in(clone_index+1,jishu_free)=P1(n+1,1,path+1);
            soft_pm(clone_index+1,:)=soft_pm(path+1,:);
            llr_v(clone_index+1,:)=llr_v(path+1,:);
            if llr_value >0
                if jishu_free==1
                    soft_pm(clone_index+1,jishu_free)=abs(llr_value);
                else 
                    soft_pm(clone_index+1,jishu_free)=soft_pm(path+1,jishu_free-1)+abs(llr_value);
                end
            else
                if jishu_free==1
                    soft_pm(clone_index+1,jishu_free)=0;
                else 
                    soft_pm(clone_index+1,jishu_free)=soft_pm(path+1,jishu_free-1);
                end
            end
          %%
         end
      end 
   end
         if (mod(phi,2)==1)
            [C0,C1] = reC_list(n,phi,C0,C1,n,activePath);
         end

end
for path=0:(L-1)                    %Ϊ�Ҵ�·�����������Լ�·����Ȼ����ֵ
   if (activePath(path+1)==0)
       continue;
   end
   Code(path+1,:) = C0(1,:,path+1);
   
   if C1(n+1,1,path+1) == 0
      metric(path+1) = P0(n+1,1,path+1);
   elseif C1(n+1,1,path+1) == 1
      metric(path+1) = P1(n+1,1,path+1);
   end
end

% spaceP0{1,2}=P0;
% spaceP1{1,2}=P1;
% spaceC0{1,2}=C0;
% spaceC1{1,2}=C1;      




          
          
         
      
         
         
         
         
         
         
         
   
   




