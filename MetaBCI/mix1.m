clear;
clc;

num=[87,75,62,50,37,25,12,0];
out = [];
acc1 = [];
load('E:\file\服务器\transform\sub004_01\gazedata\010704.mat');
for i = 1:8
    result = [];
    XY = gazesub01;
    for n = 1:4800
        XY(n,2) = XY(n,2)+50;
    end
    
    for n = 1:4800
        XY(n,1) = ceil((XY(n,1))/240);
        XY(n,2) = ceil((XY(n,2))/270);
        XY(n,3) = (4*(XY(n,2)-1)) + XY(n,1);
    end
    
    countnum=[];
    M1 = [];
    for m = 1:48
        count = 0;
        M = [];
        for n = 100*m-99 : 100*m-num(1,i)
            if XY(n,3) ~= 190
                count = count + 1;
                M1(count,1) = XY(n,1);
                M1(count,2) = XY(n,2);
                M1(count,3) = XY(n,3);
            end
        end
        
        countnum=[countnum,count];
        M = mode(M1(1:count,:),1);
        if isempty(M)
            M = [0,0,0];
        end
        result = [result;M];
    end
    
    pro = [];
    for e = 1:48
        count = 0;
        for j = (100*e-99) : (100*e-num(1,i))
            if XY(j,3) == result(e,3)
                count = count + 1;
            end
        end
        pro(e,:) = count/countnum(1,e);
    end
    
    for f=1:48
        pro(isnan(pro))=0;
    end
    pro(1,2)=(pro(1,1)+pro(2,1)+pro(9,1)+pro(10,1)+pro(17,1)+pro(18,1))/6;
    pro(1,3)=(pro(3,1)+pro(4,1)+pro(11,1)+pro(12,1)+pro(19,1)+pro(20,1))/6;
    pro(1,4)=(pro(5,1)+pro(6,1)+pro(13,1)+pro(14,1)+pro(21,1)+pro(22,1))/6;
    pro(1,5)=(pro(7,1)+pro(8,1)+pro(15,1)+pro(16,1)+pro(23,1)+pro(24,1))/6;
    pro(1,6)=(pro(25,1)+pro(26,1)+pro(33,1)+pro(34,1)+pro(41,1)+pro(42,1))/6;
    pro(1,7)=(pro(27,1)+pro(28,1)+pro(35,1)+pro(36,1)+pro(43,1)+pro(44,1))/6;
    pro(1,9)=(pro(29,1)+pro(30,1)+pro(37,1)+pro(38,1)+pro(45,1)+pro(46,1))/6;
    pro(1,10)=(pro(31,1)+pro(32,1)+pro(39,1)+pro(40,1)+pro(47,1)+pro(48,1))/6;
    
    e='E:\SSVEP\cofandoutput\cof0701';
    b=num2str(i);
    c='.mat';
    d=strcat(strcat(e,b),c);
    load(d);
    cof=double(cof);
    load('E:\SSVEP\TRCA\marksub0101.mat');
    order2=order;
    [~,index2]=sort(order2);
    cof1=cof(index2,:);
    for g =1:48
        cof1(g,7)=max(cof1(g,1:6));
        for h = 1:6
            if cof1(g,h) == cof1(g,7)
                cof1(g,8) = h;
            end
        end
    end
    
    load('E:\眼动数据\SSVEP data\marks\exp\mark0102');
    r=[];
    right = 0;
    for k = 1:48
        r(k,1) = cof1(k,8);
        r(k,2) = result(k,3);
        if r(k,1) == 1 && r(k,2) < 5
            r(k,3) = r(k,2)*2 -1;
        end
        if r(k,1) == 1 && r(k,2) > 4
            r(k,3) = (r(k,2)-4)*2 +23;
        end
        if r(k,1) == 2 && r(k,2) < 5
            r(k,3) = 2*r(k,2);
        end
        if r(k,1) == 2 && r(k,2) > 4
            r(k,3) = 2*(r(k,2)-4)+24;
        end
        if r(k,1) == 3 && r(k,2) < 5
            r(k,3) = r(k,2)*2 + 7;
        end
        if r(k,1) == 3 && r(k,2) >4
            r(k,3) = (r(k,2)-4)*2 + 31;
        end
        if r(k,1) == 4 && r(k,2) <5
            r(k,3) = r(k,2)*2 + 8;
        end
        if r(k,1) == 4 && r(k,2) >4
            r(k,3) = (r(k,2)-4)*2 + 32;
        end
        if r(k,1) == 5 && r(k,2) <5
            r(k,3) = r(k,2)*2 + 15;
        end
        if r(k,1) == 5 && r(k,2) >4
            r(k,3) = (r(k,2)-4)*2 + 39;
        end
        if r(k,1) == 6 && r(k,2) <5
            r(k,3) = r(k,2)*2 + 16;
        end
        if r(k,1) == 6 && r(k,2) >4
            r(k,3) = (r(k,2)-4)*2 + 40;
        end
        
        r(k,4)=order(1,k);
        if r(k,3) == r(k,4)
            r(k,5) = 1;
        else
            r(k,5) = 0;
        end
        if r(k,5) == 1
            right = right + 1;
        end
        
        
        
    end
    acc = right/48;
    
    
    acc1 = [acc1,acc];
end
% acc1 = [acc1,acc];
