function fenge = shuzifenge(imfenge)       %车牌信息为黑色
[y,x]=size(imfenge);
%===============用函数设定分割阈值========================
SS=x*y;         %根据不同的面积设定阈值
if     SS<=20000
    shedingyuzhi=4;
    
elseif SS>20000&&SS<=30000
    shedingyuzhi=4;
elseif SS>30000&&SS<=50000
    shedingyuzhi=4;
    
elseif SS>50000&&SS<=80000
    shedingyuzhi=4;
    
else
    shedingyuzhi=4;
    
end
ganrao=SS/100;
%=========================================================
%定义数组histogram存储X方向的黑点数
histogram=sum(~imfenge);     %转换为白色，统计车牌像素数

figure(12);
plot(1:x,histogram);
%=================文字分割=============================
k=1;
for h=1:x-1
    if  ((histogram(1,h)<=shedingyuzhi)&&(histogram(1,h+1)>shedingyuzhi))||((h==1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h;      %储存分割左边界列数
        k=k+1;
    elseif ((histogram(1,h)>shedingyuzhi)&&(histogram(1,h+1)<=shedingyuzhi))||((h==x-1)&&histogram(1,h)>shedingyuzhi)
        fenge(1,k)=h+1;    %储存分割右边界列数
        k=k+1;
    end
end
k=k-1;%去掉多产生的一个K值
%==============================================
if (sum(histogram(1,fenge(1,1):fenge(1,2)))<ganrao)||((fenge(1,2)-fenge(1,1))<(fenge(1,4)-fenge(1,3))/2)       %如果车牌分割的部分出现了干扰
    for i=3:k                    %去除第一个分割点
        fenge(1,i-2)=fenge(1,i);
    end
end
[~,n]=size(fenge);         %完美分割时，n==14
if  n<14
    msgbox('分割出错','警告');
    sound(audioread('提取出错.wav'),48000);
    pause(1);
end
fenge=fenge(1,1:14);   %只返回十四个分割节点
