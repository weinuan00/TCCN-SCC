function [C0,C1]=set_C_matrix(C0,C1,ep_tab,ind_fenlei,path3,SNR,seg)
    %%%将错误图样转为错误位置
    e_location=[];
    for ii2=1:length(ep_tab)
        if ep_tab(ii2)==1
            e_location=[e_location,ii2];
        end
    end
    if seg==1
        error_position=e_location;
    elseif seg==2
        error_position=e_location+21;
    elseif seg==3
        error_position=e_location+47;
    end
    
         if SNR==1
             if error_position==21
                 diffe0=9;
                 diffe1=[ ];
             elseif isequal([19 20],error_position)
                 diffe0=[1159 1735  ];
                 diffe1=[9 1160 ];
             elseif isequal([18 19 20 21],error_position)
                 diffe0=[7           8           9        1160        1735];
                 diffe1=[9        1160];    
             elseif isequal([18 21],error_position)
                 diffe0=[7 8 9];
                 diffe1=[1159 1160];
             elseif isequal([19 21],error_position)
                 diffe0=[7 9 583 ];
                 diffe1=8 ;
             elseif isequal([18 20],error_position)
                 diffe0=[8 583 1160 1735];
                 diffe1=[8 9 1160];    
             elseif isequal([18 19 21],error_position)
                 diffe0=[8 9 583 1159 1160];
                 diffe1=8;
             elseif error_position==19
                 diffe0=[7 583];
                 diffe1=8;
             elseif error_position==18
                 diffe0=[7 8 1159 1160 ];
                 diffe1=[ ];
             elseif isequal([18 19],error_position)
                 diffe0=[8 583 1159 1160];
                 diffe1=8;
             elseif isequal([18 19 20],error_position)
                 diffe0=[7 8 1160 1735];
                 diffe1=[9 1160 ];
             elseif isequal([19 20 21],error_position)
                 diffe0=[9 1159 1735];
                 diffe1=[9 1160];
             elseif isequal([18 20 21],error_position)
                 diffe0=[8  9  583  1160  1735];
                 diffe1=[8  9  1160];    
             elseif isequal([12 13 19 20],error_position)
                 diffe0=[1157  1159  1301  1733  1735  1877];
                 diffe1=[9     1158  1160  1734];    
             elseif isequal([14 15 16 17 21],error_position)
                 diffe0=[9     1733  1877  2021  2165];
                 diffe1=[1734  1735  2022]; 
             elseif isequal([14 15],error_position)
                 diffe0=[1157 1301 1445 1589];
                 diffe1=[1158 1159 1446];     
             elseif isequal([12    13    16    17    19    20],error_position)
                 diffe0=[1159 1445 1589 1735 2021 2165];
                 diffe1=[9    1159 1160 1446 1735 2022];  
             elseif isequal([12 13],error_position)
                 diffe0=[1157 1301 1733 1877];
                 diffe1=[1158 1734 ];
             elseif isequal([12    13    14    15    19    20    21],error_position)
                 diffe0=[9  1159 1445 1589 1733 1735 1877];
                 diffe1=[9  1159 1160 1446 1734];
             elseif isequal([12    16    19],error_position)
                 diffe0=[7   293 437   583   869   1013];
                 diffe1=[7   8   294   583   870];   
             elseif isequal([14    16    21],error_position)
                 diffe0=[9    581  725  869  1013];
                 diffe1=[582  583  870];    
             elseif isequal([12    16],error_position)
                 diffe0=[293 437  869  1013];
                 diffe1=[7   294  583  870];    
             elseif isequal([14    16],error_position)
                 diffe0=[581   725   869   1013];
                 diffe1=[582   583   870];
             elseif error_position==12
                 diffe0=[5 149 581 725 ];
                 diffe1=[6 582];   
             elseif error_position==14
                 diffe0=[5 149 293 437 ];
                 diffe1=[6 7 294];    
             elseif isequal([12    13    14    15],error_position)
                 diffe0=[1445 1589 1733 1877];
                 diffe1=[1159 1446 1734]; 
             elseif isequal([14 15 16 17],error_position)
                 diffe0=[1733 1877 2021 2165];
                 diffe1=[1734 1735 2022];    
             elseif isequal([12    13    16    17],error_position)
                 diffe0=[1445 1589 1733 1877];
                 diffe1=[1159 1446 1734];
             elseif isequal([12    14    16    19    21],error_position)
                 diffe0=[5 7 9  149 583 869 1013];
                 diffe1=[6 8 583 870];    
             elseif isequal([12    19],error_position)
                 diffe0=[5 7 149 581 583 725];
                 diffe1=[6 8 582];
             elseif isequal([12    14    19    21],error_position)
                 diffe0=[7 9 293 437 581 583 725];
                 diffe1=[7 8 294 582];    
             elseif isequal([12    13    18    19    21 ],error_position)
                 diffe0=[8 9 583 1157 1159 1160 1301 1733 1877];
                 diffe1=[8 1158 1734];    
             elseif isequal([12    14    16    21],error_position)
                 diffe0=[5 9 149 869 1013];
                 diffe1=[6 583 870];  
             elseif isequal([12    13    14    15    16    17],error_position)
                 diffe0=[1157 1301 2021 2165];
                 diffe1=[1158 1735 2022];    
             elseif isequal([12    14],error_position)
                 diffe0=[293 437   581   725];
                 diffe1=[7   294   582];    
             elseif isequal([12    19    21],error_position)
                 diffe0=[5 7 9 149 581 583 725];
                 diffe1=[6 8 582];    
             elseif isequal([14    19],error_position)
                 diffe0=[5 7 149 293 437 583];
                 diffe1=[6 7 8 294];
             elseif isequal([14    16    18    20],error_position)
                 diffe0=[8 581 583 725 869 1013 1160 1735];
                 diffe1=[8 9 582 583 870 1160];    
             elseif isequal([14    15    18    21],error_position)
                 diffe0=[7 8 9 1157 1159 1160 1301 1445 1589];
                 diffe1=[1158 1159 1446];    
             elseif isequal([14    15    21],error_position)
                 diffe0=[9 1157 1301 1445 1589];
                 diffe1=[1158 1159 1446];
             elseif isequal([14    15    16    17    18    19    20    21],error_position)
                 diffe0=[7 8 9 1160 1733 1735 1877 2021 2165];
                 diffe1=[9 1160 1734 1735 2022];
             elseif isequal([12    13    19    20    21],error_position)
                 diffe0=[9 1157 1159 1301 1733 1735 1877];
                 diffe1=[9 1158 1160 1734];
             elseif isequal([14    21],error_position)
                 diffe0=[5  9   149   293   437];
                 diffe1=[6  7   294];
             elseif isequal([12    16    18    20    21],error_position)
                 diffe0=[8 9 293 437 583 869 1013 1160 1735];
                 diffe1=[7 8 9 294 583 870 1160];
             elseif isequal([14    16    19],error_position)
                 diffe0=[7   581   583   725   869  1013];
                 diffe1=[8   582   583   870];
             elseif isequal([12    16    21],error_position)
                 diffe0=[9   293   437   869  1013];
                 diffe1=[7   294   583   870];
             elseif isequal([12    13    14    15    16    17    19    20    21],error_position)
                 diffe0=[9 1157 1159 1301 1735 2021 2165];
                 diffe1=[9 1158 1160 1735 2022];
             elseif isequal([12    16    18    21],error_position)
                 diffe0=[7 8 9 293 437 869 1013 1159 1160];
                 diffe1=[7 294 583 870];
             elseif isequal([12    13    18    19],error_position)
                 diffe0=[8 583 1157 1159 1160 1301 1733 1877];
                 diffe1=[8 1158 1734];
             elseif isequal([12    16    18    19    20    21],error_position)
                 diffe0=[7 8 9 293 437 869 1013 1160 1735];
                 diffe1=[7 9 294 583 870 1160];
             
             elseif isequal(48,error_position)   %%%1
                 diffe0=9;
                 diffe1=[  ];
             elseif isequal([47 48],error_position)
                 diffe0=[8  9  1160];
                 diffe1=9;    
             elseif isequal(47,error_position)
                 diffe0=[8 1160];
                 diffe1=9 ;  
             elseif isequal(45,error_position)
                 diffe0=[6 294 582 870];
                 diffe1=[7 8 583];   
             elseif isequal([44 46],error_position)%%%5
                 diffe0=[582 870 1734 2022 ];
                 diffe1=[8 583 1160 1735];
             elseif isequal([45 48],error_position)
                 diffe0=[6 9 294 582 870];
                 diffe1=[7 8 583];
             elseif isequal([44 45 46],error_position)
                 diffe0=[6 294 1734 2022];
                 diffe1=[7 1160 1735];
             elseif isequal([45 46],error_position)
                 diffe0=[1158 1446 1734 2022];
                 diffe1=[1159 1160 1735];
             elseif isequal([44 45],error_position)
                 diffe0=[582 870 1158 1446];
                 diffe1=[8 583 1159];
             elseif isequal([44 46 47],error_position)  %%%10
                 diffe0=[8 582 870 1160 1734 2022];
                 diffe1=[8 9 583 1160 1735];
             elseif isequal(44,error_position)
                 diffe0=[6 294 1158 1446];
                 diffe1=[7 1159 ];
             elseif isequal([45 46 48],error_position)
                 diffe0=[9 1158 1446 1734 2022];
                 diffe1=[1159 1160 1735];
             elseif isequal([43    44    45    46],error_position)
                 diffe0=[7 294 582 583 1158 1159 1735  2022];
                 diffe1=[7 1160 1735];    
             elseif isequal([44 47],error_position)
                 diffe0=[6  8  294  1158  1160  1446];
                 diffe1=[7  9  1159];
             elseif isequal([43    47    48],error_position)
                 diffe0=[6 7 8 9 582 583 1158 1159 1160 1734 1735];
                 diffe1=9;
             elseif isequal([43    44    45    46    47],error_position)
                 diffe0=[7 8 294 582 583 1158 1159 1160 1735 2022];
                 diffe1=[7 9 1160 1735];
             elseif isequal([44    45    46    47    48],error_position)
                 diffe0=[6 8 9 294 1160 1734 2022];
                 diffe1=[7 9 1160 1735];    
             elseif isequal([43    44    47],error_position)    %18
                 diffe0=[7 8 294 582 583 1159 1160 1446 1734 1735];
                 diffe1=[7 9 1159]; 
             elseif isequal([43    44    45    47    48],error_position)
                 diffe0=[6 7 8 9 583 870 1159 1160 1446 1734 1735];
                 diffe1=[8 9 583 1159];
             elseif isequal(43,error_position)
                 diffe0=[6 7 582 583 1158 1159 1734 1735];
                 diffe1=[ ];
             elseif isequal([43    46],error_position)
                 diffe0=[7 294 583 870 1159 1446 1735 2022];
                 diffe1=[7 8 583 1159 1160 1735];
             elseif isequal([43    48],error_position)
                 diffe0=[6 7 9 582 583 1158 1159 1734 1735];
                 diffe1=[ ];
             elseif isequal([43    44    45],error_position)
                 diffe0=[6 7 583 870 1159 1446 1734 1735];
                 diffe1=[8 583 1159];
             elseif isequal([44    45    47    48],error_position)
                 diffe0=[8 9 582 870 1158 1160 1446];
                 diffe1=[8 9 583 1159];
             elseif isequal([43    45    47],error_position)   %25
                 diffe0=[7 8 294 583 870 1158 1159 1160 1734 1735];
                 diffe1=[7 8 9 583];
             elseif isequal([43    44    47    48],error_position)
                 diffe0=[7 8 9 294 582 583 1159 1160 1446 1734 1735];
                 diffe1=[7 9 1159];
             elseif isequal([43 45],error_position)
                 diffe0=[7 294 583 870 1158 1159 1734 1735];
                 diffe1=[7 8 583];   
             elseif isequal([43    45    46    47    48],error_position)
                 diffe0=[6 7 8  9 582 583 1159 1160 1446 1735 2022];
                 diffe1=[9 1159 1160 1735];
             elseif isequal([43    44    46],error_position)
                 diffe0=[6 7 583 870 1158 1159 1735 2022];
                 diffe1=[8 583 1160 1735];    
             elseif isequal([43    44    45    46    47    48],error_position)   %%30
                 diffe0=[7 8 9 294 582 583 1158 1159 1160 1735 2022];
                 diffe1=[7 9 1160 1735];    
             elseif isequal([43    45    46],error_position)
                 diffe0=[1159 1160 1735];
                 diffe1=[6 7 582 583 1159 1446 1735 2022];
             elseif isequal([43    46    47    48],error_position)
                 diffe0=[7 8 9 294  583   870  1159  1160 1446 1735 2022];
                 diffe1=[7 8 9 583  1159  1160 1735];    
             elseif isequal([43    44    48],error_position)
                 diffe0=[7  9   294   582  583  1159  1446  1734  1735];
                 diffe1=[7  1159];    
             elseif isequal([43    45    46    47],error_position)
                 diffe0=[6 7    8    582  583  1159  1160  1446  1735  2022];
                 diffe1=[9 1159 1160 1735];  
             elseif isequal([43 47],error_position)
                 diffe0=[6 7 8 582 583 1158 1159 1160 1734 1735];
                 diffe1=9 ;
             elseif isequal([43    45    48],error_position)
                 diffe0=[7 8 583];
                 diffe1=[7 9 294 583 870 1158 1159 1734 1735];
             elseif isequal([43    45    47    48],error_position)
                 diffe0=[7 8  9  294 583 870 1158 1159 1160 1734 1735];
                 diffe1=[7 8  9  583];
             elseif isequal([43    44    45    48],error_position)
                 diffe0=[6 7 9 583 870 1159 1446 1734 1735];
                 diffe1=[8 583 1159];
             elseif isequal([43    44],error_position)
                 diffe0=[7 294 582 583 1159 1446  1734 1735];
                 diffe1=[7 1159];    
             elseif isequal([43    44    45    47],error_position)
                 diffe0=[6 7 8  583  870 1159 1160 1446 1734 1735];
                 diffe1=[8 9 583 1159];    
             elseif isequal([43    45    46    48],error_position)
                 diffe0=[1159 1160 1735];
                 diffe1=[6 7 9 582 583 1159 1446 1735 2022];    
             elseif isequal([43    44    46    47    48],error_position)
                 diffe0=[6 7  8  9  583 870  1158  1159  1160 1735  2022];
                 diffe1=[8 9  583  1160 1735];    
             elseif isequal([43    44    45    46    48],error_position)
                 diffe0=[7  9    294  582  583 1158  1159  1735 2022];
                 diffe1=[7  1160 1735];
             elseif isequal(39,error_position)
                 diffe0=[4    76   148   220   292   364   436   508];
                 diffe1=[5     6   149   293   294   437];
             elseif isequal([43    44    46    47],error_position)
                 diffe0=[6  7  8   583   870  1158 1159  1160  1735 2022];
                 diffe1=[8  9  583 1160  1735];    
             elseif isequal([43    46    48],error_position)
                 diffe0=[7  9  294  583   870   1159  1446  1735  2022];
                 diffe1=[7  8  583  1159  1160  1735];    
             elseif isequal([37    39    48],error_position)
                 diffe0=[9   292   364   436   508   580   652   724   796];
                 diffe1=[293   294   437   581   582   725];    
             elseif isequal([36    38    47],error_position)
                 diffe0=[8 580 652 724  796  1160 1732 1804 1876 1948];
                 diffe1=[9 581 582 725  1733 1734 1877];    
             elseif isequal([36    38    40    42    47],error_position)
                 diffe0=[8 868  940  1012  1084 1160  2020 2092  2164 2236];
                 diffe1=[9 869  870  1013  2021 2022  2165];    
             elseif isequal([39    41],error_position)
                 diffe0=[580  652  724  796  868  940  1012  1084];
                 diffe1=[581  582  725  869  870  1013];
                 
             elseif isequal(73,error_position)
                 diffe0=[8 9];
                 diffe1=[ ];
             elseif isequal([73 74],error_position)
                 diffe0=[9 1160];
                 diffe1= 9 ;
             elseif isequal(74,error_position)
                 diffe0=[8 1160];
                 diffe1=9;
             elseif isequal([71 72 73 74],error_position)
                 diffe0=[9 1158 1160 1446 1734 2022];
                 diffe1=[9 1159 1160 1735];
             elseif isequal([71 72],error_position)
                 diffe0=[1158 1446 1734 2022];
                 diffe1=[1159 1160 1735]; 
             elseif isequal(71,error_position)
                 diffe0=[6 294 582 870];
                 diffe1=[7 8 583]; 
             elseif isequal([69 74],error_position)
                 diffe0=[6 7 8 582 583 1158 1159 1160 1734 1735];
                 diffe1=9 ;
             elseif isequal([71 73],error_position)
                 diffe0=[6 8 9 294 582 870];
                 diffe1=[7 8 583];
             elseif isequal([70    71    74],error_position)
                 diffe0=[8  582  870  1158  1160  1446];
                 diffe1=[8  9    583  1159];    
             elseif isequal([70    71    73    74],error_position)
                 diffe0=[9         582         870        1158        1160        1446];
                 diffe1=[8           9         583        1159];    
             elseif isequal([69    73],error_position)
                 diffe0=[6  7  8  9  582  583  1158  1159  1734  1735];
                 diffe1=[];   
             elseif isequal([69    71    74],error_position)
                 diffe0=[7 8  294 583 870 1158 1159 1160 1734 1735];
                 diffe1=[7 8  9 583];    
             elseif isequal([70 71],error_position)
                 diffe0=[582 870 1158 1446];
                 diffe1=[8 583 1159];    
             elseif isequal(69,error_position)
                 diffe0=[6 7 582 583 1158 1159 1734 1735];
                 diffe1=[  ];
             elseif isequal([70    72],error_position)
                 diffe0=[582   870    1734   2022];
                 diffe1=[8     583    1160   1735];
             elseif isequal([69    73    74],error_position)
                 diffe0=[6 7 9 582 583 1158 1159 1160 1734 1735];
                 diffe1=9;    
             elseif isequal([69    71    72    74],error_position)
                 diffe0=[9 1159 1160 1735];
                 diffe1=[6 7 8 582 583 1159 1160 1446 1735 2022];
             elseif isequal([70    72    74],error_position)
                 diffe0=[8 582 870  1160  1734  2022];
                 diffe1=[8 9   583  1160  1735];
             elseif isequal([69    70    71    72    73    74],error_position)
                 diffe0=[7 9 294 582 583 1158 1159 1160 1735 2022];
                 diffe1=[7 9 1160 1735];
             elseif isequal([70    71    72    73    74],error_position)
                 diffe0=[6 9 294  1160  1734 2022];
                 diffe1=[7 9 1160 1735];
             elseif isequal([70    71    73],error_position)
                 diffe0=[8 9   582 870 1158 1446];
                 diffe1=[8 583 1159];    
             elseif isequal([69    71    72    73],error_position)
                 diffe0=[6    7    8    9  582  583  1159  1446  1735  2022];
                 diffe1=[1159 1160 1735];    
             elseif isequal([70    72    73    74],error_position)
                 diffe0=[9  582  870  1160  1734  2022];
                 diffe1=[8  9    583  1160  1735];    
             elseif isequal([69    70    71    72    74],error_position)
                 diffe0=[7 8 294  582  583 1158  1159 1160  1735  2022];
                 diffe1=[7 9 1160 1735]; 
             elseif isequal([69 70],error_position)
                 diffe0=[7 294 582 583 1159 1446 1734 1735];
                 diffe1=[7 1159 ];    
             elseif isequal([69    70    73    74],error_position)
                 diffe0=[7  9  294   582  583  1159  1160  1446  1734  1735];
                 diffe1=[7  9  1159];
             elseif isequal([69    70    74],error_position)
                 diffe0=[7  8  294  582  583  1159  1160  1446  1734  1735];
                 diffe1=[7  9  1159];    
             elseif isequal([69    70    72    73    74],error_position)
                 diffe0=[6  7  9   583  870  1158  1159  1160  1735  2022];
                 diffe1=[8  9  583 1160 1735];    
             elseif isequal([70    72    73],error_position)
                 diffe0=[8  9   582  870  1734  2022];
                 diffe1=[8  583 1160 1735];
             elseif isequal([69    71    73],error_position)
                 diffe0=[7 8 9 294 583 870 1158 1159 1734 1735];
                 diffe1=[7 8 583];    
             
             elseif isequal([70 71 72 73],error_position)
                 diffe0=[6 8 9 294 1734 2022];
                 diffe1=[7 1160 1735];
             elseif isequal([70 71 72 74],error_position)
                 diffe0=[6 8 294 1160 1734 2022];
                 diffe1=[7 9 1160 1735];
             elseif isequal([69 71 72],error_position)
                 diffe0=[6 7 582 583 1159 1446 1735 2022];
                 diffe1=[1159 1160 1735];
             else
                 diffe0=[ ];
                 diffe1=[ ];
             end
         end
         if (SNR==1.5)||(SNR==2)||(SNR==2.5) 
             if isequal(22,error_position)
                 diffe0=9;
                 diffe1=[];
             elseif isequal([20 22],error_position)
                 diffe0=[7 9 583];
                 diffe1=8;    
             elseif error_position==20
                 diffe0=[7 583];
                 diffe1=8;
             elseif isequal([19 21],error_position)
                 diffe0=[8 583 1160 1753];
                 diffe1=[8 9 1160];  
             elseif isequal([19 20],error_position)
                 diffe0=[8 583 1159 1160];
                 diffe1=8;   
             elseif isequal([19 22],error_position)
                 diffe0=[7 8 9 1159 1160];
                 diffe1=[];   
             elseif isequal([19 20 21],error_position)
                 diffe0=[7 8 1160 1735];
                 diffe1=[9 1160];
             elseif isequal([20 21],error_position)
                 diffe0=[1159 1735];
                 diffe1=[9 1160];
             elseif isequal([19 21 22],error_position)
                 diffe0=[8 9 583 1160 1753];
                 diffe1=[8 9 1160];    
             elseif error_position==19
                 diffe0=[7 8 1159 1160];
                 diffe1=[];
             elseif isequal([13 17 20],error_position)
                 diffe0=[7 293 437 583 869 1013];
                 diffe1=[7 8   294 583 870];
             elseif isequal([20 21 22],error_position)
                 diffe0=[9 1159 1735];
                 diffe1=[9 1160]; 
             elseif isequal([19  20  21  22],error_position)
                 diffe0=[7  8    9   1160   1735];
                 diffe1=[9  1160];
             elseif isequal([12  13  14  19  20  21],error_position)
                 diffe0=[5  7  8    149  1160  1733  1735  1877];
                 diffe1=[6  9  1160 1734];    
             elseif isequal([13  14  15  16],error_position)
                 diffe0=[1445  1589  1733  1877];
                 diffe1=[1159  1446  1734];    
             elseif isequal([13  15  17  20  22],error_position)
                 diffe0=[5  7  9    149  583  869  1013];
                 diffe1=[6  8  583  870];    
             elseif isequal([12  13  16  17  19  20],error_position)
                 diffe0=[8  583  869  1013  1159  1160  1445  1589];
                 diffe1=[8  583  870  1159  1446];
             elseif isequal([12  13  14  15],error_position)
                 diffe0=[293  437  1733   1877];
                 diffe1=[7    294  1734];    
             elseif isequal([12  13  14  15  19  20  21  22],error_position)
                 diffe0=[7  8  9   293   437  1160  1733  1735  1877];
                 diffe1=[7  9  294 1160  1734];    
             elseif isequal([12  14  15  17  19  21  22],error_position)
                 diffe0=[8  9  583   869  1013  1160  1733  1735  1877];
                 diffe1=[8  9  583   870  1160  1734];
             elseif isequal([15  22],error_position)
                 diffe0=[5 9 149  293  437];
                 diffe1=[6 7 294]; 
             elseif isequal([19 20 22],error_position)
                 diffe0=[8 9 583 1159 1160];
                 diffe1=[8];    
             elseif isequal([12 15 19 22],error_position)
                 diffe0=[7  8    9   293  437  1157  1159  1160  1301];
                 diffe1=[7  294  1158];
             elseif isequal([12 15],error_position)
                 diffe0=[293  437  1157  1301];
                 diffe1=[7    294  1158];    
             elseif isequal([12  13  15  17  19  20  22],error_position)
                 diffe0=[8  9    583  869  1013  1157  1159  1160  1301];
                 diffe1=[8  583  870  1158];
             elseif isequal([15 16 22],error_position)
                 diffe0=[9     1157  1301  1445  1589];
                 diffe1=[1158  1159  1446];    
             elseif isequal([12  16],error_position)
                 diffe0=[293  437  1445  1589];
                 diffe1=[7    294  1159  1446];
             elseif isequal([15  16  17  18],error_position)
                 diffe0=[1733  1877  2021  2165];
                 diffe1=[1734  1735  2022];    
             elseif isequal([13  14  20  21],error_position)
                 diffe0=[1157 1159  1301  1733  1735  1877];
                 diffe1=[9    1158  1160  1734];    
             elseif isequal([12  13  14  15  16  17  18  19  20  21  22],error_position)
                 diffe0=[5  7  8    9    149  1160  1735  2021  2165];
                 diffe1=[6  9  1160 1735 2022]; 
             elseif isequal([12  13  14],error_position)
                 diffe0=[5  149   1733   1877];
                 diffe1=[6  1734];    
             elseif isequal([12  14  15  17],error_position)
                 diffe0=[869  1013 1733  1877];
                 diffe1=[583  870  1734];   
             elseif isequal([12  14],error_position)
                 diffe0=[581  725  1733  1877];
                 diffe1=[582  1734];    
             elseif isequal([12  14  19  21],error_position)
                 diffe0=[8  581  583  725  1160  1733  1735  1877];
                 diffe1=[8  9    582  1160 1734];    
             elseif isequal([13  20],error_position)
                 diffe0=[5 7  149  581  583  725];
                 diffe1=[6 8  582];    
             elseif isequal([12  16  19],error_position)
                 diffe0=[7 8   293  437 1159  1160  1445  1589];
                 diffe1=[7 294 1159 1446];     
             elseif isequal([15],error_position)
                 diffe0=[5   149   293   437];
                 diffe1=[6     7   294]; 
             elseif isequal([13  14  15  16  17  18  20  21  22],error_position)
                 diffe0=[9  1157  1159  1301  1735  2021  2165];
                 diffe1=[9  1158  1160  1735  2022];    
             elseif isequal([15  16  17  18  22],error_position)
                 diffe0=[9    1733  1877  2021  2165];
                 diffe1=[1734 1735  2022];    
             elseif isequal([13  14  17  18],error_position)
                 diffe0=[1445  1589  2021  2165];
                 diffe1=[1159  1446  1735  2022];  
                 
             elseif error_position==12
                 diffe0=[5 149 1157 1301];
                 diffe1=[6 1158];
             elseif error_position==13
                 diffe0=[5 149 581 725];
                 diffe1=[6 582];
             elseif isequal([15 16],error_position)
                 diffe0=[1157 1301 1445 1589];
                 diffe1=[1158 1159 1446];
                 
                 
             elseif isequal(44,error_position)
                 diffe0=[6 7 582 583 1158 1159 1734 1735];
                 diffe1=[];
             elseif isequal(46,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(9)=~C_0(9);
                 C_0(294)=~C_0(294);
                 C_0(582)=~C_0(582);
                 C_0(870)=~C_0(870);
                 C_1(7)=~C_1(7);
                 C_1(8)=~C_1(8);
                 C_1(583)=~C_1(583);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(45,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(8)=~C_0(8);
                 C_0(294)=~C_0(294);
                 C_0(1158)=~C_0(1158);
                 C_0(1160)=~C_0(1160);
                 C_0(1446)=~C_0(1446);
                 C_1(7)=~C_1(7);
                 C_1(1159)=~C_1(1159);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(37,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([37 38 39],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(1732)=~C_0(1732);
                 C_0(1804)=~C_0(1804);
                 C_0(1876)=~C_0(1876);
                 C_0(1948)=~C_0(1948);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(1733)=~C_1(1733);
                 C_1(1734)=~C_1(1734);
                 C_1(1877)=~C_1(1877);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
                
             elseif isequal([46 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(9)=~C_0(9);
                 C_0(1158)=~C_0(1158);
                 C_0(1446)=~C_0(1446);
                 C_0(1734)=~C_0(1734);
                 C_0(2022)=~C_0(2022);
                 C_1(9)=~C_1(9);
                 C_1(1159)=~C_1(1159);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 45],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(294)=~C_0(294);
                 C_0(582)=~C_0(582);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1446)=~C_0(1446);
                 C_0(1734)=~C_0(1734);
                 C_0(1735)=~C_0(1735);
                 C_1(7)=~C_1(7);
                 C_1(1159)=~C_1(1159);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 45 46],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(583)=~C_0(583);
                 C_0(870)=~C_0(870);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1446)=~C_0(1446);
                 C_0(1734)=~C_0(1734);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(583)=~C_1(583);
                 C_1(1159)=~C_1(1159);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 46],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(9)=~C_0(9);
                 C_0(294)=~C_0(294);
                 C_0(583)=~C_0(583);
                 C_0(870)=~C_0(870);
                 C_0(1158)=~C_0(1158);
                 C_0(1159)=~C_0(1159);
                 C_0(1734)=~C_0(1734);
                 C_0(1735)=~C_0(1735);
                 C_1(7)=~C_1(7);
                 C_1(8)=~C_1(8);
                 C_1(583)=~C_1(583);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 45 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(583)=~C_0(583);
                 C_0(870)=~C_0(870);
                 C_0(1158)=~C_0(1158);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_0(2022)=~C_0(2022);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(583)=~C_1(583);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([45 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(582)=~C_0(582);
                 C_0(870)=~C_0(870);
                 C_0(1160)=~C_0(1160);
                 C_0(1734)=~C_0(1734);
                 C_0(2022)=~C_0(2022);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(583)=~C_1(583);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 46 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(7)=~C_0(7);
                 C_0(9)=~C_0(9);
                 C_0(582)=~C_0(582);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1446)=~C_0(1446);
                 C_0(1735)=~C_0(1735);
                 C_0(2022)=~C_0(2022);
                 C_1(9)=~C_1(9);
                 C_1(1159)=~C_1(1159);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([44 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(294)=~C_0(294);
                 C_0(583)=~C_0(583);
                 C_0(870)=~C_0(870);
                 C_0(1159)=~C_0(1159);
                 C_0(1446)=~C_0(1446);
                 C_0(1735)=~C_0(1735);
                 C_0(2022)=~C_0(2022);
                 C_1(7)=~C_1(7);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(583)=~C_1(583);
                 C_1(1159)=~C_1(1159);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([45 46 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(6)=~C_0(6);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(294)=~C_0(294);
                 C_0(1160)=~C_0(1160);
                 C_0(1734)=~C_0(1734);
                 C_0(2022)=~C_0(2022);
                 C_1(7)=~C_1(7);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C_1(1735)=~C_1(1735);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([45 46],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(582)=~C_0(582);
                 C_0(870)=~C_0(870);
                 C_0(1158)=~C_0(1158);
                 C_0(1160)=~C_0(1160);
                 C_0(1446)=~C_0(1446);
                 C_1(8)=~C_1(8);
                 C_1(583)=~C_1(583);
                 C_1(1159)=~C_1(1159);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(71,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(1160)=~C_0(1160);
                 C_1(9)=~C_1(9);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(70,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
                 
             elseif error_position==15
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(149)=~C_0(149);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_1(6)=~C_1(6);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([12 14],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_1(582)=~C_1(582);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([13 17],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_0(869)=~C_0(869);
                 C_0(1013)=~C_0(1013);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C_1(583)=~C_1(583);
                 C_1(870)=~C_1(870);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;   
             elseif isequal([20 21],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1159)=~C_0(1159);
                 C_0(1735)=~C_0(1735);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;    
            elseif isequal([13 20],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(7)=~C_0(7);
                 C_0(149)=~C_0(149);
                 C_0(581)=~C_0(581);
                 C_0(583)=~C_0(583);
                 C_0(725)=~C_0(725);
                 C_1(6)=~C_1(6);
                 C_1(8)=~C_1(8);
                 C_1(582)=~C_1(582);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
           elseif isequal([12 13],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_1(582)=~C_1(582);
                 C_1(1158)=~C_1(1158);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([13 15],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C_1(582)=~C_1(582);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([12 15],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C_1(1158)=~C_1(1158);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([13 14],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_1(1158)=~C_1(1158);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal(40,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(436)=~C_0(436);
                 C_0(508)=~C_0(508);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(293)=~C_1(293);
                 C_1(294)=~C_1(294);
                 C_1(437)=~C_1(437);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
                 
           elseif isequal([38 39],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_0(1732)=~C_0(1732);
                 C_0(1804)=~C_0(1804);
                 C_0(1876)=~C_0(1876);
                 C_0(1948)=~C_0(1948);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C_1(1733)=~C_1(1733);
                 C_1(1734)=~C_1(1734);
                 C_1(1877)=~C_1(1877);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;      
            elseif isequal([37 41],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(436)=~C_0(436);
                 C_0(508)=~C_0(508);
                 C_0(1444)=~C_0(1444);
                 C_0(1516)=~C_0(1516);
                 C_0(1588)=~C_0(1588);
                 C_0(1660)=~C_0(1660);
                 C_1(293)=~C_1(293);
                 C_1(294)=~C_1(294);
                 C_1(437)=~C_1(437);
                 C_1(1445)=~C_1(1445);
                 C_1(1446)=~C_1(1446);
                 C_1(1589)=~C_1(1589);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;    
            elseif isequal([37 38 40 41],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_0(1444)=~C_0(1444);
                 C_0(1516)=~C_0(1516);
                 C_0(1588)=~C_0(1588);
                 C_0(1660)=~C_0(1660);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C_1(1445)=~C_1(1445);
                 C_1(1446)=~C_1(1446);
                 C_1(1589)=~C_1(1589);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;    
            elseif isequal([35 38],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_0(868)=~C_0(868);
                 C_0(940)=~C_0(940);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(293)=~C_1(293);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C_1(869)=~C_1(869);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([38],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([38 40],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(436)=~C_0(436);
                 C_0(508)=~C_0(508);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_1(293)=~C_1(293);
                 C_1(294)=~C_1(294);
                 C_1(437)=~C_1(437);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([35],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(868)=~C_0(868);
                 C_0(940)=~C_0(940);
                 C_1(5)=~C_1(5);
                 C_1(293)=~C_1(293);
                 C_1(581)=~C_1(581);
                 C_1(869)=~C_1(869);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([37 38],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
                 
             elseif isequal([70 71],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             
            elseif isequal([19 21 22],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(583)=~C_0(583);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;     
             elseif isequal([13 15 22],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(9)=~C_0(9);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C_1(582)=~C_1(582);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([15 16 17 18],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_0(2021)=~C_0(2021);
                 C_0(2165)=~C_0(2165);
                 C_1(1734)=~C_1(1734);
                 C_1(1735)=~C_1(1735);
                 C_1(2022)=~C_1(2022);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([13 14 20 21],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1157)=~C_0(1157);
                 C_0(1159)=~C_0(1159);
                 C_0(1301)=~C_0(1301);
                 C_0(1733)=~C_0(1733);
                 C_0(1735)=~C_0(1735);
                 C_0(1877)=~C_0(1877);
                 C_1(9)=~C_1(9);
                 C_1(1158)=~C_1(1158);
                 C_1(1160)=~C_1(1160);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;     
            elseif isequal([19 20 21],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([13 15 17],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(149)=~C_0(149);
                 C_0(869)=~C_0(869);
                 C_0(1013)=~C_0(1013);
                 C_1(6)=~C_1(6);
                 C_1(583)=~C_1(583);
                 C_1(870)=~C_1(870);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            else
                 diffe0=[ ];
                 diffe1=[ ];
             end
         end
         
         if (SNR==3)||(SNR==3.5)
             if error_position==20
                 C_0=C0(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C0(:,:,path3)=C_0;
             elseif error_position==13
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(149)=~C_0(149);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_1(6)=~C_1(6);
                 C_1(1158)=~C_1(1158);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif error_position==14
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(149)=~C_0(149);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_1(6)=~C_1(6);
                 C_1(582)=~C_1(582);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif error_position==16
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(149)=~C_0(149);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_1(6)=~C_1(6);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif error_position==21
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(9)=~C_0(9);
                 C_0(583)=~C_0(583);
                 C_1(8)=~C_1(8);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([21 22],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(9)=~C_0(9);
                 C_0(1159)=~C_0(1159);
                 C_0(1735)=~C_0(1735);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
            elseif isequal([20 22],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(583)=~C_0(583);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;    
            elseif isequal([13 15],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_1(582)=~C_1(582);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([13 16],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(293)=~C_0(293);
                 C_0(437)=~C_0(437);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_1(7)=~C_1(7);
                 C_1(294)=~C_1(294);
                 C_1(1158)=~C_1(1158);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([14 15 18 19],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1445)=~C_0(1445);
                 C_0(1589)=~C_0(1589);
                 C_0(2021)=~C_0(2021);
                 C_0(2165)=~C_0(2165);
                 C_1(1159)=~C_1(1159);
                 C_1(1446)=~C_1(1446);
                 C_1(1735)=~C_1(1735);
                 C_1(2022)=~C_1(2022);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([14 21],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(5)=~C_0(5);
                 C_0(7)=~C_0(7);
                 C_0(9)=~C_0(9);
                 C_0(149)=~C_0(149);
                 C_0(581)=~C_0(581);
                 C_0(583)=~C_0(583);
                 C_0(725)=~C_0(725);
                 C_1(6)=~C_1(6);
                 C_1(8)=~C_1(8);
                 C_1(582)=~C_1(582);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
            elseif isequal([16 18],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_0(869)=~C_0(869);
                 C_0(1013)=~C_0(1013);
                 C_1(582)=~C_1(582);
                 C_1(583)=~C_1(583);
                 C_1(870)=~C_1(870);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(45,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(46,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(1160)=~C_0(1160);
                 C_1(9)=~C_1(9);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(47,error_position)
                 C_0=C0(:,:,path3);
                 C_0(9)=~C_0(9);
                 C0(:,:,path3)=C_0;
             elseif isequal(41,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(292)=~C_0(292);
                 C_0(364)=~C_0(364);
                 C_0(436)=~C_0(436);
                 C_0(508)=~C_0(508);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(7)=~C_1(7);
                 C_1(149)=~C_1(149);
                 C_1(293)=~C_1(293);
                 C_1(294)=~C_1(294);
                 C_1(437)=~C_1(437);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal(38,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal(39,error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([45 46],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(8)=~C_0(8);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(9)=~C_1(9);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([45 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(7)=~C_0(7);
                 C_0(9)=~C_0(9);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([46 47],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(1160)=~C_0(1160);
                 C_1(9)=~C_1(9);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([41 42],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_0(1444)=~C_0(1444);
                 C_0(1516)=~C_0(1516);
                 C_0(1588)=~C_0(1588);
                 C_0(1660)=~C_0(1660);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1159)=~C_1(1159);
                 C_1(1301)=~C_1(1301);
                 C_1(1445)=~C_1(1445);
                 C_1(1446)=~C_1(1446);
                 C_1(1589)=~C_1(1589);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;      
            elseif isequal([39 40],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_0(1732)=~C_0(1732);
                 C_0(1804)=~C_0(1804);
                 C_0(1876)=~C_0(1876);
                 C_0(1948)=~C_0(1948);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C_1(1733)=~C_1(1733);
                 C_1(1734)=~C_1(1734);
                 C_1(1877)=~C_1(1877);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;     
             elseif isequal([38 39],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(580)=~C_0(580);
                 C_0(652)=~C_0(652);
                 C_0(724)=~C_0(724);
                 C_0(796)=~C_0(796);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_1(581)=~C_1(581);
                 C_1(582)=~C_1(582);
                 C_1(725)=~C_1(725);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([41 42 43 44],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1732)=~C_0(1732);
                 C_0(1804)=~C_0(1804);
                 C_0(1876)=~C_0(1876);
                 C_0(1948)=~C_0(1948);
                 C_0(2020)=~C_0(2020);
                 C_0(2029)=~C_0(2029);
                 C_0(2164)=~C_0(2164);
                 C_0(2236)=~C_0(2236);
                 C_1(1733)=~C_1(1733);
                 C_1(1734)=~C_1(1734);
                 C_1(1735)=~C_1(1735);
                 C_1(1877)=~C_1(1877);
                 C_1(2021)=~C_1(2021);
                 C_1(2022)=~C_1(2022);
                 C_1(2165)=~C_1(2165);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;        
             elseif isequal([38 41 42],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(4)=~C_0(4);
                 C_0(76)=~C_0(76);
                 C_0(148)=~C_0(148);
                 C_0(220)=~C_0(220);
                 C_0(1444)=~C_0(1444);
                 C_0(1516)=~C_0(1516);
                 C_0(1588)=~C_0(1588);
                 C_0(1660)=~C_0(1660);
                 C_1(5)=~C_1(5);
                 C_1(6)=~C_1(6);
                 C_1(149)=~C_1(149);
                 C_1(1159)=~C_1(1159);
                 C_1(1445)=~C_1(1445);
                 C_1(1446)=~C_1(1446);
                 C_1(1589)=~C_1(1589);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
                 
                 
             elseif isequal([20 21],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(8)=~C_0(8);
                 C_0(9)=~C_0(9);
                 C_0(583)=~C_0(583);
                 C_0(1159)=~C_0(1159);
                 C_0(1160)=~C_0(1160);
                 C_0(1735)=~C_0(1735);
                 C_1(8)=~C_1(8);
                 C_1(1160)=~C_1(1160);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([13 14],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(581)=~C_0(581);
                 C_0(725)=~C_0(725);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_1(582)=~C_1(582);
                 C_1(1158)=~C_1(1158);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([14 15 16 17],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1445)=~C_0(1445);
                 C_0(1589)=~C_0(1589);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_1(1159)=~C_1(1159);
                 C_1(1446)=~C_1(1446);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             elseif isequal([14 15],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(1157)=~C_0(1157);
                 C_0(1301)=~C_0(1301);
                 C_0(1733)=~C_0(1733);
                 C_0(1877)=~C_0(1877);
                 C_1(1158)=~C_1(1158);
                 C_1(1734)=~C_1(1734);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1; 
             elseif isequal([38 39 41 43],error_position)
                 C_0=C0(:,:,path3);
                 C_1=C1(:,:,path3);
                 C_0(868)=~C_0(868);
                 C_0(940)=~C_0(940);
                 C_0(1012)=~C_0(1012);
                 C_0(1084)=~C_0(1084);
                 C_0(1156)=~C_0(1156);
                 C_0(1228)=~C_0(1228);
                 C_0(1300)=~C_0(1300);
                 C_0(1372)=~C_0(1372);
                 C_1(583)=~C_1(583);
                 C_1(869)=~C_1(869);
                 C_1(870)=~C_1(870);
                 C_1(1013)=~C_1(1013);
                 C_1(1157)=~C_1(1157);
                 C_1(1158)=~C_1(1158);
                 C_1(1301)=~C_1(1301);
                 C0(:,:,path3)=C_0;
                 C1(:,:,path3)=C_1;
             end
         end
         C_0=C0(:,:,path3);   
         C_1=C1(:,:,path3);
         for m0=1:length(diffe0) 
             C_0(diffe0(m0))=~C_0(diffe0(m0));
         end
         for m1=1:length(diffe1) 
             C_1(diffe1(m1))=~C_1(diffe1(m1));
         end
         C0(:,:,path3)=C_0;
         C1(:,:,path3)=C_1;   
             
             
        
             
             
             
       
     
             
             
       