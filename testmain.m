clear all;
close all;
n = 8;
N = 2^n;
rate1 = 0.5;
K1 = floor(N*rate1);
framenumber = 100000000;
G = generate_G_flip(n);
L = 4;  %路径数
SNR = 1.5;
source1 = zeros(1,K1);
error1 = zeros(1,length(SNR));
crc=[1 0 0 1 1];
err_frame=zeros(1,length(SNR));
   
for i=1:length(SNR)
   en = 10^(SNR(i)/10);
   sigma1 = 1/sqrt(2*rate1*en); 
   [~,B] = GA(sigma1,n);
   frozen1 = sort(B(1:N-K1));
   free1 = sort(setdiff([1:N],frozen1));
   seg_num=4;
   seg_position=[19,44,81,128];
   ind_position=[1:15,20:40,45:77,82:124]; 
   segment=free1(seg_position);
   
   sumsum=0;
   load('t1_s15.mat');
   err_pp=err_p_1(1:30,:);
   load('t2_s15.mat');
   err_pp2=err_p_2(1:30,:);
   load('t3_s15.mat');
   err_pp3=err_p_3(1:30,:);
   canshu=37;
   Table_err=zeros(800,1);
   Table_patt=zeros(800,canshu);
   row_num=0;
   soft_tab4=zeros(L,canshu,40000);
   llr_tab4=zeros(L,canshu,40000);
   ep_tab4=zeros(L,canshu,40000);
   s_tab4=zeros(40000,L);
   e_tab4=zeros(40000,canshu);
   
    for ii=1:framenumber
        source1=seg_CRC_encoder(K1,crc);
        x1 = zeros(1,N);
        x1(free1) = source1;
        oracle = x1;               %%测试用添加
        x1 = mod(x1*G,2);
        b1 = 2*x1-1;
        y = b1+sigma1*randn(1,N);
        have_correct=0;
        soft_in=zeros(4,K1);
        soft_pm=zeros(4,K1);
        llr_v=zeros(L,K1);
    
        [Umatrix,Pro,C0,C1,P0,P1,A_C,soft_in,soft_pm,llr_v,spaceP0,spaceP1,spaceC0,spaceC1,space_act] = SCL_decoder(y,sigma1,frozen1,L,segment(1),soft_in,free1,source1,soft_pm,llr_v,seg_num);   %译码
    
    
        for seg=1:3
            [pass_mun,C0,C1,P0,P1,activePath,inactivePathIndices,U_seq,jiaozhengzi,soft_in,soft_pm,llr_v]=seg_set(N,L,free1,frozen1,Umatrix,seg,crc,C0,C1,P0,P1,seg_position,source1,Pro,SNR,soft_in,soft_pm,llr_v,err_pp,err_pp2,err_pp3,spaceP0,spaceP1,spaceC0,spaceC1,space_act);
            if (pass_mun==0)&&(seg==3)

%%%         记录满足出现概率较大的软信息错误模型（L都满足）
                err_w1=zeros(L,canshu);
                err_baohu=zeros(L,canshu);
                pp1=zeros(L,1);
                for ii3=1:L
                    err_w1(ii3,:)=(source1(45:81)~=U_seq(ii3,free1(45:81)));
                    pp0=ismember(err_pp3,err_w1(ii3,:),'rows');
                    pp1(ii3)=length(find(pp0==1));
                end
                
                %%%%%if (pp1(1))&&(pp1(2))&&(pp1(3))&&(pp1(4))
                if (pp1(1))||(pp1(2))||(pp1(3))||(pp1(4))
                    ind1=find(pp1==1);
                    for p8=1:length(ind1)
                        sss=soft_in(:,45:81);
                        lll=llr_v(:,45:81);
                        temp11=sss(ind1(p8),:);
                        temp22=lll(ind1(p8),:);
                        sss(ind1(p8),:)=sss(1,:);
                        lll(ind1(p8),:)=lll(1,:);
                        sss(1,:)=temp11;
                        lll(1,:)=temp22;
                        soft_tab4(:,:,row_num+p8)=sss;
                        llr_tab4(:,:,row_num+p8)=lll;
                        s_tab4(row_num+p8,:)=jiaozhengzi{ind1(p8),1};
                        e_tab4(row_num+p8,:)=err_w1(ind1(p8),:);
                    end
                    
                    row_num=row_num+length(ind1);
                end
                ttt=1;              
             
             
%%%         测试分段1中无法通过校验时的最小错误情况
%                   for path8=1:L
%                       err_w=find(source1(45:81)~=U_seq(path8,free1(45:81)))+44;
%                       %err_w=find(source1(1:19)~=U_seq(path8,free1(1:19)));
%                       if length(err_w)<=37
%                           polish=zeros(1,37-length(err_w));
%                           [look_tab,row_ind]=ismember([err_w,polish],Table_patt,'rows');
%                           if look_tab==0
%                               row_num=row_num+1;
%                               Table_patt(row_num,1:length(err_w))=err_w;
%                               Table_err(row_num)=1;
%                           else
%                               Table_err(row_ind)=Table_err(row_ind)+1;
%                           end
%                           tttt=1;
%                       end
%                   end
            end
              
            [Umatrix,Pro,C0,C1,P0,P1,A_C,soft_in,soft_pm,llr_v,spaceP0,spaceP1,spaceC0,spaceC1,space_act] = SCL_decoder_two(C0,C1,P0,P1,activePath,inactivePathIndices,A_C,L,U_seq,free1,seg_position,seg,soft_in,soft_pm,llr_v,spaceP0,spaceP1,spaceC0,spaceC1,space_act); 
        end
   
    [~,l_prob]=sort(Pro,'descend');
    U_free1=Umatrix(:,free1);
    for path2=1:L
        Flag=seg_CRC_decoder(U_free1(l_prob(path2),:),4,crc);
        if Flag==0 
            finished=1;
            break;
        else
             finished=0;
             continue; 
         end
     end 
      
      if finished==0       %如果均未通过CRC校验，选MAP结果
         input_u = Umatrix(l_prob(1),free1(ind_position));
         
      
%%%       测试分段4中无法通过校验时的最小错误情况
    
%           for path8=1:L
%               err_w=find(source1(75:128)~=Umatrix(path8,free1(75:128)))+74;
%               %err_w=find(source1(1:21)~=U_seq(path8,free1(1:21)));
%               if length(err_w)<55
%                   polish=zeros(1,54-length(err_w));
%                   [look_tab,row_ind]=ismember([err_w,polish],Table_patt,'rows');
%                   if look_tab==0
%                       row_num=row_num+1;
%                       Table_patt(row_num,1:length(err_w))=err_w;
%                       Table_err(row_num)=1;
%                   else
%                       Table_err(row_ind)=Table_err(row_ind)+1;
%                   end
%                   tttt=1;
%                end
%            end
%   
      
      else                 %选取通过的路径输出
         input_u = Umatrix(l_prob(path2),free1(ind_position));
      end
     
      u_ch_temp=source1(ind_position);
      err = sum(u_ch_temp~=input_u);
      
      if err>0
          eeee=[];
         
          for kk=1:length(input_u)
              if u_ch_temp(kk)~=input_u(kk)
                  %eeee=[eeee,kk];
              end
          end  
          sumsum=sumsum+1;
           
      end

      error1(i) = error1(i)+err;
      
  ii   
   end
end
    sumsum
    error1 = error1/(framenumber*K1)