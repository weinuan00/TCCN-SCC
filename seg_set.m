function [pass_num,C0,C1,P0,P1,activePath,inactivePathIndices,U_seq,jiaozhengzi,soft_in,soft_pm,llr_v]=seg_set(N,L,free1,frozen1,Umatrix,seg,crc,C0,C1,P0,P1,seg_position,sourc,Pro,SNR,soft_in,soft_pm,llr_v,err_p,err_p2,err_p3,spaceP0,spaceP1,spaceC0,spaceC1,space_act)

pass_num=L;
fflag=[];
U_free=Umatrix(:,free1);
jiaozhengzi=cell(4,1);
for path=1:L
    [fff,jiaozhengzi_L]=seg_CRC_decoder(U_free(path,:),seg,crc);%不同与整体CRC纠错，此处的校正子是按照原顺序，非概率顺序
    fflag=[fflag,fff];
    pass_num=pass_num-fff;
    jiaozhengzi{path,:}=jiaozhengzi_L;
end
%%%%%%%%%%%%%%%纠错
if pass_num==0
    if seg==1
%         %%%%%%%测试性能用
        err_w1=zeros(L,size(err_p,2));
        pp1=zeros(L,1);
        pp2=zeros(L,1);
        for ii3=1:L
            err_w1(ii3,:)=(sourc(1:seg_position(1))~=Umatrix(ii3,free1(1:seg_position(1))));
            [w1,p1]=ismember(err_w1(ii3,:),err_p,'rows');
            pp1(ii3)=w1;
            pp2(ii3)=p1;
        end
        if (pp1(1))||(pp1(2))||(pp1(3))||(pp1(4))
            for path8=1:L
                abil=1;
            end
        end
        %%%%%%%%%%%%%%% 神经网络计算每条路径的最佳匹配错误图样
        load('net_seg1_snr15.mat');
        predclass=zeros(4,1);
        predpro=zeros(4,size(err_p,1));
        for jj1=1:L
            sss=soft_in(:,1:seg_position(1));
            lll=llr_v(:,1:seg_position(1));
            temp11=sss(jj1,:);
            temp22=lll(jj1,:);
            sss(jj1,:)=sss(1,:);
            lll(jj1,:)=lll(1,:);
            sss(1,:)=temp11;
            lll(1,:)=temp22;
            synd=jiaozhengzi{jj1,:};
            nn_data=[abs(lll);sss;synd,zeros(1,size(err_p,2)-4)];
            [testPred1,POSTERIOR1] = classify(net_seg1_30,nn_data);
            predclass(jj1)=testPred1;
            predpro(jj1,:)=POSTERIOR1;
        end
        corrcode_p1=zeros(L,size(err_p,2));
        epj=zeros(L,size(err_p,2));
        for j3=1:L
            %epj=err_p(predclass(j3),:);
            epj(j3,:)=err_p(predclass(j3),:);
            corrcode_p1(j3,:)=xor(Umatrix(j3,free1(1:seg_position(1))),epj(j3,:));  
            Umatrix(j3,free1(1:seg_position(1)))=corrcode_p1(j3,:);
        end
        [C0,C1,P0,P1,llr_v,spaceP0,spaceP1,spaceC0,spaceC1] = set_reuptate_PC_L(N,frozen1,seg_position,seg-1,llr_v,soft_in,free1,spaceP0,spaceP1,spaceC0,spaceC1,epj,corrcode_p1,space_act,Umatrix);
        pass_num=L;
        fflag=[0 0 0 0];
    elseif (seg==2)
        %%%%%%%测试性能用
        err_w1=zeros(L,size(err_p2,2));
        pp1=zeros(L,1);
        pp2=zeros(L,1);
        for ii3=1:L
            err_w1(ii3,:)=(sourc(seg_position(1)+1:seg_position(2))~=Umatrix(ii3,free1(seg_position(1)+1:seg_position(2))));
            [w1,p1]=ismember(err_w1(ii3,:),err_p2,'rows');
            pp1(ii3)=w1;
            pp2(ii3)=p1;
        end
        if (pp1(1))||(pp1(2))||(pp1(3))||(pp1(4))
            for path8=1:L
                abil=1;
            end
        end
    
        %%%%%%%%%%%%%%% 
        load('net_seg2_snr15.mat');
        predclass=zeros(L,1);
        predpro=zeros(L,size(err_p2,1));
        for jj1=1:L
            sss=soft_in(:,seg_position(1)+1:seg_position(2));
            lll=llr_v(:,seg_position(1)+1:seg_position(2));
            temp11=sss(jj1,:);
            temp22=lll(jj1,:);
            sss(jj1,:)=sss(1,:);
            lll(jj1,:)=lll(1,:);
            sss(1,:)=temp11;
            lll(1,:)=temp22;
            synd=jiaozhengzi{jj1,:};
            nn_data=[abs(lll);sss;synd,zeros(1,size(err_p2,2)-4)];
            [testPred1,POSTERIOR1] = classify(net_seg2,nn_data);
            predclass(jj1)=testPred1;
            predpro(jj1,:)=POSTERIOR1;
        end
        corrcode_p1=zeros(L,size(err_p2,2));
        epj=zeros(L,size(err_p2,2));
        for j3=1:L
            epj(j3,:)=err_p2(predclass(j3),:);
            corrcode_p1(j3,:)=xor(Umatrix(j3,free1(seg_position(1)+1:seg_position(2))),epj(j3,:));  
            Umatrix(j3,free1(seg_position(1)+1:seg_position(2)))=corrcode_p1(j3,:);
        end
        [C0,C1,P0,P1,llr_v,spaceP0,spaceP1,spaceC0,spaceC1] = set_reuptate_PC_L(N,frozen1,seg_position,seg-1,llr_v,soft_in,free1,spaceP0,spaceP1,spaceC0,spaceC1,epj,corrcode_p1,space_act,Umatrix);
        pass_num=L;
        fflag=[0 0 0 0];
