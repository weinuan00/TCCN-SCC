function [C0_t,C1_t,P0_t,P1_t,llr_v,spaceP0,spaceP1,spaceC0,spaceC1] = set_reuptate_PC(N,frozen,seg_position,seg,llr_v,free1,spaceP0,spaceP1,spaceC0,spaceC1,epj,j3,corrected_code)
n = log2(N);
segment=free1(seg_position);
if seg>0
    jishu_free=seg_position(seg);
    tiaojie=seg_position(seg);
    fliplocation=find(epj==1)+seg_position(seg);
    qishi=segment(seg);
    P0_t=spaceP0{1,seg+1}(:,:,j3);
    P1_t=spaceP1{1,seg+1}(:,:,j3);
    C0_t=spaceC0{1,seg+1}(:,:,j3);
    C1_t=spaceC1{1,seg+1}(:,:,j3);
elseif seg==0
    jishu_free=0;
    tiaojie=0;
    fliplocation=find(epj==1);
    qishi=0;
    P0_t=spaceP0{1,seg+1}(:,:,1);
    P1_t=spaceP1{1,seg+1}(:,:,1);
    C0_t=spaceC0{1,seg+1}(:,:,1);
    C1_t=spaceC1{1,seg+1}(:,:,1);
end
    for phi=qishi:segment(seg+1)-1 
    
        [P0_t,P1_t] = reP(P0_t,P1_t,C0_t,n,phi,n);   %递归调用reP计算判决每一位所需要的似然概率
        if any(frozen==(phi+1))  %判决
            if mod(phi,2)==0
                C0_t(n+1,1) = 0;
            else
                C1_t(n+1,1) = 0;
            end
        else
            
            jishu_free=jishu_free+1;
            llr_value=log(P0_t(n+1,1)/P1_t(n+1,1));
            llr_v(jishu_free)=llr_value;
            calculate=P1_t(n+1,1)>P0_t(n+1,1);
            if corrected_code(jishu_free-tiaojie)~=calculate
                temp=P0_t(n+1,1);
                P0_t(n+1,1)=P1_t(n+1,1);
                P1_t(n+1,1)=temp;
            end
            
            if (P0_t(n+1,1)>P1_t(n+1,1))
                if mod(phi,2)==0
                    C0_t(n+1,1) = 0;
                else 
                    C1_t(n+1,1) = 0;
                end
            elseif (P0_t(n+1,1)<=P1_t(n+1,1))
                if mod(phi,2)==0
                    C0_t(n+1,1) = 1;
                else 
                    C1_t(n+1,1) = 1;
                end
            end
            
%             if corrected_code(jishu_free-tiaojie)~=calculate
%                 temp=P0_t(n+1,1);
%                 P0_t(n+1,1)=P1_t(n+1,1);
%                 P1_t(n+1,1)=temp;
%             end
            
        end
   
        if(mod(phi,2)==1)
            [C0_t,C1_t] = reC(n,phi,C0_t,C1_t,n);  %更新码字矩阵
        end
    end
%     P0(:,:,j3)=P0_t;
%     P1(:,:,j3)=P1_t;
%     C0(:,:,j3)=C0_t;
%     C1(:,:,j3)=C1_t;
if seg<3
    spaceP0{1,seg+2}(:,:,j3)=P0_t;
    spaceP1{1,seg+2}(:,:,j3)=P1_t;
    spaceC0{1,seg+2}(:,:,j3)=C0_t;
    spaceC1{1,seg+2}(:,:,j3)=C1_t;
end