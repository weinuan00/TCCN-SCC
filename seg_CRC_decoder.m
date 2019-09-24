function [Flag,jiaozhengzi]=seg_CRC_decoder(U_free,seg,G)
    L=length(G)-1;
    P= zeros(1,L); 
    %lenD=length(U_free)/seg_num;
    seg_position=[19,44,81,128];
    if seg==1
        lenD=seg_position(seg);
        DataDeCRC=U_free(1:seg_position(seg)); 
    else  
        lenD=seg_position(seg)-seg_position(seg-1);
        DataDeCRC=U_free(seg_position(seg-1)+1:seg_position(seg)); 
    end
    
    for i= 1:lenD-L     %只遍历前面的信息位个长度
        if DataDeCRC(i)==1
            for j=(1:length(G))
                DataDeCRC(i+j-1)=xor(DataDeCRC(i+j-1),G(j));
            end
        end
    end
    for k= 1:L
        P(k)=DataDeCRC(lenD-L+k);
    end
    PBin=sum(P);
    if PBin==0
        Flag=0;
    else 
        Flag=1;
    end
    
    jiaozhengzi=P;
end