%         elseif (seg==3)
%     %%%%%%%测试性能用
%         err_w1=zeros(L,size(err_p3,2));
%         pp1=zeros(L,1);
%         pp2=zeros(L,1);
%         for ii3=1:L
%             err_w1(ii3,:)=(sourc(seg_position(2)+1:seg_position(3))~=Umatrix(ii3,free1(seg_position(2)+1:seg_position(3))));
%             [w1,p1]=ismember(err_w1(ii3,:),err_p3,'rows');
%             pp1(ii3)=w1;
%             pp2(ii3)=p1;
%         end
%         if (pp1(1))||(pp1(2))||(pp1(3))||(pp1(4))
%             for path8=1:L
%                 abil=1;
%             end
%         end
%     %%%%%%%%%%%%%%% 
%         load('net_seg3_ep30.mat');
%         predclass=zeros(L,1);
%         predpro=zeros(L,size(err_p3,1));
%         for jj1=1:L
%             sss=soft_in(:,seg_position(2)+1:seg_position(3));
%             lll=llr_v(:,seg_position(2)+1:seg_position(3));
%             temp11=sss(jj1,:);
%             temp22=lll(jj1,:);
%             sss(jj1,:)=sss(1,:);
%             lll(jj1,:)=lll(1,:);
%             sss(1,:)=temp11;
%             lll(1,:)=temp22;
%             synd=jiaozhengzi{jj1,:};
%             nn_data=[abs(lll);sss;synd,zeros(1,size(err_p3,2)-4)];
%             [testPred1,POSTERIOR1] = classify(net_seg3_30,nn_data);
%             predclass(jj1)=testPred1;
%             predpro(jj1,:)=POSTERIOR1;
%         end
%         corrcode_p1=zeros(L,26);
%         for j3=1:L
%             epj=err_p3(predclass(j3),:);
%             corrcode_p1(j3,:)=xor(Umatrix(j3,free1(seg_position(2)+1:seg_position(3))),epj); 
%             [C0_t,C1_t,P0_t,P1_t,llr_v,spaceP0,spaceP1,spaceC0,spaceC1] = set_reuptate_PC(N,frozen1,seg_position,seg-1,llr_v,free1,spaceP0,spaceP1,spaceC0,spaceC1,epj,j3,corrcode_p1(j3,:));
%             C0(:,:,j3)=C0_t;
%             C1(:,:,j3)=C1_t;
%             P0(:,:,j3)=P0_t;
%             P1(:,:,j3)=P1_t;
%             Umatrix(j3,free1(seg_position(2)+1:seg_position(3)))=corrcode_p1(j3,:);
%         end
%         pass_num=L;
%         fflag=[0 0 0 0];
%         
    end
