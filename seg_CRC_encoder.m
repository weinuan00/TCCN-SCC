function y=seg_CRC_encoder(len,crc1) 
len_of_one_layer=len;
len_crc1=length(crc1)-1;
%len_crc2=length(crc2)-1;
y=[];                                    %%产生信息之前矩阵为空矩阵
seg_num=4;
y1=(sign(randn(1,len_of_one_layer-len_crc1*4))+1)/2;
%inform={y1(1:17);y1(18:40);y1(41:62);y1(63:112)};
%inform={y1(1:18);y1(19:30);y1(31:37);y1(38:112)};
inform={y1(1:15);y1(16:36);y1(37:69);y1(70:112)};
P= zeros(seg_num,len_crc1);
for seg_n=1:seg_num
    DataCRC=[inform{seg_n,:},zeros(1,len_crc1)];
    crc=crc1;
    len_crc=len_crc1;
    if seg_n==1
        lenD=15;    
    elseif seg_n==2
        lenD=21;
    elseif seg_n==3
        lenD=33;
    elseif seg_n==4
        lenD=43;
    end
    for i= 1:lenD
        if DataCRC(i)==1
            for j=(1:length(crc))
                DataCRC(i+j-1)=xor(DataCRC(i+j-1),crc(j));
            end
        end
    end
    for k= 1:len_crc
        P(seg_n,k)=DataCRC(lenD+k);%CRC校验位，行向量
    end
end
y=[inform{1,:},P(1,:),inform{2,:},P(2,:),inform{3,:},P(3,:),inform{4,:},P(4,:)];

end