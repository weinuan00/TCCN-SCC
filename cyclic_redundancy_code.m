function [dataAddFSC]=cyclic_redundancy_code(data,crc,len_crc)
%   20150707/hexiang
% CRC-24A：g(x)=x24+x23+x18+x17+x14+x11+x10+x7+x6+x5+x4+x3+x+1;
% CRC-24B: g(x)=x24+x23+x6+x5+x+1;   
L = len_crc;
P= zeros(1,L); 
lenD = length(data);
% G=[1 1 0 0 0 0 1 1 0 0 1 0 0 1 1 0 0 1 1 1 1 1 0 1 1]; % 生成多项式，由低位到高位
DataCRC=[data.',zeros(1,L)];
for i= 1:lenD
    if DataCRC(i)==1
        for j=(1:length(crc))
            DataCRC(i+j-1)=xor(DataCRC(i+j-1),crc(j));
        end
    end
end
for k= 1:L
    P(k)=DataCRC(lenD+k);%CRC校验位，行向量
end
dataAddFSC=[data;P.'];