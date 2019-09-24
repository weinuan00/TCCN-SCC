%%%%排序
% r=length(Table_err); 
% for i=1:r-1 
%     for j=i+1:r 
%         if Table_err(i)<Table_err(j) 
%             temp=Table_err(i); 
%             Table_err(i)=Table_err(j); 
%             Table_err(j)=temp;
%             temp1=Table_patt(i,:); 
%             Table_patt(i,:)=Table_patt(j,:); 
%             Table_patt(j,:)=temp1;
%         end 
%     end 
% end 

%%%%%%one-hot encoding

err_p_3=zeros(100,37);
for i7=1:size(err_p_3,1)
    e_p=zeros(1,37);
    for i8=1:37
       if err3_p100(i7,i8)~=0
           e_p(err3_p100(i7,i8)-44)=1;
           %e_p(err2_p100(i7,i8))=1;
       end
    end
    err_p_3(i7,:)=e_p;
end

%%%%检查每一行训练数据的对应关系
% for ii6=1:33736
%     if ii6==30000
%         ggg=1;
%     end
%     for ii7=1:4
%         e1=abs(train_rig_code(ii6,:)-train_wor_code(ii7,:,ii6));
%         [~,ss1]=seg_CRC_decoder(e1,1,[1 0 0 1 1]);
%         if isequal(ss1, syndrome(ii7,:,ii6))
%             gg=1;
%         else
%             fff=1;
%         end
%     end
% end

%%%%%计算前100的错误模型对应校正子的情况
% row2=0;
% table_err1=zeros(20,14);
% err_n=zeros(20,1);
% for ii8=1:33736
%     for ii9=1:4
%         if syndrome(ii9,:,ii8)==[0 0 0 1]
%             tt_e=abs(train_rig_code(ii8,:)-train_wor_code(ii9,:,ii8));
%             [look_tab,row_ind]=ismember(tt_e,table_err1,'rows');
%             if look_tab==0
%                 row2=row2+1;
%                 table_err1(row2,1:length(tt_e))=tt_e;
%                 err_n(row2)=1;
%             else
%                 err_n(row_ind)=err_n(row_ind)+1;
%             end
%         end
%     end
% end

% %%%%%错误模型只保留首位的1
% for ii10=1:33712
%     for ii11=1:4
%         %temp_e1=ep_tab4(ii11,:,ii10);
%         search1=0;
%         for ii12=1:14
%             if ep_tab4(ii11,ii12,ii10)==1;
%                 search1=ii12;
%                 break;
%             end
%         end
%         if search1<14
%             for ii13=search1+1:14
%                 ep_tab4(ii11,ii13,ii10)=0;
%             end
%         end
%     end
%     
% end

%%%%%保留首位的1并取消one-hot encoding
% ep1_wei=zeros(4,27845);
% for ii10=1:30783
%     for ii11=1:4
%         %temp_e1=ep_tab4(ii11,:,ii10);
%         search1=0;
%         for ii12=1:14
%             if ep_tab4(ii11,ii12,ii10)==1;
%                 ep1_wei(ii11,ii10)=ii12;
%                 break;
%             end
%         end
%     end
%     
% end

%%%将01形式的错误图样转换成LSTM可识别的分类数
% err_p=err_p_2;
% eeep=err_p_2(1:30,:);
% ep_fenlei=zeros(7513,1);
% for ii10=1:7513
%     pp0=ismember(eeep,e_tab4(ii10,:),'rows');
%     pp1=find(pp0==1);
%     ep_fenlei(ii10,1)=pp1;
% end

%%%%%搜索第一段就开始出错的样本
% sampset=[];
% 
% for ii=1:27596
%     tt=soft_tab4(1,1,ii)+soft_tab4(2,1,ii)+soft_tab4(3,1,ii)+soft_tab4(4,1,ii);
%    if tt~=4
%        sampset=[sampset,ii];
%    end
% end
% e_tab4(sampset,:)=[];
% ep_fenlei(sampset)=[];
% llr_tab4(:,:,sampset)=[];
% s_tab4(sampset,:)=[];
% soft_tab4(:,:,sampset)=[];

%%%%%用前一百位错误模型直接计算对应校正子的种类
% ep_jilu=zeros(10,14);
% row_num=0;
% for jj=1:100
%     [fff,jiaozheng]=seg_CRC_decoder(err_p(jj,:),1,[1 0 0 1 1]);
%     if jiaozheng==[1 1 1 1]
%         row_num=row_num+1;
%         ep_jilu(row_num,:)=err_p(jj,:);
%     end
% end

%%%%删掉没有出现的种类
% ep_f=zeros(13087,1);
% kong=[14 16 18 21 24 28 29 30];
% for ii=1:13087
%     if ep_fenlei(ii)<14
%         ep_f(ii)=ep_fenlei(ii);
%     else   % if ep_fenlei(ii)==15
%         ep_f(ii)=ep_fenlei(ii)-length(find(kong<ep_fenlei(ii)));
%     end
% end


%%%%%调试 U矩阵每一行是否在corrected_code矩阵中
% fliplocation=find(epj==1);
% start_point=ceil(fliplocation(1)/4);
% path_condition=zeros(L,L);
% path_corr1=zeros(4,1);
% if phi==free1(start_point)-1
%     for ii2=1:L   %译码进行到start_point处再执行
%         ppp=ismember(corrected_code(:,tiaojie+1:tiaojie+start_point-1),U(ii2,free1(tiaojie+1:tiaojie+start_point-1)),'rows');
%         path_condition(ii2,:)=ppp';
%         path_corr1(ii2)=max(ppp);
%     end
% end
% set_conforks=2*ones(L,2);
% if sum(sum(path_condition))==4
%     for ii3=1:L
%         if path_corr1(ii3)==0
%            continue;
%         else
%            check_path=find(path_condition(ii3,:)==1) ;
%            for ii4=1:length(check_path)
%                set_value=corrected_code(check_path(ii4),jishu_free);
%                set_conforks(ii3,set_value+1)=1;
%            end
%         end
%     end
% else
%     fffff=1;
% end
% pp4=find(contForks==1);
% pp5=find(set_conforks==1);
% available_path=setdiff(pp4,pp5);
% fix_path=setdiff(pp5,pp4);
% %corrr4_path=intersect(pp4,pp5);
% for ii5=1:length(fix_path)
%     contForks(fix_path(ii5))=1;
%     contForks(available_path(ii5))=0;
% end