end

      U_seq=zeros(L,N);
      [~,l_prob3]=sort(Pro,'descend');
      if (pass_num~=0)&&(pass_num~=1)
          inde=1;
          for iii=1:L
              if fflag(iii)==0
                  P0(:,:,inde)=P0(:,:, iii);
                  P1(:,:,inde)=P1(:,:, iii);
                  C0(:,:,inde)=C0(:,:, iii);
                  C1(:,:,inde)=C1(:,:, iii);
                  inde=inde+1;
              else
                  continue;
              end
          end
          inde=1;
          for i2=1:L
              if fflag(i2)==0
                  U_seq(inde,:)=Umatrix(i2,:);
                  inde=inde+1;
              else 
                  continue;
              end
          end
          if pass_num==3
               fail_pass=find(fflag==1);
               if fail_pass>l_prob3(1)
                   l_prob_max=l_prob3(1);
               elseif fail_pass<l_prob3(1)
                   l_prob_max=l_prob3(1)-1;
               elseif fail_pass==l_prob3(1)
                   l_prob_max=l_prob3(2);   
               end
               P0(:,:,L)=P0(:,:, l_prob_max);
               P1(:,:,L)=P1(:,:, l_prob_max);
               C0(:,:,L)=C0(:,:, l_prob_max);
               C1(:,:,L)=C1(:,:, l_prob_max);
               U_seq(L,:)=U_seq(l_prob_max,:);
          elseif pass_num==2
               P0(:,:,3)=P0(:,:, 1);
               P1(:,:,3)=P1(:,:, 1);
               C0(:,:,3)=C0(:,:, 1);
               C1(:,:,3)=C1(:,:, 1);
               U_seq(3,:)=U_seq(1,:);
               P0(:,:,4)=P0(:,:,2);
               P1(:,:,4)=P1(:,:, 2);
               C0(:,:,4)=C0(:,:, 2);
               C1(:,:,4)=C1(:,:, 2);
               U_seq(4,:)=U_seq(2,:);
          end
      end
      if pass_num==1
          pass_path=find(fflag==0);
          P0_temp(:,:)=P0(:,:, pass_path);
          P1_temp(:,:)=P1(:,:, pass_path);
          C0_temp(:,:)=C0(:,:, pass_path);
          C1_temp(:,:)=C1(:,:, pass_path);
          soft_temp=soft_in(pass_path,:);
          for iii2=1:L
              P0(:,:,iii2)=P0_temp(:,:);
              P1(:,:,iii2)=P1_temp(:,:);
              C0(:,:,iii2)=C0_temp(:,:);
              C1(:,:,iii2)=C1_temp(:,:);
              U_seq(iii2,:)=Umatrix(pass_path,:);
              soft_in(iii2,:)=soft_temp;
          end
        
      end

if pass_num==3
    activePath=[1 1 1 0];
    inactivePathIndices=[3];
elseif pass_num==2
    activePath=[1 1 0 0];
    inactivePathIndices=[3,2];
elseif (pass_num==1)
    activePath=[1 0 0 0];
    inactivePathIndices=[3,2,1];
elseif ((pass_num==4)||(pass_num==0))
    activePath=[1 1 1 1];
    inactivePathIndices=[];
    U_seq=Umatrix;
end

    
    
     