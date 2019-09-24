function [C0,C1,P0,P1,llr_v,spaceP0,spaceP1,spaceC0,spaceC1] = set_reuptate_PC_L(N,frozen,seg_position,seg,llr_v,soft_in,free1,spaceP0,spaceP1,spaceC0,spaceC1,epj,corrected_code,space_act,Umat)
n = log2(N);
segment=free1(seg_position);
L=4;
U=zeros(L,N);
start_ornot=0;
path_condition=zeros(L,L);
path_corr1=zeros(4,1);
if seg>0
    jishu_free=seg_position(seg);
    tiaojie=seg_position(seg);
    qishi=segment(seg);
    P0=spaceP0{1,seg+1};
    P1=spaceP1{1,seg+1};
    C0=spaceC0{1,seg+1};
    C1=spaceC1{1,seg+1};
    activePath=space_act(seg+1,:);
    U(:,1:free1(seg_position(seg)))=Umat(:,1:free1(seg_position(seg)));
elseif seg==0
    jishu_free=0;
    tiaojie=0;
    qishi=0;
    P0=spaceP0{1,seg+1};
    P1=spaceP1{1,seg+1};
    C0=spaceC0{1,seg+1};
    C1=spaceC1{1,seg+1};
    activePath=space_act(seg+1,:);
end
fliplocation=find(epj==1);
start_point=ceil(fliplocation(1)/4)+tiaojie;
    
if length(find(activePath==0))==1
    inactivePathIndices=[3];
elseif length(find(activePath==0))==2
    inactivePathIndices=[3,2];
elseif length(find(activePath==0))==3
    inactivePathIndices=[3,2,1];
elseif isempty(find(activePath==0, 1))
    inactivePathIndices=[];
end
    for phi=qishi:segment(seg+1)-1 
    
        [P0,P1] = reP_list(P0,P1,C0,n,phi,n,activePath);   %递归调用reP计算判决每一位所需要的似然概率
        if any(frozen==(phi+1))  %判决
            for path=0:L-1  %轮询每一条路径
                if (activePath(path+1)==0)
                    continue;
                end      
                if mod(phi,2)==0                 
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
            end
        else
            set_conforks=2*ones(L,2);
            jishu_free=jishu_free+1;
            if jishu_free>=start_point
               start_ornot=1; 
               for ii2=1:L   %译码进行到start_point处再执行
                   ppp=ismember(corrected_code(:,1:jishu_free-1-tiaojie),U(ii2,free1(tiaojie+1:jishu_free-1)),'rows');
                   path_condition(ii2,:)=ppp';
                   path_corr1(ii2)=max(ppp);
               end
               if sum(sum(path_condition))==4
                   for ii3=1:L
                       if path_corr1(ii3)==0
                          continue;
                       else
                          check_path=find(path_condition(ii3,:)==1) ;
                          for ii4=1:length(check_path)
                              set_value=corrected_code(check_path(ii4),jishu_free-tiaojie);
                              set_conforks(ii3,set_value+1)=1;
                          end
                       end
                   end
               else
                   fffff=1;
               end
               
            end
           
            [C0,C1,P0,P1,activePath,inactivePathIndices,inactivePathIndicesForC,contForks,U] = Copy_of_Path_cloned_Killed(C0,C1,P0,P1,phi,n,activePath,inactivePathIndices,U,start_ornot,set_conforks); 
            for path=0:(L-1)    %轮询每一条路径
                if (activePath(path+1)==0)
                    continue;
                end
                llr_value=log(P0(n+1,1,path+1)/P1(n+1,1,path+1));
                llr_v(path+1,jishu_free)=llr_value;
%                 calculate=P1_t(n+1,1)>P0_t(n+1,1);
%                 if corrected_code(jishu_free-tiaojie)~=calculate
%                     temp=P0_t(n+1,1);
%                     P0_t(n+1,1)=P1_t(n+1,1);
%                     P1_t(n+1,1)=temp;
%                 end
            
                if (contForks(path+1,1)==0&&contForks(path+1,2)==0)
                    continue;
                elseif (contForks(path+1,1)==0&&contForks(path+1,2)==1)  
                    if mod(phi,2)==0                 %更新比特信息
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
                    
                elseif (contForks(path+1,1)==1&&contForks(path+1,2)==0)
                    if mod(phi,2)==0              %更新比特信息
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
                     
                 elseif (contForks(path+1,1)==1&&contForks(path+1,2)==1)
                    clone_index = inactivePathIndicesForC(end);           %克隆路径，更新比特信息
                    inactivePathIndicesForC(end) = [];
                    initial_index = path;
                    activePath(clone_index+1) = 1;
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
                  %%% SetDataStructure_C(phi,cloned_index,1);
                    if mod(phi,2)==0                  %为克隆路径赋值
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
                    llr_v(clone_index+1,:)=llr_v(path+1,:);
                 end
            end
        end
   
        if(mod(phi,2)==1)
            [C0,C1] = reC_list(n,phi,C0,C1,n,activePath);
        end
    end
    for path=0:(L-1)                    %为幸存路径分配码字以及路径似然概率值
       if (activePath(path+1)==0)
           continue;
       end
    %   Code(path+1,:) = C0(1,:,path+1);
        metric = zeros(1,L);
       if C1(n+1,1,path+1) == 0
          metric(path+1) = P0(n+1,1,path+1);
       elseif C1(n+1,1,path+1) == 1
          metric(path+1) = P1(n+1,1,path+1);
       end
    end

% if seg<3
%     spaceP0{1,seg+2}(:,:,j3)=P0;
%     spaceP1{1,seg+2}(:,:,j3)=P1;
%     spaceC0{1,seg+2}(:,:,j3)=C0;
%     spaceC1{1,seg+2}(:,:,j3)=C1;
% end